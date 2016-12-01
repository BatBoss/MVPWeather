//
//  WeatherDetailPresenter.swift
//  MVPWeather
//
//  Created by Trevor Andersen on 11/30/16.
//  Copyright © 2016 Control4. All rights reserved.
//

import Foundation

class WeatherDetailPresenter : MasterItemSelectedObserverProtocol {
    private weak var view : WeatherDetailViewProtocol?
    private weak var masterItemSelectedNotifier : MasterItemSelectedNotifierProtocol?
    
    init(weatherDetailView:WeatherDetailViewProtocol, masterItemSelectedNotifier : MasterItemSelectedNotifierProtocol) {
        self.view = weatherDetailView
        self.masterItemSelectedNotifier = masterItemSelectedNotifier
        self.masterItemSelectedNotifier?.subscribeForNotification(subscriber: self)
    }
    
    deinit {
        masterItemSelectedNotifier?.unsubscribeFromNotification(subscriber: self)
    }
    
    func newSelectedCity(city: CityWeatherViewModel) {
        view?.selectedCity = city
    }
}
