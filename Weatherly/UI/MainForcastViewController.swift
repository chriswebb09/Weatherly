//
//  ViewController.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreLocation

class MainForcastViewController: UIViewController, Controller {
    
    var type: ControllerType = .app
    
    @IBOutlet var forcastView: MainForcastView!
    
    let store = WeatherConditionsDataStore()
    
    var current: [CurrentConditions]! {
        didSet {
            self.forcastView.collectionView.reloadData()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var dailyForcast: [DayOfWeek]! {
        didSet {
            DispatchQueue.main.async {
                self.forcastView.collectionView.reloadData()
            }
        }
    }
    
    var requested = false
    var locationManager: CLLocationManager!
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forcastView.collectionView.delegate = self
        forcastView.collectionView.dataSource = self
        forcastView.layoutSubviews()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        forcastView.setCurrentTemp(temp: "50°")
        forcastView.setWeatherDescription(description: "Partly sunny skies.")
        store.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension MainForcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyForcastCell", for: indexPath) as! DailyForcastCell
        
        if let daily = dailyForcast {
            cell.weatherImageView.image = self.store.icons[daily[indexPath.row].iconName]
            cell.dayNameLabel.text = "\(daily[indexPath.row].stringDate)"
            cell.temperatureLabel.text = "\(daily[indexPath.row].highTemp)°"
        } else {
            cell.weatherImageView.image = #imageLiteral(resourceName: "partlysunny")
            cell.dayNameLabel.text = "\(days[indexPath.row])"
            cell.temperatureLabel.text = "80°"
        }
        
        cell.layer.setCellShadow(contentView: cell.contentView)
        cell.layoutSubviews()
        return cell 
    }
}

extension MainForcastViewController: UICollectionViewDelegate, WeatherConditionDataStoreDelegate {
    
    func store(hasSet dailyForcasts: [DayOfWeek]) {
        self.dailyForcast = dailyForcasts
    }
    
    func store(hasSet currentTemperature: String) {
        forcastView.setCurrentTemp(temp: "\(currentTemperature)°")
    }
    
    func store(didSet currentConditions: String) {
        forcastView.setWeatherDescription(description: currentConditions)
    }
    
    func store(didSet weatherIcon: UIImage) {
        forcastView.setWeatherIcon(icon: weatherIcon)
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
        current = store.current
    }
}
