//
//  TranslateViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import Alamofire

class TranslationController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var initialText: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    let placeholder = "Saisissez du texte.."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialText.delegate = self
        initialText.text = placeholder
        initialText.textColor = .lightGray
        
    }
    
    @IBAction func doTranslation() {
        if let initialText = initialText.text {
            let parameters: Parameters = ["q": "\(initialText)","target": "en"]
            
            APIManager.sharedInstance.doTranslation(with: parameters) { (jsonResult) in
                self.translatedText.text = jsonResult["data"]["translations"][0]["translatedText"].stringValue
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == placeholder)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
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
