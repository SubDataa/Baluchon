//
//  ConvertViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit

class ConvertViewController: UIViewController {

    
let convert = Currency()
    override func viewDidLoad() {
        super.viewDidLoad()
        convert.getCurrency()
        // Do any additional setup after loading the view.
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
