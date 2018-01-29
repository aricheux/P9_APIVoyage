//
//  TranslateViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import Alamofire

class TranslationController: UIViewController {
    
    @IBOutlet weak var initialText: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doTranslation() {
        if let initialText = initialText.text {
            let parameters: Parameters = [
                "q": "\(initialText)",
                "target": "en"
            ]
            
            APIManager.sharedInstance.doTranslation(with: parameters) { (jsonResult) in
                print(jsonResult)
                self.translatedText.text = jsonResult["data"]["translations"][0]["translatedText"].stringValue
            }
        }
    }
}
