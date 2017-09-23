//
//  WeatherParser.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class WeatherParser {
    
    static func parseCurrent(json: JSON) -> [CurrentConditions] {
        let currentForcast: [CurrentConditions] = []
        guard let current = json["currently"] as? [String: Any] else { return currentForcast  }
        if let currentConditions = CurrentConditions(json: current) {
            return [currentConditions]
        }
        return currentForcast
    }
    
    static func parseDaily(json: JSON) -> [DailyForcast] {
        
        let dailyForcast: [DailyForcast] = []
        guard let daily = json["daily"] as? [String: Any] else { return dailyForcast }
        if let dailyConditions = DailyForcast(json: daily) {
            return [dailyConditions]
        }
        return dailyForcast
    }
    
    static func parseHourly(json: JSON) -> [HourlyWeather] {
        var hourlyWeather: [HourlyWeather] = []
        guard let hourly = json["hourly"] as? [String: Any], let hourlyData = hourly["data"] as? [[String: Any]]  else { return hourlyWeather }
        for data in hourlyData {
            guard let hourlyConditions = HourlyWeather(json: data) else { return hourlyWeather }
            hourlyWeather.append(hourlyConditions)
            print(hourlyWeather)
        }
        return hourlyWeather
    }
}
