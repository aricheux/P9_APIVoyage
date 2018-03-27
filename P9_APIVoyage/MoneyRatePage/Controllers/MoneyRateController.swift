//
//  MoneyRateController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import SwiftyJSON

/// Class to handle the money rate page
class MoneyRateController: UIViewController {
    /// Current rate for the convertion
    var currentRate = Double()
    /// 
    @IBOutlet weak var localChangeText: UITextView!
    ///
    @IBOutlet weak var dollarChangeText: UILabel!
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
    ///
    func setupTimer() {
        let dayInSeconde = 24.0 * 60.0
        
        Timer.scheduledTimer(timeInterval: dayInSeconde, target: self, selector: #selector(self.updateRate), userInfo: nil, repeats: true)
    }
    ///
    @objc func updateRate()
    {
        APIManager.sharedInstance.getData(from: "https://api.fixer.io/latest") { (jsonResult, error) in
            if error == nil {
                self.currentRate = jsonResult["rates"]["USD"].doubleValue
            } else {
                self.errorPopUp()
            }
        }
    }
    ///
    @IBAction func convertLocalMoneyToDollar() {
        if self.currentRate != 0.0 {
            if let changeText = localChangeText.text, let localChangeNumber = Double(changeText) {
                let dollarChangeNumber = localChangeNumber * self.currentRate
                dollarChangeText.text = String(dollarChangeNumber)
            }
        } else {
            self.updateRate()
        }
    }
    
    ///
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la récupération du taux", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.updateRate()
        })
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        localChangeText.resignFirstResponder()
    }
    
    
}
///
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

