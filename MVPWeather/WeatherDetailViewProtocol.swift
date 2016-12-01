//
//  WeatherDetailViewProtocol.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

protocol WeatherDetailViewProtocol : class {
    var selectedCity: CityWeatherViewModel? { get set }
}
