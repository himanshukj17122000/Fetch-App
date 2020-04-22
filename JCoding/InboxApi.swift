//
//  InboxApi.swift
//  JCoding
//
//  Created by himanshu on 22/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import Foundation
import Firebase

typealias InboxCompletion = (Inbox) -> Void
class InboxApi{
    func lastMessage(uid:String,onSuccess: @escaping(InboxCompletion) ){
        let ref = Ref().databaseInboxForuser(uid: uid)
        ref.observe(DataEventType.childAdded){(snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any>{
                Api.User.getUserInfo(uid: snapshot.key, onSuccess: {(user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user){
                        onSuccess(inbox)
                    }
                    
                    
            })
        }
    }
}
}
