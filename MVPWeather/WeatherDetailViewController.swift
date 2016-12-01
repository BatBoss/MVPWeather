//
//  WeatherDetailViewController.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController, WeatherDetailViewProtocol {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var precipChanceLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    let defaultText = "Click a city to see its data"
    let highTempPrefix = "High Temperature: "
    let lowTempPrefix = "Low Temperature: "
    let precipChancePrefix = "Precipitation Chance: "
    let currentTempPrefix = "Current Temperature: "
    
    var presenter : WeatherDetailPresenter!

    func configureView() {
        if let city = self.selectedCity {
            if let label = self.detailDescriptionLabel {
                label.text = ""
            }
            
            if let cityName = self.cityNameLabel {
                cityName.text = city.CityName
            }
            
            if let highTemp = self.highTempLabel {
                highTemp.text = highTempPrefix + city.HighTemperature
            }
            
            if let lowTemp = self.lowTempLabel {
                lowTemp.text = lowTempPrefix + city.LowTemperature
            }
            
            if let precip = self.precipChanceLabel {
                precip.text = precipChancePrefix + city.PrecipitationChance
            }
            
            if let currentTemp = self.currentTempLabel {
                currentTemp.text = currentTempPrefix + city.CurrentTemperature
            }
            
            if let weatherIcon = self.weatherIcon, let imageData = city.ImageData {
                weatherIcon.image = UIImage(data:imageData)
            }
        }
        else {
            if let label = self.detailDescriptionLabel {
                label.text = defaultText
            }
            
            if let cityName = self.cityNameLabel {
                cityName.text = ""
            }
            
            if let highTemp = self.highTempLabel {
                highTemp.text = ""
            }
            
            if let lowTemp = self.lowTempLabel {
                lowTemp.text = ""
            }
            
            if let precip = self.precipChanceLabel {
                precip.text = ""
            }
            
            if let currentTemp = self.currentTempLabel {
                currentTemp.text = ""
            }
            
            if let weatherIcon = self.weatherIcon {
                weatherIcon.image = nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        self.presenter = WeatherDetailPresenter(weatherDetailView: self, masterItemSelectedNotifier: MasterItemSelectedNotifier.sharedInstance)
    }

    var selectedCity: CityWeatherViewModel? {
        didSet {
            self.configureView()
        }
    }


}

