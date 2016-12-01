//
//  WeatherDetailPresenterTests.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

import XCTest
@testable import MVPWeather

class WeatherDetailPresenterTests: XCTestCase {
    
    var mockView : WeatherDetailViewControllerMock!
    var mockNotifier : MasterItemSelectedNotifierMock!
    var testObject : WeatherDetailPresenter?
    
    override func setUp() {
        super.setUp()
        mockView = WeatherDetailViewControllerMock()
        mockNotifier = MasterItemSelectedNotifierMock()
        testObject = WeatherDetailPresenter(weatherDetailView: mockView, masterItemSelectedNotifier: mockNotifier)
    }
    
    func testSubscribeGetsCalled() {
        XCTAssertNotNil(testObject)
        XCTAssert(testObject === mockNotifier.subscriber)
    }
    
    func testUnsubscribeGetsCalled() {
        testObject = nil
        mockNotifier.subscriber = nil
        
        XCTAssert(mockNotifier.unsubscribeCalled)
    }
    
    func testSettingCityWorks() {
        let testCity = CityWeatherViewModel()
        
        testObject?.newSelectedCity(city: testCity)
        
        XCTAssert(testCity === mockView.selectedCity)
    }
}
