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
    /// String who contain the value in euro to convert
    @IBOutlet weak var localChangeText: UITextView!
    /// String who contain the converted value in dollar
    @IBOutlet weak var dollarChangeText: UILabel!
    /// String who contain the text to put when the textview is empty
    let placeholder = "Saisissez un montant.."
    
    // Set parameter and do action when the view is loaded
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
    
    /// Setup the timer to update every day the current dollar rate
    func setupTimer() {
        let dayInSeconde = 24.0 * 60.0
        
        Timer.scheduledTimer(timeInterval: dayInSeconde, target: self, selector: #selector(self.updateRate), userInfo: nil, repeats: true)
    }
    
    /// Get the current dollar rate from the API
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
    
    /// Update the rate if it's missing and convert the euro value to dollar
    @IBAction func convertLocalMoneyToDollar() {
        if self.currentRate != 0.0 {
            if let changeText = localChangeText.text, let localChangeNumber = Double(changeText) {
                let dollarChangeNumber = localChangeNumber * self.currentRate
                dollarChangeText.text = String(dollarChangeNumber) + " $"
            }
        } else {
            self.updateRate()
        }
    }
    
    /// Show an error pop-up if the API request have a problem
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la récupération du taux", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.updateRate()
        })
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    /// Dismiss keyboard if the user tap outside of it
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        localChangeText.resignFirstResponder()
    }
}

/// Extension of UITextViewDelegate to handle the place holder
extension MoneyRateController: UITextViewDelegate {
    /// replace the placeholder by an empty string
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == placeholder)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    /// Replace the empty text by a placeholder
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

