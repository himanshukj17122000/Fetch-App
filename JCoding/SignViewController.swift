//
//  SignViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    @IBOutlet weak var ForgotPass: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var firsttext: UITextField!
    @IBOutlet weak var SecondContainer: UIView!
    @IBOutlet weak var firstContainer: UIView!

    @IBOutlet weak var SignInLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        }
        func setupUI(){
            setupSignIn()
            setupSignUp()
            setupTitleLabel()
            setupFullEmail()
            setupPassword()
            
            
        }

   
}
