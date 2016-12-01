//
//  WeatherDataService.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class WeatherDataService : WeatherDataServiceProtocol {
    public static let sharedInstance = WeatherDataService()
    
    private let apiKey = "&APPID=d45ea55f23b8bc429c6eef5b33ad89f2"
    private let units = "&units=imperial"
    private let apiURL = "http://api.openweathermap.org/data/2.5/weather?q="
    private let imageURL = "http://openweathermap.org/img/w/"
    
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    private let darkSkyAPIKey = "2c29fa763b38b7353938a0a2d3dccd1a"
    
    private init() {}
    
    public func getOpenWeatherJsonForCity(cityName: String, callback : @escaping ([String:Any]?) -> Void) {
        var urlString : String = apiURL + cityName + apiKey + units
        urlString = urlString.replacingOccurrences(of: " ", with: "")
        let url = URL(string: urlString)
        
        if let validUrl = url {
            let task = URLSession.shared.dataTask(with: validUrl, completionHandler: {(data, response, error) in
                if(error != nil) {
                    callback(nil)
                    return
                }
                    
                callback(try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any])
            })
            
            task.resume()
        }
        else {
            callback(nil)
            return
        }
    }
    
    public func getDarkSkyJsonForCoordinates(latitude: String, longitude : String, openWeatherData : [String:Any]?, callback : @escaping ([String:Any]?, [String:Any]?) -> Void) {
        let url = URL(string: darkSkyURL + darkSkyAPIKey + "/" + latitude + "," + longitude)
        
        if let resolvedUrl = url {
            let task = URLSession.shared.dataTask(with: resolvedUrl, completionHandler: {(data, response, error) in
                if(error != nil) {
                    callback(nil, nil)
                    return
                }
                    
                callback(try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any], openWeatherData)
            })
            task.resume()
        }
        else {
            callback(nil, nil)
            return
        }
    }
    
    public func getImageDataForIconName(iconName: String) -> Data? {
        let url = URL(string: self.imageURL + iconName + ".png")
        
        if let resolvedUrl = url {
            return try? Data(contentsOf: resolvedUrl)
        }
        return nil
    }
}
