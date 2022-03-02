//
//  ConvertViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit

class ConvertViewController: UIViewController {

    

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
            CurrencyService.shared.getCurrency(url: exchangerateURL) { (success, data) in
                if success {
                    self.result.text = "\(CurrencyService.shared.convertResult)" + " $"
                }
                
            }
               
        }
        
    }
    @IBAction func ButtonConvertEURToUSD(_ sender: Any) {
        if let text = textField.text {
            let exchangerateURL = URL(string: "https://api.exchangerate.host/convert?from=EUR&to=USD&amount=" + text)!
            CurrencyService.shared.getCurrency(url: exchangerateURL) { (sucess, data) in
                if sucess {
                    self.result.text = "\(CurrencyService.shared.convertResult)" + " $"
                }
                
            }
               
        }
        
    }

}
