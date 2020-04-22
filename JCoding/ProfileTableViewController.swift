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
    
    @IBOutlet weak var distancelbl: UILabel!
    @IBOutlet weak var dogbiolbl: UITextField!
    @IBOutlet weak var prefboth: RoundedButton!
    @IBOutlet weak var prefmale: RoundedButton!
    @IBOutlet weak var preffemale: RoundedButton!
    
    @IBOutlet weak var gendermalebtn: RoundedButton!
    @IBOutlet weak var genderfemalebtn: RoundedButton!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        distancelbl.text = "\(currentValue)"
        
    }
    
    @IBAction func logoutbtntapped(_ sender: Any) {
        Api.User.logOut()
    }
    @IBAction func femalebtndidtapped(_ sender: Any) {
        if genderfemalebtn.backgroundColor == UIColor.white{
            gendermalebtn.backgroundColor = UIColor.white
            genderfemalebtn.backgroundColor = UIColor.lightGray
        }
        else if genderfemalebtn.backgroundColor == UIColor.lightGray {
            genderfemalebtn.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func malebtndidtapped(_ sender: Any) {
        if gendermalebtn.backgroundColor == UIColor.white{
            genderfemalebtn.backgroundColor = UIColor.white
            gendermalebtn.backgroundColor = UIColor.lightGray
        }
        else if gendermalebtn.backgroundColor == UIColor.lightGray {
            gendermalebtn.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func preffemaletapped(_ sender: Any) {
        if preffemale.backgroundColor == UIColor.white{
            prefmale.backgroundColor = UIColor.white
            prefboth.backgroundColor = UIColor.white
            preffemale.backgroundColor = UIColor.lightGray
        }
        else if preffemale.backgroundColor == UIColor.lightGray {
            preffemale.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func prefmaletapped(_ sender: Any) {
        if prefmale.backgroundColor == UIColor.white{
                  preffemale.backgroundColor = UIColor.white
                  prefboth.backgroundColor = UIColor.white
                  prefmale.backgroundColor = UIColor.lightGray
              }
              else if prefmale.backgroundColor == UIColor.lightGray {
                  prefmale.backgroundColor = UIColor.white
              }
    }
    
    
    @IBAction func prefbothtapped(_ sender: Any) {
        if prefboth.backgroundColor == UIColor.white{
                         preffemale.backgroundColor = UIColor.white
                         prefmale.backgroundColor = UIColor.white
                         prefboth.backgroundColor = UIColor.lightGray
                     }
                     else if prefboth.backgroundColor == UIColor.lightGray {
                         prefboth.backgroundColor = UIColor.white
                     }
    }
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
                self.dogbiolbl.text = value?["dogsbio"] as? String
                self.distancelbl.text = value?["distance"] as? String
                self.slider.value = value?["distance"] as? Float ?? 50
                
            let gender = value?["dogsgender"] as? String
                if gender!.elementsEqual("female") {
                    self.genderfemalebtn.backgroundColor = UIColor.lightGray
                } else {
                    self.gendermalebtn.backgroundColor = UIColor.lightGray
                }
                let prefgender = value?["prefgender"] as? String
                if prefgender!.elementsEqual("female") {
                    self.preffemale.backgroundColor = UIColor.lightGray
                }
                if prefgender!.elementsEqual("male") {
                    self.prefmale.backgroundColor = UIColor.lightGray
                }
                if prefgender!.elementsEqual("both") {
                    self.prefboth.backgroundColor = UIColor.lightGray
                }
                })
            
        }
    func changeData() {
       var dict = Dictionary<String,Any>()
       let dogname = self.dognamelbl.text
        if !dogname!.isEmpty {
           dict["dogname"] = dogname
       }
        dict["dogsbio"] = dogbiolbl.text
        dict["distance"] = self.distancelbl.text

       let dogage = self.dogagelbl.text
        if !dogage!.isEmpty {
           dict["dogsage"] = dogage
       }
       let dogbreed = self.dogbreedlbl.text
        if !dogbreed!.isEmpty {
           dict["dogsbreed"] = dogbreed
       }
        if (genderfemalebtn.backgroundColor == UIColor.lightGray) {
            dict["dogsgender"] = "female"
        } else {
            dict["dogsgender"] = "male"
        }
        
        if (preffemale.backgroundColor == UIColor.lightGray) {
            dict["dogsgender"] = "female"
        } else if (prefmale.backgroundColor == UIColor.lightGray){
            dict["dogsgender"] = "male"
        } else {
            dict["dogsgender"] = "both"
        }
        
        Api.User.saveUserProfile(dict: dict, onSuccess: {
            ProgressHUD.showSuccess()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    }
    
    


