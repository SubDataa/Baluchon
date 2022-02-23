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
    
    
    @IBAction func ButtonConvertUSDToEUR(_ sender: Any) {
       
        if let text = textField.text {
            let exchangerateURL = URL(string: "https://api.exchangerate.host/convert?from=USD&to=EUR&amount=" + text)!
            convert.getCurrency(url: exchangerateURL) { (data) in
                self.result.text = "\(self.convert.convertResult)" + " $"
            }
               
        }
        
    }
    @IBAction func ButtonConvertEURToUSD(_ sender: Any) {
        if let text = textField.text {
            let exchangerateURL = URL(string: "https://api.exchangerate.host/convert?from=EUR&to=USD&amount=" + text)!
            convert.getCurrency(url: exchangerateURL) { (data) in
                self.result.text = "\(self.convert.convertResult)" + " $"
            }
               
        }
        
    }

}
