//
//  AppDelegate.swift
//  JCoding
//
//  Created by himanshu on 30/03/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import GoogleSignIn
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureInitialContainer()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
               GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
               
               return true
           }
           
           func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
               var handled = false
               
               if url.absoluteString.contains("fb") {
                handled = ApplicationDelegate.shared.application(app, open: url, options: options)
               } else {
//                   handled = GIDSignIn.sharedInstance()!.handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
               }
               
               
               return handled
           }
    
    func configureInitialContainer(){
        var initialVC: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if Auth.auth().currentUser != nil {
            initialVC = storyboard.instantiateViewController(withIdentifier: "TabVC")
        } else {
            initialVC = storyboard.instantiateViewController(withIdentifier: "MainVC")
        }
        SceneDelegate.shared?.window?.rootViewController = initialVC
        SceneDelegate.shared?.window?.makeKeyAndVisible()
        
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

