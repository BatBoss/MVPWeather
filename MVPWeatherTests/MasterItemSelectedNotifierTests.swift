//
//  MasterItemSelectedNotifierTests.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation
import XCTest

@testable import MVPWeather

class MasterItemSelectedNotifierTests: XCTestCase {
    
    var testObject : MasterItemSelectedNotifier = MasterItemSelectedNotifier.sharedInstance
    
    var goodSubscriber1 : Subscriber!
    var goodSubscriber2 : Subscriber!
    var badSubscriber : BadSubscriber!
    
    override func setUp() {
        super.setUp()

        testObject.unsubscribeAll()
        goodSubscriber1 = Subscriber()
        goodSubscriber2  = Subscriber()
        badSubscriber = BadSubscriber()
    }
    
    func testUnsubscribeAll() {
        XCTAssert(testObject.subscribers.count == 0)
        
        testObject.subscribeForNotification(subscriber: goodSubscriber1)
        testObject.subscribeForNotification(subscriber: goodSubscriber2)
        
        XCTAssert(testObject.subscribers.count == 2)
        
        testObject.unsubscribeAll()
        
        XCTAssert(testObject.subscribers.count == 0)
    }
    
    func testSubscribe() {
        testObject.subscribeForNotification(subscriber: goodSubscriber1)
        
        XCTAssert(testObject.subscribers.count == 1)
    }
    
    func testUnsubscribe() {
        testObject.subscribeForNotification(subscriber: goodSubscriber1)
        
        testObject.unsubscribeFromNotification(subscriber: goodSubscriber2)
        
        XCTAssert(testObject.subscribers.count == 1)
        
        testObject.unsubscribeFromNotification(subscriber: goodSubscriber1)
        
        XCTAssert(testObject.subscribers.count == 0)
    }
    
    func testCantSubscribeWithoutProtocol() {
        testObject.subscribeForNotification(subscriber: badSubscriber)
        
        XCTAssert(testObject.subscribers.count == 0)
    }
    
    func testNotify() {
        let testCity1 = CityWeatherViewModel()
        let testCity2 = CityWeatherViewModel()
        
        testObject.subscribeForNotification(subscriber: goodSubscriber1)
        testObject.subscribeForNotification(subscriber: goodSubscriber2)
        
        testObject.notifySubscribersOfSelectedCity(city: testCity1)
        
        XCTAssert(testCity1 === goodSubscriber1.myCity)
        XCTAssert(testCity1 === goodSubscriber2.myCity)
        
        testObject.unsubscribeFromNotification(subscriber: goodSubscriber1)
        testObject.notifySubscribersOfSelectedCity(city: testCity2)
        
        XCTAssert(testCity1 === goodSubscriber1.myCity)
        XCTAssert(testCity2 === goodSubscriber2.myCity)
    }
}

class Subscriber : MasterItemSelectedObserverProtocol {
    var myCity : CityWeatherViewModel?
    
    func newSelectedCity(city: CityWeatherViewModel) {
        myCity = city
    }
}

class BadSubscriber {
    var myCity : CityWeatherViewModel?
    
    func newSelectedCity(city: CityWeatherViewModel) {
        myCity = city
    }
}
    
