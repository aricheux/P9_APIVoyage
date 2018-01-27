//
//  TranslateViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import Alamofire

class TranslatationController: UIViewController {
    
    @IBOutlet weak var InitialText: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InitialText.text = "merci"
        
    }
    
    @IBAction func doTranslation() {
        let parameters: Parameters = [
            "q": "\(self.InitialText.text!)",
            "target": "en"
        ]

        if APIManager.sharedInstance.isConnectedToInternet() {
            APIManager.sharedInstance.doTranslation(with: parameters) { (jsonResult) in
                print(jsonResult)
                self.translatedText.text = jsonResult["data"]["translations"][0]["translatedText"].string!
            }
        } else {
            print("pas internet")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
