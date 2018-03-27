//
//  Weather.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 29/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Class to handle weather data from yahoo
class Weather {
    /// String who contain the name of the city
    var city: String
    /// String who contain the low temperature
    var temperatureLow: String
    /// String who contain the high temperature
    var temperatureHigh: String
    /// String who contain the sky condition
    var skyCondition: String
    /// Image from Yahoo who show the sky condiion
    var imageSkyCondition = UIImage()
    
    /// Initialize the weather object with Json value from Yahoo
    /// - Parameter json: Json data from yahoo
    init (json: JSON) {
        let forecastDay = json["item"]["forecast"][0]
        
        temperatureLow = "Min: " + forecastDay["low"].stringValue + "°C "
        temperatureHigh = "Max: " + forecastDay["high"].stringValue + "°C "
        skyCondition = forecastDay["text"].stringValue
        city = json["location"]["city"].stringValue
    }
}
