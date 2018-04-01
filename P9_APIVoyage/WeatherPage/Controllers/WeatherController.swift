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

/// Class to handle the weather page
class WeatherController: UITableViewController {
    /// JSON dictonnary who contain all weather information from yahoo
    var weatherJson: JSON?
    /// Image array who contain the sky condition image from yahoo
    var weatherImage = [UIImage]()
    
    // Remove the bottom of the tableView and get the data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        getDataFromYahoo()
    }
    
    /// Update the weather data
    override func viewWillAppear(_ animated: Bool) {
        getDataFromYahoo()
    }
    
    /// Send the request to yahoo to get the weather data
    func getDataFromYahoo() {
        let queryString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text in (\"nantes\",\"ny\")) and u=\"c\""
        
        APIManager.sharedInstance.getWeather(with: queryString) { (jsonDict, error) in
            if error == nil {
                self.weatherJson = jsonDict["query"]["results"]["channel"]
                self.tableView.reloadData()
            } else {
                self.errorPopUp()
            }
        }
    }
    
    /// Format the url of the sky condition image from Yahoo data
    func getImgUrlFromJson(_ json: JSON) -> String {
        var imageDescription = json["item"]["description"].stringValue
        imageDescription = imageDescription.slice(from: "<![CDATA[<img src=\"", to: "\"/>")!
        return imageDescription
    }
    
    /// Show an error pop-up if the API request have a problem
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la récupération de la météo", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.getDataFromYahoo()
        })
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

/// Extension of the UITableViewController to create the weather table view
extension WeatherController {
    
    /// Create the number of section in the table view
    ///
    /// - Parameters:
    ///   - tableView: current table view
    ///   - section: current section index
    /// - Returns: Number of city weather retrieved from JSON
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherJson?.count ?? 0
    }
    
    /// Create the tableview cell with weather data from weather class
    ///
    /// - Parameters:
    ///   - tableView: current table view
    ///   - indexPath: current row index
    /// - Returns: tableview cell created
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData = weatherJson, let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell  else {
            return UITableViewCell()
        }
        
        let weather = Weather(json: weatherData[indexPath.row])
        
        cell.weatherCity.text = weather.city
        cell.weatherTemperature.text = weather.temperatureLow + " / " + weather.temperatureHigh
        cell.weatherSkyCondition.text = weather.skyCondition
        
        APIManager.sharedInstance.getImage(from: self.getImgUrlFromJson(weatherData[indexPath.row])) { (image, error) in
            if error == nil {
                cell.imgWeatherCondition.image = image
            } else {
                self.errorPopUp()
            }
        }
        
        return cell
    }
}
