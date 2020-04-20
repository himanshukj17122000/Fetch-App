//
//  ProfileTableViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD


class ProfileTableViewController: UITableViewController {

    
    @IBOutlet weak var dognamelbl: UITextField!
    @IBOutlet weak var dogagelbl: UITextField!
    @IBOutlet weak var dogbreedlbl: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func savebtndidtapped(_ sender: Any) {
        changeData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeData()
        
    
    }
    

    func observeData() {
     
        let currentUserID : String = (Auth.auth().currentUser?.uid)!
            let ref = Database.database().reference()
            ref.child("users").child(currentUserID).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.dognamelbl.text = value?["dogname"] as? String
                self.dogagelbl.text = value?["dogsage"] as? String
                self.dogbreedlbl.text = value?["dogsbreed"] as? String
                //let catPictureURL = URL(string: (value?["profileImageUrl"] as? String)!)
                })
            
        }
    func changeData() {
       var dict = Dictionary<String,Any>()
       let dogname = self.dognamelbl.text
        if !dogname!.isEmpty {
           dict["dogname"] = dogname
       }

       let dogage = self.dogagelbl.text
        if !dogage!.isEmpty {
           dict["dogsage"] = dogage
       }
       let dogbreed = self.dogbreedlbl.text
        if !dogbreed!.isEmpty {
           dict["dogsbreed"] = dogbreed
       }

        Api.User.saveUserProfile(dict: dict, onSuccess: {
            ProgressHUD.showSuccess()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    }
    
    


