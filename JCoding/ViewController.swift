//
//  ViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

   
    @IBOutlet weak var termsandservices: UILabel!
    @IBOutlet weak var createAnAccount: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var GoogleLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var facebookLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        GoogleLabel.isHidden = true
          GIDSignIn.sharedInstance()?.presentingViewController = self

          // Automatically sign in the user.
          GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//
//          // ...
        
      setupUI()
    }

    
    func setupUI(){
        setupHeaderTitle()
        setupOrLabel()
        setupTerms()
        setupFacebook()
        setupGoogle()
        setupCreateAccount()
        }


}

