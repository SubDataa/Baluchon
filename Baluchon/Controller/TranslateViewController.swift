//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit

class TranslateViewController: UIViewController {

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
    
    let service = TranslateService()
    
    @IBOutlet weak var textToTranslate: UITextField!
    
    @IBOutlet weak var textTranslate: UITextField!
    
    @IBAction func translateButton(_ sender: Any) {
        if let text = textToTranslate.text {
            service.entryText = text
            service.getTranslate() { (data) in
                self.textTranslate.text = "\(self.service.convertedText)"
            }
               
        }
    }


}
