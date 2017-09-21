//
//  WeatherAPI.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum Response {
    case success(JSON?), failed(Error)
}

enum URLRouter {
    
    case base
    
    var url: String {
        switch self {
        case .base:
            return "https://api.darksky.net/forecast/"
        }
    }
}

class DarkSkyAPI {
    
    static func search(for query: String, _ completion: @escaping (Response) -> Void) {
        let urlString = URLRouter.base.url + Secrets.secretKey + query
        guard let url = URL(string: urlString) else { return }
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failed(error))
            } else {
                do {
                    guard let data = data else { return }
                    guard let responseObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON else { return }
                    DispatchQueue.main.async {
                        completion(.success(responseObject))
                    }
                }
            }}.resume()
    }
}

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
