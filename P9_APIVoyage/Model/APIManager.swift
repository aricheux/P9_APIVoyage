//
//  APIManager.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 20/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

/// Class to handle the API calling
class APIManager {
    /// Share the APIManager to all project, no need to create object in code
    static let sharedInstance = APIManager()
    /// Google cloud key to send the request to google translation
    let gcloud_Key = "AIzaSyAKk9DZiflKL_2kME9R1Wd4ifXvSrwGaDg"
    
    /// Get data from URL and handle the result
    ///
    /// - Parameters:
    ///   - URLString: contain the website url to request
    ///   - completion: if success, JSON data is return in completion
    func getData(from URLString: String, completion: @escaping (JSON, Error?) -> ()) {
        Alamofire.request(URLString).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let reponse = response.result.value {
                    completion(JSON(reponse), nil)
                }
            case .failure(let error):
                completion(JSON.null, error)
            }
        }
    }
    
    /// Get the translation from google translate
    ///
    /// - Parameters:
    ///   - param: contain target language and text for the translation
    ///   - completion: if success, JSON data is return in completion
    func doTranslation(with param: Parameters, completion: @escaping (JSON, Error?) -> ()) {
        let urlString = "https://translation.googleapis.com/language/translate/v2?key=" + gcloud_Key
        
        Alamofire.request(urlString, method: .post, parameters: param,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let reponse = response.result.value {
                    completion(JSON(reponse), nil)
                }
            case .failure(let error):
                completion(JSON.null, error)
            }
        }
    }
    
    /// Get the source language of the current text
    ///
    /// - Parameters:
    ///   - param: contain current text for the translation
    ///   - completion: if success, JSON data is return in completion
    func detectLanguage(with param: Parameters, completion: @escaping (JSON, Error?) -> ()) {
        let urlString = "https://translation.googleapis.com/language/translate/v2/detect?key=" + gcloud_Key
        
        Alamofire.request(urlString, method: .post, parameters: param,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let reponse = response.result.value {
                    completion(JSON(reponse), nil)
                }
            case .failure(let error):
                completion(JSON.null, error)
            }
        }
    }
    
    /// Get weather data grom yahoo url
    ///
    /// - Parameters:
    ///   - query: formatted query with information needed from the controller
    ///   - completion: if success, JSON data is return in completion
    func getWeather(with query: String, completion: @escaping (JSON, Error?) -> ()) {
        if let url = createYahooUrl(with: query) {
            Alamofire.request(url).validate().responseJSON { response in
                switch response.result {
                case .success:
                    if let reponse = response.result.value {
                        completion(JSON(reponse), nil)
                    }
                case .failure(let error):
                    completion(JSON.null, error)
                }
            }
        }
    }
    
    /// Get sky condition image from yahoo
    ///
    /// - Parameters:
    ///   - url: contain the url for the image data
    ///   - completion: if success, JSON data is return in completion
    func getImage(from url: String, completion: @escaping (UIImage, Error?) -> ()) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success:
                if let image = response.result.value {
                    completion(image, nil)
                }
            case .failure(let error):
                completion(UIImage(), error)
            }
        }
    }
    
    /// Create an url with yahoo query parameter to request data
    ///
    /// - Parameter query: formatted query with information needed from the controller
    /// - Returns: formatted url with query yahoo data
    func createYahooUrl(with query: String) -> URL? {
        let QUERY_PREFIX = "http://query.yahooapis.com/v1/public/yql?q="
        let QUERY_SUFFIX = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        
        let url = URL(string: "\(QUERY_PREFIX)\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\(QUERY_SUFFIX)")
        
        return url
    }
}
