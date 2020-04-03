//
//  User.swift
//  JCoding
//
//  Created by himanshu on 03/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
class User{
    var uid: String
    var username:String
    var email:String
    var profileImageUrl: String
    var Status: String
     init(uid: String, username: String, email: String, profileImageUrl: String, status: String) {
           self.uid = uid
           self.username = username
           self.email = email
           self.profileImageUrl = profileImageUrl
           self.Status = status
       }
    
    
    static func transformUser(dict: [String: Any]) -> User? {
           guard let email = dict["email"] as? String,
               let username = dict["username"] as? String,
               let profileImageUrl = dict["profileImageUrl"] as? String,
               let status = dict["status"] as? String,
               let uid = dict["uid"] as? String else {
                   return nil
           }
        let user = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, status: status)
        return user
    }
}
