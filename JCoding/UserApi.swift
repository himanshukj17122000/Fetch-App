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
    
    var currentUserId: String{
        return Auth.auth().currentUser != nil ?
            Auth.auth().currentUser!.uid :""
        }
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        } catch {
            ProgressHUD.showError(error.localizedDescription)
            return
        }
        (UIApplication.shared.delegate as! AppDelegate).configureInitialContainer()
    }
    
    func observeUsers(onSuccess: @escaping(UserFromDB)){
        Ref().databaseUsers.observe(.childAdded){(snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any> {
                if let user = User.transformUser(dict: dict){
                    onSuccess(user)
                }
             
            }
        }
    }
    
    typealias UserFromDB = (User) -> Void
    
    
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
                
              let storageProfile = Ref().storageSpecificProfile(uid: authData.user.uid)
           
               let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                StorageService.savePhoto(username: userName, uid:authData.user.uid , data: imageData, metadata: metadata, storagerProfileRef: storageProfile, dict: dict, onSuccess:{
                    onSuccess()
                }, onError: {(errorMessage) in
                    onError(errorMessage)
                
            })
            
            
        }
    }
}
}
