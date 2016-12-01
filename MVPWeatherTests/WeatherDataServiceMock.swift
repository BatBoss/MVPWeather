//
//  WeatherDataServiceMock.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class WeatherDataServiceMock : WeatherDataServiceProtocol {
    
    public var mockData : Data?
    
    public var citiesAdded = [String]()
    public var darkSkyLat = ""
    public var darkSkyLon = ""
    
    func getOpenWeatherJsonForCity(cityName: String, callback : @escaping ([String:Any]?) -> Void) {
        citiesAdded.append(cityName)
    }
    
    func getDarkSkyJsonForCoordinates(latitude: String, longitude : String, openWeatherData : [String:Any]?, callback : @escaping ([String:Any]?, [String:Any]?) -> Void) {
        darkSkyLat = latitude
        darkSkyLon = longitude
    }
    
    func getImageDataForIconName(iconName: String) -> Data? {
        return mockData
    }
}
