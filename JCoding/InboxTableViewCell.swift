//
//  InboxTableViewCell.swift
//  JCoding
//
//  Created by himanshu on 22/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var avatr: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(uid:String, inbox:Inbox){
        avatr.loadImage(inbox.user.profileImageUrl)
        name.text = inbox.user.username
        
        if !inbox.text.isEmpty{
            status.text = inbox.text
            
        } else {
            status.text = "[MEDIA]"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
