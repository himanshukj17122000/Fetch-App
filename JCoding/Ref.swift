//
//  Ref.swift
//  JCoding
//
//  Created by himanshu on 02/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
import Firebase
let REF_USER = "users"
let STORAGE_PROFILE = "profile"
let URL_STORAGE_ROOT = "gs://jcoding-1f380.appspot.com"
let PROFILE_IMAGE_URL = "profileImageUrl"
let EMPTY_PASSWORD_RESET = "Please enter an email address for password reset"
class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    var databaseMessage: DatabaseReference{
        return databaseRoot.child("messages")
    }
    
    func databaseMessageSendTo(from:String, to:String) ->
        DatabaseReference {
            databaseMessage.child(from).child(to)
        }
    
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
        let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
           return storageRoot.child(STORAGE_PROFILE)
       }
       
       func storageSpecificProfile(uid: String) -> StorageReference {
           return storageProfile.child(uid)
       }
}
