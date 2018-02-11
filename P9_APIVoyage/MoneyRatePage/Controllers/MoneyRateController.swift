//
//  MoneyRateController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoneyRateController: UIViewController {
    ///
    var currentRate: Double = 0.0
    ///
    @IBOutlet weak var localChangeText: UITextView!
    ///
    @IBOutlet weak var dollarChangeText: UITextView!
    ///
    let placeholder = "Saisissez un montant.."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localChangeText.delegate = self
        localChangeText.text = placeholder
        localChangeText.textColor = .lightGray
        
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
        APIManager.sharedInstance.getData(from: "https://api.fixer.io/latest") { (jsonResult, error) in
            if error == nil {
                self.currentRate = jsonResult["rates"]["USD"].doubleValue
            } else {
                self.showErrorPopUp()
            }
        }
    }
    
    @IBAction func convertLocalMoneyToDollar() {
        if let changeText = localChangeText.text, let localChangeNumber = Double(changeText) {
            let dollarChangeNumber = localChangeNumber * self.currentRate
            
            dollarChangeText.text = String(dollarChangeNumber)
        }
    }
    
    ///
    func showErrorPopUp() {
        let alertVC = UIAlertController(title: "Erreur", message: "Une erreur lors de la récupération du taux", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.updateRate()
        })
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension MoneyRateController: UITextViewDelegate {
    ///
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == placeholder)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    ///
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}

