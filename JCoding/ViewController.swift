//
//  ViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var termsandservices: UILabel!
    @IBOutlet weak var createAnAccount: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var GoogleLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var facebookLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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

