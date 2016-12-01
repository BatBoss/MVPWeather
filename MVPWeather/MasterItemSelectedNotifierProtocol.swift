//
//  MasterItemSelectedNotifierProtocol.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

protocol MasterItemSelectedNotifierProtocol : class {
    func subscribeForNotification(subscriber : AnyObject)
    func unsubscribeFromNotification(subscriber : AnyObject)
    func notifySubscribersOfSelectedCity(city : CityWeatherViewModel)
    func unsubscribeAll()
}
