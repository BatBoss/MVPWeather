//
//  WeatherMasterPresenterTests.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

import XCTest
@testable import MVPWeather

class WeatherMasterPresenterTests: XCTestCase {
    
    var mockDataService : WeatherDataServiceMock!
    var mockView : WeatherMasterViewControllerMock!
    var mockNotifier : MasterItemSelectedNotifierMock!
    var testObject : WeatherMasterPresenter!
    
    let goodOpenWeatherJson : [String:Any] = [
        "name" : "Gotham City",
        "main" : ["temp" : 32.32],
        "weather" : ["icon" : "stormy"],
        "coord" : ["lat" : 42.1231231,
                   "lon" : 78.323232]]
    
    let goodDarkSkyJson : [String:Any] = [
        "daily" : [
            "data" : [
                    ["precipProbability": 0.90,
                     "temperatureMin": 16.10,
                     "temperatureMax":40.42],
                    ["precipProbability": 0.20,
                     "temperatureMin": 10.10,
                     "temperatureMax":35.42]
                ]
        ]
    ]
    
    override func setUp() {
        super.setUp()
        mockDataService = WeatherDataServiceMock()
        mockView = WeatherMasterViewControllerMock()
        mockNotifier = MasterItemSelectedNotifierMock()
        testObject = WeatherMasterPresenter(weatherMasterView: mockView, masterItemSelectedNotifier: mockNotifier, weatherDataService: mockDataService)
    }
    
    func testGoodDataWorks() {
        mockDataService.mockData = Data(base64Encoded: "dummyencoding")
        
        testObject.darkSkyDataCallback(json: goodDarkSkyJson, openWeatherJsonData: goodOpenWeatherJson)
        
        if let result = mockView.resultCity {
            XCTAssertEqual(result.CityName, "Gotham City")
            XCTAssertNotNil(result.CurrentTemperature.range(of: "32.32"))
            XCTAssertNil(result.Error)
            XCTAssertNotNil(result.HighTemperature.range(of: "40.42"))
            XCTAssertNotNil(result.LowTemperature.range(of: "16.1"))
            XCTAssertNotNil(result.PrecipitationChance.range(of: "90"))
            XCTAssertEqual(result.ImageData, mockDataService?.mockData)
        }
        else {
            XCTFail()
        }

    }
    
    func testDefaultCitiesAdded() {
        XCTAssert(mockDataService.citiesAdded.contains(where: { $0 == "New York" }))
        XCTAssert(mockDataService.citiesAdded.contains(where: { $0 == "San Francisco" }))
        XCTAssert(mockDataService.citiesAdded.contains(where: { $0 == "Salt Lake" }))
    }
    
    func testNotifyDoesntGetCalledIfError() {
        let testCity = CityWeatherViewModel()
        testCity.Error = "oh no"
        
        testObject.citySelected(city: testCity)
        
        XCTAssert(!mockNotifier.notifyCalled)
    }
    
    func testNotifyCalledIfNoError() {
        testObject.citySelected(city: CityWeatherViewModel())
        
        XCTAssert(mockNotifier.notifyCalled)
    }
    
    func testLatLonParsing() {
        testObject.openWeatherDataCallback(json: goodOpenWeatherJson)
        
        XCTAssertEqual(mockDataService.darkSkyLat, "42.1231231")
        XCTAssertEqual(mockDataService.darkSkyLon, "78.323232")
    }
    
    
    
    
    
    
    
    
    
    
    
}
