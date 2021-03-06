//
//  DayOfWeek.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct DayOfWeek {
    
    var highTempTime: Double
    var lowTempTime: Double
    var iconName: String
    var sunriseTime: Double
    var sunset: Double
    var lowTemp: String
    var highTemp: String
    var precipProbability: Float
    var time: Double
    var humidity: Double
    var windSpeed: Double
    var cloudCover: Double
    var summary: String
    var stringDate: String
    
    init?(json: JSON) {
        
        if let summary = json["summary"] as? String,
            let highTime = json["temperatureHighTime"] as? Double,
            let lowTime = json["temperatureLowTime"] as? Double,
            let sunsetTime = json["sunsetTime"] as? Double,
            let lowTemp = json["temperatureLow"] as? Float,
            let highTemp = json["temperatureHigh"] as? Float,
            let precipProb = json["precipProbability"] as? Float,
            let sunriseTime = json["sunriseTime"] as? Double,
            let icon = json["icon"] as? String,
            let time = json["time"] as? Double,
            let humidity = json["humidity"] as? Double,
            let windSpeed = json["windSpeed"] as? Double,
            let cloudCover = json["cloudCover"] as? Double {
            
            self.highTempTime = highTime
            self.lowTempTime = lowTime
            self.summary = summary
            self.sunset = sunsetTime
            self.lowTemp = String(describing: Int(lowTemp))
            self.highTemp = String(describing: Int(highTemp))
            self.precipProbability = precipProb
            self.sunriseTime = sunriseTime
            self.iconName = icon
            self.time = time
            self.humidity = humidity
            self.windSpeed = windSpeed
            self.cloudCover = cloudCover
            let day = Date(timeIntervalSince1970:time)
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            stringDate = formatter.string(from: day as Date)
        } else {
            return nil
        }
    }
}
