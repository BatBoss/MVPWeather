//
//  MasterItemSelectedNotifier.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class MasterItemSelectedNotifier : MasterItemSelectedNotifierProtocol {
    public static let sharedInstance = MasterItemSelectedNotifier()
    var subscribers = [AnyObject]()
    
    private init() {}
    
    public func subscribeForNotification(subscriber : AnyObject) {
        if let _ = subscriber as? MasterItemSelectedObserverProtocol {
            self.subscribers.append(subscriber)
        }
    }
    
    public func unsubscribeFromNotification(subscriber : AnyObject) {
        self.subscribers = subscribers.filter({ $0 !== subscriber })
    }
    
    public func notifySubscribersOfSelectedCity(city : CityWeatherViewModel) {
        for subscriber in subscribers {
            if let notifiable = subscriber as? MasterItemSelectedObserverProtocol {
                notifiable.newSelectedCity(city: city)
            }
        }
    }
    
    public func unsubscribeAll() {
        subscribers = [AnyObject]()
    }
}
