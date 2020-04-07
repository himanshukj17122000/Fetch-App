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
}
