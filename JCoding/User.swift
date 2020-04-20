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
    init(uid: String, username: String, email: String, profileImageUrl: String, status: String, dogname: String, distance: String, dogslat:Double, dogslong:Double
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
        let dogslong = dict["dogslong"] as? Double

            else {
                   return nil
           }
    
        let user = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, status: status, dogname: dogname, distance: distance, dogslat: dogslat, dogslong: dogslong)
        
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
