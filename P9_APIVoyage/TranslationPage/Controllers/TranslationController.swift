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
    var autoLanguageDetection = false
    ///
    @IBOutlet weak var initialText: UITextView!
    ///
    @IBOutlet weak var translatedText: UITextView!
    ///
    @IBOutlet weak var sourceLanguage: UILabel!
    ///
    @IBOutlet weak var copyButton: DesignableButton!
    ///
    @IBOutlet weak var targetLanguage: UILabel!
    ///
    @IBOutlet weak var translationButton: DesignableButton!
    //
    let placeholder = "Saisissez du texte.."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialText.delegate = self
        initialText.text = placeholder
        initialText.textColor = .lightGray
        
        sourceLanguage.text = "FR"
        targetLanguage.text = "EN"
    }
    
    ///
    @IBAction func doTranslation() {
        if (initialText.text != placeholder) && !initialText.text.isEmpty {
            if let initialText = initialText.text, let targetLanguage = targetLanguage.text, let sourceLanguage = sourceLanguage.text {
                var parameters: Parameters = ["q": "\(initialText)"]
                parameters["target"] = targetLanguage.lowercased()
                parameters["source"] = sourceLanguage.lowercased()
                
                APIManager.sharedInstance.doTranslation(with: parameters) { (jsonResult, error) in
                    if error == nil {
                        self.translatedText.text = jsonResult["data"]["translations"][0]["translatedText"].stringValue
                        self.copyButton.isHidden = false
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
        let memInitialLanguage = sourceLanguage.text
        
        sourceLanguage.text = targetLanguage.text
        targetLanguage.text = memInitialLanguage
    }
    
    ///
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        initialText.resignFirstResponder()
    }
    
    ///
    @IBAction func autoLanguageDetection(_ sender: UISwitch) {
        autoLanguageDetection = sender.isOn
        
        if autoLanguageDetection {
            detectLanguage()
        } else {
            sourceLanguage.text = "FR"
            targetLanguage.text = "EN"
        }
    }
    
    ///
    @IBAction func copyInClipboard(_ sender: Any) {
        UIPasteboard.general.string = translatedText.text
    }
    
    ///
    func detectLanguage() {
        if let initialText = initialText.text {
            let parameters: Parameters = ["q": "\(initialText)"]
            APIManager.sharedInstance.detectLanguage(with: parameters) { (jsonResult, error) in
                if error == nil {
                    self.sourceLanguage.text = jsonResult["data"]["detections"][0][0]["language"].stringValue.uppercased()
                } else {
                    self.errorPopUp()
                }
            }
        }
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
    //
    func textViewDidChange(_ textView: UITextView) {
        if autoLanguageDetection {
            detectLanguage()
        }
    }
    ///
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == placeholder) {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    ///
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
