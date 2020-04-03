//
//  SignEmailViewController+UI.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import ProgressHUD

extension SignViewController {
    func setupSignIn(){
             let attributedTermsText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha: 0.65)])

        let attributedSubtermsText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
                    attributedTermsText.append(attributedSubtermsText)
        SignUpButton.setAttributedTitle(attributedTermsText, for: UIControl.State.normal)
        
    }
    func setupSignUp(){
              SignInButton.setTitle("Sign In", for: UIControl.State.normal)
              SignInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
              SignInButton.backgroundColor = UIColor.black
              SignInButton.layer.cornerRadius = 5
              SignInButton.clipsToBounds = true
        SignInButton.setTitleColor(.white, for: UIControl.State.normal)
        
    }
    func setupTitleLabel(){
        let title="Sign In"
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Didot", size:28)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        signInLabel.numberOfLines = 0
    signInLabel.attributedText=attributedText
    }
    
   
  
    
    func setupFullEmail(){
        firstContainer.layer.borderWidth = 1
        firstContainer.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
        firstContainer.layer.cornerRadius = 3
        firstContainer.clipsToBounds = true
        firsttext.borderStyle = .none
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

        firsttext.attributedPlaceholder = placeholderAttr
        firsttext.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupPassword(){
        SecondContainer.layer.borderWidth = 1
               SecondContainer.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
               SecondContainer.layer.cornerRadius = 3
              SecondContainer.clipsToBounds = true
               secondText.borderStyle = .none
               let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

               secondText.attributedPlaceholder = placeholderAttr
               secondText.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func validateFields(){
          guard let email = firsttext.text, !email.isEmpty else {
               ProgressHUD.showError("Please enter an email adddress")
               return
           }
           
           guard let password = secondText.text, !password.isEmpty else {
               ProgressHUD.showError("Please enter a password")
               return
           }
       }
    
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void){
           ProgressHUD.show("Loading...")
        Api.User.signIn(email: firsttext.text!, password:secondText.text!, onSuccess: {
            ProgressHUD.dismiss()
            onSuccess()
        }) {(errorMessage) in onError(errorMessage)}
        }
           
       }


