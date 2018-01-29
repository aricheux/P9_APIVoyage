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
    
    var weatherResult: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        let queryString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text in (\"nantes\",\"ny\")) and u=\"c\""
        
        APIManager.sharedInstance.getWeather(with: queryString) { (jsonDict) in
            self.weatherResult = jsonDict["query"]["results"]["channel"]
            print(self.weatherResult)
            self.tableView.reloadData()
        }
    }

}

extension WeatherController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherResult?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData = weatherResult, let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WeatherTableViewCell.")
        }
        
        let forecastDay = weatherData[indexPath.row]["item"]["forecast"][0]
        let temperatureLow = forecastDay["low"].stringValue + "°C "
        let temperatureHigh = forecastDay["high"].stringValue + "°C "
        let skyCondition = forecastDay["text"].stringValue
        let cityName = weatherData[indexPath.row]["location"]["city"].stringValue
        
        cell.textLabel?.text = cityName
        cell.cellLabel.text = "min: " + temperatureLow + "max: " + temperatureHigh
        
        return cell
    }
}
