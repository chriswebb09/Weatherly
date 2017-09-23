//
//  DailyForcast.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/16/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct DailyForcast {
    
    let summary: String
    let iconName: String
    
    var forcasts: [DayOfWeek] = []
    init?(json: JSON) {
        
        if let summary = json["summary"] as? String,
            let icon = json["icon"] as? String,
            let data = json["data"] as? [[String: Any]] {
            self.summary = summary
            self.iconName = icon
            for item in data {
                let day = DayOfWeek(json: item)
                if let day = day {
                    forcasts.append(day)
                }
                print(forcasts)
            }
        } else {
            return nil
        }
    }
}
