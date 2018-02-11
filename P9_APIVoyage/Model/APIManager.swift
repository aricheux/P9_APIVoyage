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

extension String {
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

class APIManager {
    static let sharedInstance = APIManager()
    
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
    
    func createYahooUrl(with query: String) -> URL? {
        let QUERY_PREFIX = "http://query.yahooapis.com/v1/public/yql?q="
        let QUERY_SUFFIX = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        
        let url = URL(string: "\(QUERY_PREFIX)\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\(QUERY_SUFFIX)")
        
        return url
    }
    
    func doTranslation(with param: Parameters, completion: @escaping (JSON, Error?) -> ()) {
        let gcloud_Key = "AIzaSyAKk9DZiflKL_2kME9R1Wd4ifXvSrwGaDg"
        
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
}
