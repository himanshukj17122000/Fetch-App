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
import AVFoundation
import FirebaseAuth
import ProgressHUD
class StorageService{
    static func saveVideoMessage(url:URL, id:String, onSuccess: @escaping(_ value:Any) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        let ref = Ref().storageSpecificVideoMessage(id: id)
        ref.putFile(from: url, metadata: nil){(metadata, error) in
            if error != nil {
                               onError(error!.localizedDescription)
                           }
            ref.downloadURL(completion: { (videoUrl, error) in
                if let thumbnail = self.thumbnailImageForFileUrl(url){
                    StorageService.savePhotoMessage(image: thumbnail, id: id, onSuccess: { (value) in
                                           if let dict = value as? Dictionary<String, Any> {
                                               var dictValue = dict
                                               if let videoUrlString = videoUrl?.absoluteString {
                                                   dictValue["videoUrl"] = videoUrlString
                                               }
                                               onSuccess(dictValue)
                                           }
                                       }, onError: { (errorMessage) in
                                           onError(errorMessage)
                                       })
                }
                
//                if let metaImageUrl = url?.absoluteString {
//                    let dict: Dictionary<String, Any> = [
//                        "imageUrl": metaImageUrl as Any,
//                        "height": imagePhoto.size.height as Any,
//                        "width": imagePhoto.size.width as Any,
//                        "text": "" as Any
//                    ]
//                    onSuccess(dict)
//                }
            })
            }
    }
    
    static func thumbnailImageForFileUrl(_ url: URL) -> UIImage? {
           let asset = AVAsset(url: url)
           let imageGenerator = AVAssetImageGenerator(asset: asset)
           imageGenerator.appliesPreferredTrackTransform = true
           var time = asset.duration
           time.value = min(time.value, 2)
           do {
               let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
               return UIImage(cgImage: imageRef)
           } catch let error as NSError {
               print(error.localizedDescription)
               return nil
           }
       }
       
    static func savePhotoMessage(image:UIImage?, id:String, onSuccess: @escaping(_ value:Any) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        if let imagePhoto = image{
            let ref = Ref().storageSpecificImageMessage(id: id)
            if let data = imagePhoto.jpegData(compressionQuality: 0.5){
                ref.putData(data, metadata: nil){(metadata, error) in
                    if error != nil {
                        onError(error!.localizedDescription)
                    }
                    ref.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            let dict: Dictionary<String, Any> = [
                                "imageUrl": metaImageUrl as Any,
                                "height": imagePhoto.size.height as Any,
                                "width": imagePhoto.size.width as Any,
                                "text": "" as Any
                            ]
                            onSuccess(dict)
                        }
                    })
                }
            }
        }
    }
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
     static func savePhoto1(username: String, uid: String, data: Data, metadata: StorageMetadata, storagerProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
            
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
                    dictTemp["image1Url"] = metaImageUrl
                    
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
