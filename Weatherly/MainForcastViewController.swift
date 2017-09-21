//
//  ViewController.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherConditionsDataStore {
    
    var currentLocation: CLLocation! {
        didSet {
            getWeatherConditions()
        }
    }
    
    var hourly: [HourlyWeather] = []
    var current: [CurrentConditions] = []
    var daily: [DailyForcast] = [] 
    var requested = false
    
    func getWeatherConditions() {
        if requested == false {
            let locationString = "/\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
            DarkSkyAPI.search(for: locationString) { response in
                switch response {
                case .success(let json):
                    if let json = json {
                        self.current = WeatherParser.parseCurrent(json: json)
                        self.hourly = WeatherParser.parseHourly(json: json)
                        self.daily = WeatherParser.parseDaily(json: json)
                    }
                case .failed(let error):
                    print(error.localizedDescription)
                }
            }
            requested = true
        }
    }
}

class MainForcastViewController: UIViewController {
    
    let store = WeatherConditionsDataStore()
  
    var requested = false
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MainForcastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sortedLocationEstimates = locations.sorted(by: {
            if $0.horizontalAccuracy == $1.horizontalAccuracy {
                return $0.timestamp > $1.timestamp
            }
            return $0.horizontalAccuracy < $1.horizontalAccuracy
        })
        store.currentLocation = sortedLocationEstimates.first!
        print(store.current)
        print("\n")
        print(store.daily)
        print("\n")
        print(store.hourly)
    }
}
