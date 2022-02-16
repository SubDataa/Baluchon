//
//  ConvertViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit

class ConvertViewController: UIViewController {

    
let convert = CurrencyService()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        textField.layer.borderWidth = CGFloat(1.0)
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 10.0
    
}
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func ButtonConvert(_ sender: Any) {
        if let text = textField.text {
            convert.entryAmount = text
            convert.getCurrency() { (data) in
                self.result.text = "\(self.convert.convertResult)" + " $"
            }
               
        }
        
    }

}
