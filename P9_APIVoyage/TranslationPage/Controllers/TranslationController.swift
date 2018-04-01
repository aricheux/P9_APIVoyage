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

/// Class to handle the translation page
class TranslationController: UIViewController {
    var autoLanguageDetection = false
    /// Initial text before translation
    @IBOutlet weak var initialText: UITextView!
    /// Text return from google translation
    @IBOutlet weak var translatedText: UITextView!
    /// Language of the initial text
    @IBOutlet weak var sourceLanguage: UILabel!
    /// language of the translation
    @IBOutlet weak var targetLanguage: UILabel!
    /// button to send request to google translation
    @IBOutlet weak var translationButton: DesignableButton!
    /// String who contain the text to put when the textview is empty
    let placeholder = "Saisissez du texte.."
    
    // Set parameter and do action when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialText.delegate = self
        initialText.text = placeholder
        initialText.textColor = .lightGray
        
        sourceLanguage.text = "FR"
        targetLanguage.text = "EN"
    }
    
    /// Send the request to google translation when the button is pressed
    @IBAction func doTranslation() {
        if (initialText.text != placeholder) && !initialText.text.isEmpty {
            if let initialText = initialText.text, let targetLanguage = targetLanguage.text, let sourceLanguage = sourceLanguage.text {
                var parameters: Parameters = ["q": "\(initialText)"]
                parameters["target"] = targetLanguage.lowercased()
                parameters["source"] = sourceLanguage.lowercased()
                
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
    
    /// Reverse the initial and target language when the button is pressed
    @IBAction func reverseLanguage(_ sender: Any) {
        let memInitialLanguage = sourceLanguage.text
        
        sourceLanguage.text = targetLanguage.text
        targetLanguage.text = memInitialLanguage
    }
    
    /// Dismiss keyboard if the user tap outside of it
    @IBAction func dismissKeybord(_ sender: UITapGestureRecognizer) {
        initialText.resignFirstResponder()
    }
    
    /// Detect the language of the initial text if it's switch on
    @IBAction func autoLanguageDetection(_ sender: UISwitch) {
        autoLanguageDetection = sender.isOn
        
        if autoLanguageDetection {
            detectLanguage()
        } else {
            sourceLanguage.text = "FR"
            targetLanguage.text = "EN"
        }
    }
    
    /// Copy the translated text to the clipboard to use it after
    @IBAction func copyInClipboard(_ sender: Any) {
        UIPasteboard.general.string = translatedText.text
    }
    
    /// Send a request to detect the initial text Automatically
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
    
    /// Show a popup if the request have an error
    func errorPopUp() {
        let alertVC = UIAlertController(title: "", message: "Erreur lors de la traduction", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default) { (action:UIAlertAction!) in
            self.doTranslation()
        })
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    /// Show a popup if the initial text is empty
    func textEmptyPopUp() {
        let alertVC = UIAlertController(title: "", message: "Veuillez saisir un texte", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

/// Extension of the UIViewController to use delegate fonction
extension TranslationController: UITextViewDelegate {
    // Send the detect language request when the initial text is changing
    func textViewDidChange(_ textView: UITextView) {
        if autoLanguageDetection {
            detectLanguage()
        }
    }
    
    /// Replace the placeholder by an empty string
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == placeholder) {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    /// Replace the empty text by a placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
