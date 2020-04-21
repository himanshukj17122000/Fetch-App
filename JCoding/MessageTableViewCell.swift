//
//  MessageTableViewCell.swift
//  JCoding
//
//  Created by himanshu on 08/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var dateMessage: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var photoMessage: UIImageView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 15
        bubbleView.clipsToBounds = true
        bubbleView.layer.borderWidth = 0.4
        textMessage.numberOfLines = 0
        photoMessage.layer.cornerRadius = 15
        photoMessage.clipsToBounds = true
        profileImage.layer.cornerRadius = 16
        profileImage.clipsToBounds = true
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessage.isHidden = true
        // Initialization code
    }
    func configureCell(uid:String, message:Message, image:UIImage){
        let text = message.text
        if !text.isEmpty{
            textMessage.isHidden = false
            textMessage.text = message.text
            let widthValue = text.estimateFrameForText(text: text).width
                if widthValue < 100 {
                    widthConstraint.constant = 100
                } else {
                    widthConstraint.constant = widthValue
                }
                dateMessage.textColor = .lightGray

            } else {
                photoMessage.isHidden = false
                photoMessage.loadImage(message.imageUrl)
                bubbleView.layer.borderColor = UIColor.clear.cgColor
                widthConstraint.constant = 250
                dateMessage.textColor = .white

            }
        if uid == message.from {
                   bubbleView.backgroundColor = UIColor.groupTableViewBackground
                   bubbleView.layer.borderColor = UIColor.clear.cgColor
                   rightConstraint.constant = 8
                   rightConstraint.constant = UIScreen.main.bounds.width - widthConstraint.constant - rightConstraint.constant
               } else {
                   profileImage.isHidden = false
                   bubbleView.backgroundColor = UIColor.white
                   profileImage.image = image
                   bubbleView.layer.borderColor = UIColor.lightGray.cgColor
                   leftConstraint.constant = 55
                   rightConstraint.constant = UIScreen.main.bounds.width - widthConstraint.constant - leftConstraint.constant
                   
               }
        }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        photoMessage.isHidden = true
              profileImage.isHidden = true
              textMessage.isHidden = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension String {
    func estimateFrameForText(text:String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string:text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize:17)], context: nil)
    }
}
