//
//  Weather.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 29/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {
    ///
    var city: String
    ///
    var temperatureLow: String
    ///
    var temperatureHigh: String
    ///
    var skyCondition: String

    ///
    init (json: JSON) {
        let currentDay = 0
        let forecastDay = json["item"]["forecast"][currentDay]
        
        temperatureLow = forecastDay["low"].stringValue + "°C "
        temperatureHigh = forecastDay["high"].stringValue + "°C "
        skyCondition = forecastDay["text"].stringValue
        city = json["location"]["city"].stringValue
    }
    
}
