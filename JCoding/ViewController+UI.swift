//
//  ViewController+UI.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ProgressHUD
import Firebase
import GoogleSignIn
import FBSDKLoginKit

let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"

extension ViewController: GIDSignInDelegate  {
  
    func setupHeaderTitle(){
        let title="Create a new account"
        let subtitle="\nWelcome to out PetApp. This App works to connect dog owners with other dog owners in order to build a community of Dog lovers"
        
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
        facebookLabel.addTarget(self, action: #selector(fbButtonDidTap), for: UIControl.Event.touchUpInside)
    }
    @objc func fbButtonDidTap() {
        let fbLoginManager = LoginManager()
           fbLoginManager
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
               if let error = error {
                   ProgressHUD.showError(error.localizedDescription)
                   return
               }
               
            guard let accessToken = AccessToken.current else {
                   ProgressHUD.showError("Failed to get access token")
                   return
               }
               
               let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
               Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                   if let error = error {
                       ProgressHUD.showError(error.localizedDescription)
                       return
                   }
                   
                   if let authData = result {
                   self.handleFbGoogleLogic(authData: authData)
                   }
               })
           }
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
        GIDSignIn.sharedInstance()?.delegate = self
       GoogleLabel.addTarget(self, action: #selector(googleButtonDidTap), for: UIControl.Event.touchUpInside)

        
    }
     func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
                 withError error: Error!) {
          ProgressHUD.showError(error!.localizedDescription)
       }
          func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                       withError error: Error!) {
            
               if let error = error {
                 if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                   
                   print("The user has not signed in before or they have since signed out.")
                 } else {
                   print("\(error.localizedDescription)")
                }}
                guard let authentication = user.authentication else {
                    return
                }
            
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                     if let error = error {
                         ProgressHUD.showError(error.localizedDescription)
                         return
                     }
                     
                     if let authData = result {
                     self.handleFbGoogleLogic(authData: authData)
                     }
                 })
               }
                
             
       
       
       @objc func googleButtonDidTap() {
           GIDSignIn.sharedInstance()?.signIn()
       }
    
    func handleFbGoogleLogic(authData: AuthDataResult) {
        let dict: Dictionary<String, Any> =  [
            UID: authData.user.uid,
            EMAIL: authData.user.email,
            USERNAME: authData.user.displayName,
            PROFILE_IMAGE_URL: (authData.user.photoURL == nil) ? "" : authData.user.photoURL!.absoluteString,
            STATUS: "Welcome to JChat"
        ]
        Ref().databaseSpecificUser(uid: authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
            if error == nil {
        
                (UIApplication.shared.delegate as! AppDelegate).configureInitialContainer()
                
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        })
        
    }
    func setupCreateAccount(){
        createAnAccount.setTitle("Create a new account", for: UIControl.State.normal)
        createAnAccount.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAnAccount.backgroundColor = UIColor.black
        createAnAccount.layer.cornerRadius = 5
        createAnAccount.clipsToBounds = true
    }
}
