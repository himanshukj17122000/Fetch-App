//
//  ForgotPwViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class ForgotPwViewController: UIViewController {

    @IBOutlet weak var resetmyPw: UIButton!
    @IBOutlet weak var emailIdtext: UITextField!
    @IBOutlet var emailID: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        }
        func setupUI(){
            setupResetButton()
            setupFullEmail()
           
            }
    
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
