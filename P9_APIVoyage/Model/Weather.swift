//
//  Weather.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 29/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import SwiftyJSON

///
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
    var imageSkyCondition: UIImage
    
    ///
    init (json: JSON) {
        let forecastDay = json["item"]["forecast"][0]
        
        temperatureLow = "Min: " + forecastDay["low"].stringValue + "°C "
        temperatureHigh = "Max: " + forecastDay["high"].stringValue + "°C "
        skyCondition = forecastDay["text"].stringValue
        city = json["location"]["city"].stringValue
        imageSkyCondition = #imageLiteral(resourceName: "convert")
    }
}
