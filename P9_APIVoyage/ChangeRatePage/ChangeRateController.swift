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
    
    @IBOutlet weak var currentRateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentRateText.text = "1.2255"
        
    }
 
    @IBAction func convertLocalToDollarChange() {
        if let localChangeNumber = Double(localChangeText.text!), let currentRateNumber = Double(currentRateText.text!) {
                let dollarChangeNumber = localChangeNumber * currentRateNumber
                
                dollarChangeText.text = String(dollarChangeNumber)
        }
    }
}

