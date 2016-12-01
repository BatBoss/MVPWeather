//
//  WeatherModel.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class CityWeatherViewModel {
    var CityName : String = ""
    var CurrentTemperature: String = ""
    var HighTemperature : String = ""
    var LowTemperature : String = ""
    var PrecipitationChance: String = ""
    var Error : String? = nil
    var ImageData : Data? = nil
}
