//
//  ChatViewController.swift
//  JCoding
//
//  Created by himanshu on 07/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessage: UIButton!
    @IBOutlet weak var sendText: UITextView!
    @IBOutlet weak var sendAudio: UIButton!
    @IBOutlet weak var sendAttachments: UIButton!
    var imagePartner : UIImage!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var userName : String!
    var placeHolder = UILabel()
    var otherUser : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputContainer()
        setupNavigationBar()
        setupTableView()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        tableView.tableFooterView = UIView()
        
    }
    func setupInputContainer(){
        let mediaImg = UIImage(named: "attachment_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        sendAttachments.setImage(mediaImg, for: UIControl.State.normal)
        sendAttachments.tintColor = .lightGray
        
        let micImg = UIImage(named: "mic")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        sendAudio.setImage(micImg, for: UIControl.State.normal)
        sendAudio.tintColor = .lightGray
        
        setUpTextView()
    }
    
    func setUpTextView(){
        sendText.delegate = self
        placeHolder.isHidden = false
        let placeholderX: CGFloat = self.view.frame.size.width / 75
        let placeholderY: CGFloat = 0
        let placeholderWidth: CGFloat = sendText.bounds.width - placeholderX
        
        let placeholderHeight: CGFloat = sendText.bounds.height
        
        let placeholderFontSize = self.view.frame.size.width / 25
        
        placeHolder.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderWidth, height: placeholderHeight)
        placeHolder.text = "Write a message"
        placeHolder.font = UIFont(name: "HelveticaNeue", size: placeholderFontSize)
        placeHolder.textColor = .lightGray
        placeHolder.textAlignment = .left
        sendText.addSubview(placeHolder)
    }
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        let containView = UIView(frame: CGRect(x: 0 , y:0, width:36, height: 36 ))
        avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containView.addSubview(avatarImageView)
        
        let rightButton = UIBarButtonItem(customView: containView)
        self.navigationItem.rightBarButtonItem = rightButton
        
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: userName + "\n", attributes: [.font : UIFont.systemFont(ofSize:17), .foregroundColor: UIColor.black ])
        
        attributed.append(NSAttributedString(string: "Active", attributes: [.font : UIFont.systemFont(ofSize:13), .foregroundColor: UIColor.green ]))
        topLabel.attributedText = attributed
        self.navigationItem.titleView = topLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func sendDidTap(_ sender: Any) {
        if let text = sendText.text, text != "" {
                   sendText.text = ""
                   self.textViewDidChange(sendText)
                   sendToFirebase(dict: ["text": text as Any])
               }
    }
    func sendToFirebase(dict: Dictionary<String,Any>) {
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = otherUser
        value["date"] = date
        value["read"] = true
        Api.Message.sendMessage(from: Api.User.currentUserId, to: otherUser, value: value)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty {
            let text = textView.text.trimmingCharacters(in: spacing)
            sendMessage.isEnabled = true
            sendMessage.setTitleColor(.black, for: UIControl.State.normal)
            placeHolder.isHidden = true
        } else {
            sendMessage.isEnabled = false
            sendMessage.setTitleColor(.lightGray, for: UIControl.State.normal)
            placeHolder.isHidden = false
        }
    }
}

