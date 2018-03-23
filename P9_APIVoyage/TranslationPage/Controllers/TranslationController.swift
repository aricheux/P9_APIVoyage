//
//  TranslateViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import Alamofire
import Spring

class TranslationController: UIViewController {
    ///
    @IBOutlet weak var initialText: UITextView!
    ///
    @IBOutlet weak var translatedText: UITextView!
    ///
    @IBOutlet weak var initialLanguage: DesignableTextView!
    ///
    @IBOutlet weak var targetLanguage: DesignableTextView!
    ///
    @IBOutlet weak var translationButton: DesignableButton!
    //
    let placeholder = "Saisissez du texte.."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialText.delegate = self
        initialText.text = placeholder
        initialText.textColor = .lightGray
        
        initialLanguage.text = "FR"
        targetLanguage.text = "EN"
    }
    ///
    @IBAction func doTranslation() {
        if (initialText.text != placeholder) && !initialText.text.isEmpty {
            if let initialText = initialText.text {
                let parameters: Parameters = ["q": "\(initialText)","target": targetLanguage.text.lowercased()]
                
                APIManager.sharedInstance.doTranslation(with: parameters) { (jsonResult, error) in
                    if error == nil {
                        self.translatedText.text = jsonResult["data"]["translations"][0]["translatedText"].stringValue
                    } else {
                        self.errorPopUp()
                    }
                }
            }
        } else {
            self.textEmptyPopUp()
        }
    }
    ///
    @IBAction func reverseLanguage(_ sender: Any) {
        let memInitialLanguage = initialLanguage.text
        
        initialLanguage.text = targetLanguage.text
        targetLanguage.text = memInitialLanguage
    }
    ///
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la traduction", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.doTranslation()
        })
        
        self.present(alertVC, animated: true, completion: nil)
    }
    //
    func textEmptyPopUp() {
        let alertVC = UIAlertController(title: "", message: "Veuillez saisir un texte", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
///
extension TranslationController: UITextViewDelegate {
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
