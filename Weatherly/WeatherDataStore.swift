//
//  WeatherDataStore.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherConditionDataStoreDelegate: class {
    func store(didSet weatherIcon: UIImage)
    func store(didSet currentConditions: String)
    func store(hasSet currentTemperature: String)
    func store(hasSet dailyForcasts: [DayOfWeek])
}

class WeatherConditionsDataStore {
    
    weak var delegate: WeatherConditionDataStoreDelegate?
    
    var locationFetch: Bool = false
    
    var icons: [String: UIImage] = [
        "clear-day": #imageLiteral(resourceName: "clear-day"),
        "clear-night": #imageLiteral(resourceName: "partlysunny"),
        "rain": #imageLiteral(resourceName: "rain"),
        "partly-cloudy-day": #imageLiteral(resourceName: "partlysunny"),
        "partly-cloudy-night": #imageLiteral(resourceName: "partlysunny")
    ]
    
    var currentLocation: CLLocation! {
        didSet {
            if !locationFetch {
                getWeatherConditions()
                locationFetch = true
            }
        }
    }
    
    var hourly: [HourlyWeather] = []
    
    var current: [CurrentConditions] = [] {
        didSet {
            delegate?.store(didSet: icons[current[0].iconName]!)
            delegate?.store(didSet: current[0].summary)
            delegate?.store(hasSet: current[0].temperature)
        }
    }
    
    var daily: [DailyForcast] = [] {
        didSet {
            delegate?.store(hasSet: daily[0].forcasts)
        }
    }
    
    var requested = false
    
    func getWeatherConditions() {
        let locationString = "/\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        if requested == false {
            DarkSkyAPI.search(for: locationString) { response in
                switch response {
                case .success(let json):
                    guard let json = json else { return }
                    self.current = WeatherParser.parseCurrent(json: json)
                    self.hourly = WeatherParser.parseHourly(json: json)
                    self.daily = WeatherParser.parseDaily(json: json)
                case .failed(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
