//
//  APIManager.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 20/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    static let sharedInstance = APIManager()
    
    func getData(from URLString: String, completion: @escaping (JSON) -> ()) {
        Alamofire.request(URLString).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let reponse = response.result.value {
                    completion(JSON(reponse))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
