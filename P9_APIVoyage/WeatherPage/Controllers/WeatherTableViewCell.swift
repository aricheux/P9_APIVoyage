//
//  WeatherTableViewCell.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 27/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    ///
    @IBOutlet weak var imgWeatherCondition: UIImageView!
    
    ///
    @IBOutlet weak var weatherCity: UILabel!
    
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var weatherSkyCondition: UILabel!
}
