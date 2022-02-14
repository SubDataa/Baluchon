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
        
}
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var TextField: UITextField!
    
    @IBAction func ButtonConvert(_ sender: Any) {
        if let text = TextField.text {
            convert.entryAmount = text
            convert.getCurrency() { (data) in
                self.result.text = "\(self.convert.convertResult)" + "$"
            }
               
        }
        
    }

}
