//
//  SecondViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class ChangeRateController: UIViewController {
    @IBOutlet weak var localChangeText: UITextField!
    
    @IBOutlet weak var dollarChangeText: UITextField!
    
    var currentRate: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateRate()
    }
    
    func updateRate()
    {
        APIManager.sharedInstance.getData(URLString: "https://api.fixer.io/latest") { (ok, obj) in
            if ok {
                if let jsonResult = obj as? [String: Any] {
                    if let rates = jsonResult["rates"] as? [String: Any] {
                        if let USDRate = rates["USD"] as? Double {
                            DispatchQueue.main.sync {
                                self.currentRate = USDRate
                                print(self.currentRate)
                            }
                        }
                    }
                }
            } else {
                print("Erreur")
            }
            
        }
    }
 
    @IBAction func convertLocalMoneyToDollar() {
        if let localChangeNumber = Double(localChangeText.text!) {
                let dollarChangeNumber = localChangeNumber * self.currentRate
                
                dollarChangeText.text = String(dollarChangeNumber)
        }
    }
}

