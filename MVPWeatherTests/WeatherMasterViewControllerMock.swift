//
//  WeatherMasterViewControllerMock.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class WeatherMasterViewControllerMock : WeatherMasterViewProtocol {
    
    var resultCity : CityWeatherViewModel?
    
    func addNewCity(city: CityWeatherViewModel) {
        resultCity = city
    }
}
