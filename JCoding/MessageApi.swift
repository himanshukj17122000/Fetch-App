//
//  MessageApi.swift
//  JCoding
//
//  Created by himanshu on 07/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation

class MessageApi{
    func sendMessage(from:String, to:String, value:Dictionary<String,Any>){
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.childByAutoId().updateChildValues(value)
        
    }
    func receiveMessages(from:String, to:String, onSuccess: @escaping(Message) -> Void){
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.observe(.childAdded){ (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key){
                onSuccess(message)
                }
            }
    }
}
}
