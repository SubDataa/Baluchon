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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
