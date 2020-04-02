//
//  StorageService.swift
//  JCoding
//
//  Created by himanshu on 02/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD
class StorageService{
    static func savePhoto(username: String, uid: String, data: Data, metadata: StorageMetadata, storagerProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagerProfileRef.putData(data, metadata: metadata, completion: {(StorageMetadata, error)in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagerProfileRef.downloadURL(completion: { (url, error) in
            if let metaImageUrl = url?.absoluteString {
                if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                                       changeRequest.photoURL = url
                                       changeRequest.displayName = username
                                       changeRequest.commitChanges(completion: { (error) in
                                           if let error = error {
                                               ProgressHUD.showError(error.localizedDescription)
                                           }
                                       })
                                   }
                
                var dictTemp = dict
                dictTemp[PROFILE_IMAGE_URL] = metaImageUrl
                
                Ref().databaseSpecificUser(uid: uid).updateChildValues(dictTemp, withCompletionBlock: {
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
