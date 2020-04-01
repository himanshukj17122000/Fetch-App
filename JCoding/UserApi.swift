//
//  UserApi.swift
//  JCoding
//
//  Created by himanshu on 01/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import ProgressHUD
import FirebaseStorage
class UserApi {
    func signUp(withUsername userName: String, email:String, password:String, image:UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult{
                print(authData.user.email ?? "hello")
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "username": userName,
                    "profileImageUrl": "",
                    "status": "Welcome to the App"
                ]
                guard let imageSelected = image else {
                         ProgressHUD.showError("Please choose your profile image")
                         return
                     }
                     
                     guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                         return
                     }
                
                let storageRef = Storage.storage().reference(forURL: "gs://jcoding-1f380.appspot.com")
                
                let storagerProfileRef = storageRef.child("profile").child(authData.user.uid)
           
               let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                storagerProfileRef.putData(imageData, metadata: metadata, completion: {(StorageMetadata, error)in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    storagerProfileRef.downloadURL(completion: { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        dict["profileImageUrl"] = metaImageUrl
                        
                        Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: {
                            (error, ref) in
                            if error == nil{
                                onSuccess()
                            } else {
                                onError(error!.localizedDescription)
                            }
                        })
                    }
                })
                })
                
            }
            
            
        }
    }
}
