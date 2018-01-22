//
//  APIManager.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 20/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation

class APIManager {
    static let sharedInstance = APIManager()
    
    func getData(URLString: String, completion: @escaping (Bool, AnyObject?) -> ()) {
        
        let url = URL(string: URLString)
        let request = URLRequest(url: url!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200{
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        })
        task.resume()
    }
}
