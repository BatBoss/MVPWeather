//
//  MasterItemSelectedNotifierMock.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 12/1/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class MasterItemSelectedNotifierMock : MasterItemSelectedNotifierProtocol {
    var notifyCalled : Bool = false
    var subscriber : AnyObject?
    var unsubscribeCalled : Bool = false
    
    func subscribeForNotification(subscriber : AnyObject) {
        self.subscriber = subscriber
    }
    
    func unsubscribeFromNotification(subscriber : AnyObject) {
        self.unsubscribeCalled = true
    }
    
    func notifySubscribersOfSelectedCity(city : CityWeatherViewModel) {
        notifyCalled = true
    }
    
    func unsubscribeAll() {
    }
}
