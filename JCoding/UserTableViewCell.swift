//
//  UserTableViewCell.swift
//  JCoding
//
//  Created by himanshu on 03/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var user:User!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
        // Initialization code
    }
    func loadData(_ user:User){
        self.user = user
        self.userName.text = user.username
        self.status.text = user.Status
        self.avatar.loadImage(user.profileImageUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
