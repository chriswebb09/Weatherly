//
//  CurrentConditions.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct CurrentConditions {
    
    var iconName: String
    let time: Double
    let summary: String
    let temperature: String
    let precipProbability: Float
    let windSpeed: Double
    let humidity: Double
    
    init?(json: JSON) {
        if let icon = json["icon"] as? String,
            let time = json["time"] as? Double,
            let summary = json["summary"] as? String,
            let temperature = json["temperature"] as? Float,
            let precipProb = json["precipProbability"] as? Float,
            let windSpeed = json["windSpeed"] as? Double,
            let humidity = json["humidity"] as? Double {
            self.iconName = icon
            self.time = time
            self.summary = summary
            self.temperature = String(describing: temperature)
            self.precipProbability = precipProb
            self.windSpeed = windSpeed
            self.humidity = humidity
        } else {
            return nil
        }
    }
}
