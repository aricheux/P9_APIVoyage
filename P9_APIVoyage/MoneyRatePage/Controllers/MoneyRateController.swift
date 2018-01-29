//
//  MoneyRateController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangeRateController: UIViewController {
    ///
    var currentRate: Double = 0.0
    ///
    @IBOutlet weak var localChangeText: UITextField!
    ///
    @IBOutlet weak var dollarChangeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimer()
        
        if currentRate == 0.0 {
            self.updateRate()
        }
    }
    
    func setupTimer() {
        let dayInSeconde = 24.0 * 60.0
        
        Timer.scheduledTimer(timeInterval: dayInSeconde, target: self, selector: #selector(self.updateRate), userInfo: nil, repeats: true)
    }
    
    @objc func updateRate()
    {
        APIManager.sharedInstance.getData(from: "https://api.fixer.io/latest") { (result, jsonResult) in
            if result {
                self.currentRate = jsonResult["rates"]["USD"].doubleValue
            }
        }
    }
    
    @IBAction func convertLocalMoneyToDollar() {
        if let changeText = localChangeText.text, let localChangeNumber = Double(changeText) {
            let dollarChangeNumber = localChangeNumber * self.currentRate
            
            dollarChangeText.text = String(dollarChangeNumber)
        }
    }
}

