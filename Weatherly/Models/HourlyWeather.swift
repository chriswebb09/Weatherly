//
//  HourlyWeather.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct HourlyWeather {
    
    let time: Double
    let apparentTemp: String
    
    init?(json: JSON) {
        if let time = json["time"] as? Double,
            let apparentTemp = json["apparentTemperature"] as? Float {
            self.time = time
            self.apparentTemp = String(describing: apparentTemp)
        } else {
            return nil
        }
    }
}
