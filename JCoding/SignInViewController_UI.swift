//
//  SignInViewController_UI.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import ProgressHUD
extension SignUpViewController{
    func setupSignIn(){
             let attributedTermsText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha: 0.65)])
                    
        let attributedSubtermsText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
                    attributedTermsText.append(attributedSubtermsText)
        SignInButton.setAttributedTitle(attributedTermsText, for: UIControl.State.normal)
        
    }
    func setupSignUp(){
              SignUpButton.setTitle("Sign Up", for: UIControl.State.normal)
              SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
              SignUpButton.backgroundColor = UIColor.black
              SignUpButton.layer.cornerRadius = 5
              SignUpButton.clipsToBounds = true
        SignUpButton.setTitleColor(.white, for: UIControl.State.normal)
        
    }
    func setupTitleLabel(){
        let title="Sign Up"
       
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Didot", size:28)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        titleLabel.numberOfLines = 0
    titleLabel.attributedText=attributedText
    }
    
    func setupAvatar(){
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        avatarImage.isUserInteractionEnabled = true
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
               avatarImage.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func presentPicker() {
           let picker = UIImagePickerController()
           picker.sourceType = .photoLibrary
        picker.allowsEditing = true
               picker.delegate = self
           self.present(picker, animated: true, completion: nil)
       }
    
    func setupFullTextName(){
        firstContainer.layer.borderWidth = 1
        firstContainer.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
        firstContainer.layer.cornerRadius = 3
        firstContainer.clipsToBounds = true
        firstnameText.borderStyle = .none
        let placeholderAttr = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        firstnameText.attributedPlaceholder = placeholderAttr
        firstnameText.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    func setupFullEmail(){
        secondContainer.layer.borderWidth = 1
        secondContainer.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
        secondContainer.layer.cornerRadius = 3
        secondContainer.clipsToBounds = true
        secondIDText.borderStyle = .none
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        secondIDText.attributedPlaceholder = placeholderAttr
        secondIDText.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupPassword(){
        thirdContainerPassword.layer.borderWidth = 1
               thirdContainerPassword.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
               thirdContainerPassword.layer.cornerRadius = 3
              thirdContainerPassword.clipsToBounds = true
               thirdpasswordText.borderStyle = .none
               let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
               
               thirdpasswordText.attributedPlaceholder = placeholderAttr
               thirdpasswordText.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validateFields(){
        guard let userName = self.firstnameText.text, !userName.isEmpty else {
            ProgressHUD.showError("Please enter an username")
            return
        }
        
        guard let email = self.secondIDText.text, !email.isEmpty else {
            ProgressHUD.showError("Please enter an email adddress")
            return
        }
        
        guard let password = self.thirdpasswordText.text, !password.isEmpty else {
            ProgressHUD.showError("Please enter a password")
            return
        }
    }
    
    func signUp(){
     
        Api.User.signUp(withUsername: self.firstnameText.text!, email: self.secondIDText.text!, password: self.thirdpasswordText.text!, image: self.image, onSuccess: {
            print("Done")
        }) {(errorMessage)in
            print(errorMessage)
        }
        
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatarImage.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            avatarImage.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
