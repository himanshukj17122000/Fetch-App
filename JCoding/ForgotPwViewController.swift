//
//  ForgotPwViewController.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import ProgressHUD
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
    
    @IBAction func resetPassword(_ sender: Any) {
        guard let email = emailIdtext.text, email != "" else {
                   ProgressHUD.showError(EMPTY_PASSWORD_RESET)
                   return
               }
        Api.User.resetPassword(email: email, onSuccess: {
            self.view.endEditing(true)
            ProgressHUD.showSuccess("Please follow the instructions sent on your e-mail to reset your password" )
            self.navigationController?.popViewController(animated: true)
        }) {(errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    
}
}
