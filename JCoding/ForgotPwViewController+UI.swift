//
//  ForgotPwViewController+UI.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

extension ForgotPwViewController{
    func setupResetButton(){
       resetmyPw.setTitle("RESET MY PASSWORD", for: UIControl.State.normal)
             resetmyPw.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            resetmyPw.backgroundColor = UIColor.black
             resetmyPw.layer.cornerRadius = 5
             resetmyPw.clipsToBounds = true
       resetmyPw.setTitleColor(.white, for: UIControl.State.normal)
    }
    
    func setupFullEmail(){
        emailID.layer.borderWidth = 1
               emailID.layer.borderColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1).cgColor
               emailID.layer.cornerRadius = 3
               emailID.clipsToBounds = true
               emailIdtext.borderStyle = .none
               let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

               emailIdtext.attributedPlaceholder = placeholderAttr
               emailIdtext.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
}
