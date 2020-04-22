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
        var dict = value
        if let text = dict["text"] as? String, text.isEmpty{
            dict["imageUrl"] = nil
            dict["height"] = nil
            dict["width"] = nil
        }
        let refFrom = Ref().databaseInbox(from: from, to: to)
        refFrom.childByAutoId().updateChildValues(dict)
        
        let refTo = Ref().databaseInbox(from: to, to: from)
        refTo.childByAutoId().updateChildValues(dict)
        
        
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
