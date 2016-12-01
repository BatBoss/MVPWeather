//
//  WeatherPresenter.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class WeatherMasterPresenter {    
    private weak var view : WeatherMasterViewProtocol?
    private weak var masterItemSelectedNotifier : MasterItemSelectedNotifierProtocol?
    private weak var weatherDataService : WeatherDataServiceProtocol?
    
    init(weatherMasterView:WeatherMasterViewProtocol, masterItemSelectedNotifier:MasterItemSelectedNotifierProtocol, weatherDataService:WeatherDataServiceProtocol) {
        self.view = weatherMasterView
        self.masterItemSelectedNotifier = masterItemSelectedNotifier
        self.weatherDataService = weatherDataService
        
        self.newCityAdded(cityName: "San Francisco")
        self.newCityAdded(cityName: "New York")
        self.newCityAdded(cityName: "Salt Lake")
    }
    
    func newCityAdded(cityName : String) {
        self.weatherDataService?.getOpenWeatherJsonForCity(cityName: cityName, callback: openWeatherDataCallback)
    }
    
    func citySelected(city: CityWeatherViewModel) {
        if(city.Error == nil) {
            self.masterItemSelectedNotifier?.notifySubscribersOfSelectedCity(city: city)
        }
    }
    
    func addCityToView(weatherModel:CityWeatherViewModel) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                [weak self] in
                self?.view?.addNewCity(city: weatherModel)
            }
        }
        else {
            self.view?.addNewCity(city: weatherModel)
        }

    }
    
    func openWeatherDataCallback(json: [String:Any]?) {
        if let openWeatherJson = json {
            if let coordinates = openWeatherJson["coord"] as? [String:Any] {
                if let rawLat = coordinates["lat"], let rawLong = coordinates["lon"] {
                    let latitude = String(describing: rawLat)
                    let longitude = String(describing: rawLong)
                    
                    self.weatherDataService?.getDarkSkyJsonForCoordinates(latitude: latitude, longitude: longitude, openWeatherData: openWeatherJson, callback: darkSkyDataCallback)
                }
            }
            
        }
    }
    
    func darkSkyDataCallback(json : [String:Any]?, openWeatherJsonData : [String:Any]?) {
        if let darkSkyJson = json, let openWeatherJson = openWeatherJsonData {
            self.addCityToView(weatherModel: self.getWeatherDataFromJson(openWeatherJson: openWeatherJson, darkSkyJson: darkSkyJson))
        }
    }
    
    func getWeatherDataFromJson(openWeatherJson : [String:Any], darkSkyJson : [String:Any]) -> CityWeatherViewModel {
        let city = CityWeatherViewModel()
        
        if let cityName = openWeatherJson["name"] as? String {
            city.CityName = cityName
        }
        
        if let mainData = openWeatherJson["main"] as? [String:Any] {
            if let currentTemp = mainData["temp"] as? Double {
                city.CurrentTemperature = String(describing: currentTemp) + "°F"
            }
        }
        
        if let weatherData = openWeatherJson["weather"] as? [[String:Any]] {
            if weatherData.count > 0 {
                if let iconData = weatherData[0]["icon"] as? String {
                    city.ImageData = self.weatherDataService?.getImageDataForIconName(iconName: iconData)
                }
            }
        }
        
        if let daily = darkSkyJson["daily"] as? [String:Any] {
            if let dailyData = daily["data"] as? [[String:Any]] {
                if dailyData.count > 0 {
                    let todaysData = dailyData[0]
                    
                    if let precipProbability = todaysData["precipProbability"] as? Double, let lowTemp = todaysData["temperatureMin"] as? Double, let highTemp =
                        todaysData["temperatureMax"] as? Double {
                        city.PrecipitationChance = String(format: "%.0f", precipProbability * 100) + "%"
                        city.LowTemperature = String(describing: lowTemp) + "°F"
                        city.HighTemperature = String(describing: highTemp) + "°F"
                    }
                }
            }
        }
        
        return city;
    }
}
