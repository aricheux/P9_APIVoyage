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

///
class WeatherController: UITableViewController {
    ///
    var weatherJson: JSON?
    ///
    var weatherImage = [UIImage]()
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        getDataFromYahoo()
    }
    ///
    override func viewWillAppear(_ animated: Bool) {
        getDataFromYahoo()
    }
    ///
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
    ///
    func getImgUrlFromJson(_ json: JSON) -> String {
        var imageDescription = json["item"]["description"].stringValue
        imageDescription = imageDescription.slice(from: "<![CDATA[<img src=\"", to: "\"/>")!
        return imageDescription
    }
    ///
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la récupération de la météo", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.getDataFromYahoo()
        })
        
        self.present(alertVC, animated: true, completion: nil)
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
