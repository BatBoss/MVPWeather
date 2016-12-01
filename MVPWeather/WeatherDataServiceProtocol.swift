//
//  WeatherDataServiceProtocol.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

protocol WeatherDataServiceProtocol : class {
    func getOpenWeatherJsonForCity(cityName: String, callback : @escaping ([String:Any]?) -> Void)
    func getDarkSkyJsonForCoordinates(latitude: String, longitude : String, openWeatherData : [String:Any]?, callback : @escaping ([String:Any]?, [String:Any]?) -> Void)
    func getImageDataForIconName(iconName: String) -> Data?
}
