//
//  WeatherTableViewCell.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 27/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

/// Class to customize the UITableViewCell with storyboard connexion
class WeatherTableViewCell: UITableViewCell {
    /// Image who contain the sky condition
    @IBOutlet weak var imgWeatherCondition: UIImageView!
    /// Label who contain the name of the city
    @IBOutlet weak var weatherCity: UILabel!
    /// Label who contain the minimum and maximum temperature
    @IBOutlet weak var weatherTemperature: UILabel!
    /// Label who contain the decription of the sky condition
    @IBOutlet weak var weatherSkyCondition: UILabel!
}
