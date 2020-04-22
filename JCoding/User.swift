//
//  User.swift
//  JCoding
//
//  Created by himanshu on 03/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class User{
    var uid: String
    var username:String
    var email:String
    var profileImageUrl: String
    var profileImage = UIImage()
    var Status: String
    var dogname: String
    var distance:String
    var dogslat:Double
    var dogslong:Double
    var prefgender:String
    var dogGender:String
    var dogsbio:String

    init(uid: String, username: String, email: String, profileImageUrl: String, status: String, dogname: String, distance: String, dogslat:Double, dogslong:Double, prefgender:String, dogGender:String, dogsbio:String
    ) {
           self.uid = uid
           self.username = username
           self.email = email
           self.profileImageUrl = profileImageUrl
           self.Status = status
        self.dogname = dogname
        self.distance = distance
        self.dogslat = dogslat
        self.dogslong = dogslong
        self.prefgender = prefgender
        self.dogGender = dogGender
        self.dogsbio = dogsbio
        
       }
    
    
    static func transformUser(dict: [String: Any]) -> User? {
           guard let email = dict["email"] as? String,
               let username = dict["username"] as? String,
               let profileImageUrl = dict["profileImageUrl"] as? String,
               let status = dict["status"] as? String,
               let uid = dict["uid"] as? String,
            let dogname = dict["dogname"] as? String,
            let distance = dict["distance"] as? String,
        let dogslat = dict["dogslat"] as? Double,
        let dogslong = dict["dogslong"] as? Double,
            let prefgender = dict["prefgender"] as? String,
        let dogGender = dict["dogsgender"] as? String,
        let dogsbio = dict["dogsbio"] as? String

            else {
                   return nil
           }
    
        let user = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, status: status, dogname: dogname, distance: distance, dogslat: dogslat, dogslong: dogslong, prefgender: prefgender, dogGender: dogGender, dogsbio:dogsbio)
        
        let currentUserID : String = (Auth.auth().currentUser?.uid)!
        print(currentUserID)
        let ref = Database.database().reference()
        
        ref.child("users").child(currentUserID).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let latt = value?["dogslat"] as? Double
            let long = value?["dogslong"] as? Double
          
          }) { (error) in
            print(error.localizedDescription)
        }
            return user
}

}
