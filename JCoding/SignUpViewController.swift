//
//  SignUpViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var thirdpasswordText: UITextField!
    @IBOutlet weak var thirdContainerPassword: UIView!
    @IBOutlet weak var secondIDText: UITextField!
    @IBOutlet weak var secondContainer: UIView!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        setupSignIn()
        setupSignUp()
        setupTitleLabel()
        setupAvatar()
        setupFullTextName()
        setupFullEmail()
        setupPassword()
        
        
    }

   
    @IBAction func dismissView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
