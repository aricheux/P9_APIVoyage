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
    @IBOutlet weak var localChangeText: UITextField!
    
    @IBOutlet weak var dollarChangeText: UITextField!
    
    var currentRate: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dayInSeconde = 24.0 * 60.0
        
        Timer.scheduledTimer(timeInterval: dayInSeconde, target: self, selector: #selector(self.updateRate), userInfo: nil, repeats: true)

        if currentRate == 0.0 {
            self.updateRate()
        }
    }
    
    @objc func updateRate()
    {
        APIManager.sharedInstance.getData(from: "https://api.fixer.io/latest") { (jsonResult) in
            self.currentRate = jsonResult["rates"]["USD"].double!
        }
    }
    
    @IBAction func convertLocalMoneyToDollar() {
        if let localChangeNumber = Double(localChangeText.text!) {
            let dollarChangeNumber = localChangeNumber * self.currentRate
            
            dollarChangeText.text = String(dollarChangeNumber)
        }
    }
}

