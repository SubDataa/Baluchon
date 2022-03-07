//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    //MARK: - DARK MODE SETTING & UI 
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        textToTranslate.layer.borderWidth = CGFloat(1.0)
        textToTranslate.layer.borderColor = UIColor.red.cgColor
        textToTranslate.layer.cornerRadius = 10.0
        textTranslate.layer.borderWidth = CGFloat(1.0)
        textTranslate.layer.borderColor = UIColor.red.cgColor
        textTranslate.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - VARIABLE FOR UI 
    @IBOutlet weak var textToTranslate: UITextField!
    @IBOutlet weak var textTranslate: UITextField!
    
    //MARK: - API CALL
    @IBAction func translateButton(_ sender: Any) {
        if let text = textToTranslate.text {
            TranslateService.shared.entryText = text
            TranslateService.shared.getTranslate() { (sucess, data) in
                if sucess {
                    self.updateTranslateView(from: data!)
                }
                
            }
            
        }
    }
    //MARK: - UPDATE TRANSLATION VIEW
    func updateTranslateView(from data: TranslateObject) {
        self.textTranslate.text = data.translatedText
        
    }
    
}
