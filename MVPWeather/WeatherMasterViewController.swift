//
//  WeatherMasterViewController.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import UIKit

class WeatherMasterViewController: UITableViewController, WeatherMasterViewProtocol {

    var cities = [CityWeatherViewModel]()
    var presenter : WeatherMasterPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.presenter = WeatherMasterPresenter(weatherMasterView: self, masterItemSelectedNotifier:MasterItemSelectedNotifier.sharedInstance, weatherDataService:WeatherDataService.sharedInstance)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func addButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add", message: "Enter a city name", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] (action) -> Void in
            if let textFields = alert.textFields {
                if(textFields.count > 0) {
                    if let text = textFields[0].text {
                        self?.presenter.newCityAdded(cityName: text)
                    }
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewCity(city: CityWeatherViewModel) {
        cities.insert(city, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let city = cities[indexPath.row]
        if let error = city.Error {
            cell.textLabel?.text = error
        }
        else {
            cell.textLabel?.text = city.CityName + " " + city.CurrentTemperature
            if let imageData = city.ImageData {
                cell.imageView?.image = UIImage(data:imageData)
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        self.presenter.citySelected(city: city)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

