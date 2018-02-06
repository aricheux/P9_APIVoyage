//
//  MeteoController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherController: UITableViewController {
    ///
    var weatherJson: JSON?
    ///
    var weatherImage = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromYahoo()
    }
    
    func getDataFromYahoo() {
        let queryString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text in (\"nantes\",\"ny\")) and u=\"c\""
        
        APIManager.sharedInstance.getWeather(with: queryString) { (jsonDict) in
            self.weatherJson = jsonDict["query"]["results"]["channel"]
            
            if let json = self.weatherJson {
                APIManager.sharedInstance.getImage(from: self.getImgUrlFromJson(json[0])) { (image) in
                    self.weatherImage.append(image)
                    APIManager.sharedInstance.getImage(from: self.getImgUrlFromJson(json[1])) { (image) in
                        self.weatherImage.append(image)
                        self.tableView.reloadData()
                        self.tableView.tableFooterView = UIView()
                    }
                }
            }
        }
    }
    
    func getImgUrlFromJson(_ json: JSON) -> String {
        var imageDescription = json["item"]["description"].stringValue
        imageDescription = imageDescription.slice(from: "<![CDATA[<img src=\"", to: "\"/>")!
        return imageDescription
    }
}

extension WeatherController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherJson?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData = weatherJson, let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell  else {
            return UITableViewCell()
        }
        
        let weather = Weather(json: weatherData[indexPath.row])
        
        cell.weatherCity.text = weather.city
        cell.weatherTemperature.text = weather.temperatureLow + " / " + weather.temperatureHigh
        cell.weatherSkyCondition.text = weather.skyCondition
        cell.imgWeatherCondition.image = weatherImage[indexPath.row]
        
        return cell
    }
}
