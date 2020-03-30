//
//  ViewController+UI.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

extension ViewController{
    func setupHeaderTitle(){
        let title="Create a new account"
        let subtitle="\n\nLorem ipsum etc etc etc"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Didot", size:28)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let attributedSubText = NSMutableAttributedString(string: subtitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha:0.45)])
        attributedText.append(attributedSubText)
        titleLabel.numberOfLines = 0
        titleLabel.attributedText=attributedText
    }
    
    func setupOrLabel(){
        orLabel.text = "Or"
        orLabel.font = UIFont.boldSystemFont(ofSize: 16)
        orLabel.textColor = UIColor(white:0, alpha: 0.45)
        orLabel.textAlignment = .center
    }
    func setupTerms(){
        let attributedTermsText = NSMutableAttributedString(string: "By clicking 'Create a new account' you agree to our ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha: 0.45)])
        
        let attributedSubtermsText = NSMutableAttributedString(string: "Terms of Service.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha:0.65)])
        attributedTermsText.append(attributedSubtermsText)
        termsandservices.attributedText = attributedTermsText
        termsandservices.numberOfLines = 0
    }
    
    func setupFacebook(){
        facebookLabel.setTitle("Sign in with Facebook", for: UIControl.State.normal)
        facebookLabel.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        facebookLabel.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        facebookLabel.layer.cornerRadius = 5
        facebookLabel.clipsToBounds = true
        
        facebookLabel.setImage(UIImage(named: "icon-facebook") , for: UIControl.State.normal)
        facebookLabel.imageView?.contentMode = .scaleAspectFit
        facebookLabel.tintColor = .white
        facebookLabel.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
    }
    
    func setupGoogle(){
        GoogleLabel.setTitle("Sign in with Google", for: UIControl.State.normal)
        GoogleLabel.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        GoogleLabel.backgroundColor = UIColor(red: 223/255, green: 74/255, blue: 50/255, alpha: 1)
        GoogleLabel.layer.cornerRadius = 5
        GoogleLabel.clipsToBounds = true
        
        GoogleLabel.setImage(UIImage(named: "icon-google") , for: UIControl.State.normal)
        GoogleLabel.imageView?.contentMode = .scaleAspectFit
        GoogleLabel.tintColor = .white
        GoogleLabel.imageEdgeInsets = UIEdgeInsets(top: 12, left: -35, bottom: 12, right: 0)
    }
    
    func setupCreateAccount(){
        createAnAccount.setTitle("Create a new account", for: UIControl.State.normal)
        createAnAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAnAccount.backgroundColor = UIColor.black
        createAnAccount.layer.cornerRadius = 5
        createAnAccount.clipsToBounds = true
    }
}
