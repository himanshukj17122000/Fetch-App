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
    var Status: String
    var dogname: String
    var distance:String
    var dogslat:Double
    var dogslong:Double
    var dogsgender:String
    var usersprefgender:String
    init(uid: String, username: String, email: String, profileImageUrl: String, status: String, dogname: String, distance: String, dogslat:Double, dogslong:Double, dogsgender:String, usersprefgender:String
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
        self.dogsgender = dogsgender
        self.usersprefgender = usersprefgender
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
            let dogsgender = dict["dogsgender"] as? String,
        let usersprefgender = dict["usersprefgender"] as? String

            else {
                   return nil
           }
    
        let user = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, status: status, dogname: dogname, distance: distance, dogslat: dogslat, dogslong: dogslong, dogsgender: dogsgender, usersprefgender: usersprefgender)
        
        let currentUserID : String = (Auth.auth().currentUser?.uid)!
        print(currentUserID)
        let ref = Database.database().reference()
        
        ref.child("users").child(currentUserID).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let latt = value?["dogslat"] as? Double
            let long = value?["dogslong"] as? Double
            let dogsgender = value?["dogsGender"] as? String
            let usersprefgender = value?["prefgender"] as? String
          
          }) { (error) in
            print(error.localizedDescription)
        }
        
       // print(currentUser.dogslong!)
//        let longdiff = user.dogslong - currentUser.dogslong
//        print(longdiff)
//        let latdiff = user.dogslat - Double(currentUser.dogslat!)
//        print(latdiff)
//        let sqrroot = Int((longdiff + latdiff).squareRoot())
//
//        let distt = Int((currentUser.dist)!)
//        if(sqrroot < distt!) {
//            return user
//        } else {
//            return nil
//        }
    

            return user
}

}
