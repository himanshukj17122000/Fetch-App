//
//  ChatViewController.swift
//  JCoding
//
//  Created by himanshu on 07/04/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
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
    var pickCamera = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        observeMessages()
        setUpPicker()
        setupInputContainer()
        setupNavigationBar()
        setupTableView()

        // Do any additional setup after loading the view.
    }
    func observeMessages(){
        Api.Message.receiveMessages(from: Api.User.currentUserId, to: otherUser){(message) in
            print(message.id)
        }
        Api.Message.receiveMessages(from: otherUser, to: Api.User.currentUserId){(message) in
                   print(message.id)
               }
       
    }
    func setUpPicker(){
        pickCamera.delegate = self
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

    @IBAction func mediatButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "PetApp", message: "Select Source", preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default){(_) in
            if
                UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            self.pickCamera.sourceType = .camera
            self.present(self.pickCamera, animated: true, completion: nil)
            
            } else {
                print("Unavailable")
            }
        }
      
        let library = UIAlertAction(title: "Choose an Image or a Video", style: UIAlertAction.Style.default){(_) in
            if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                          self.pickCamera.sourceType = .photoLibrary
                self.pickCamera.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
                self.present(self.pickCamera, animated: true, completion: nil)
                
            } else {
                print("Unavailable")
            }
       
    }
        
         let video = UIAlertAction(title: "Take a video", style: UIAlertAction.Style.default){(_) in
                   if
                       UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                   self.pickCamera.sourceType = .camera
                    self.pickCamera.mediaTypes = [String(kUTTypeMovie)]
                    self.pickCamera.videoExportPreset = AVAssetExportPresetPassthrough
                    self.pickCamera.videoMaximumDuration = 30
                   self.present(self.pickCamera, animated: true, completion: nil)
                   
                   } else {
                       print("Unavailable")
                   }
               }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        alert.addAction(video)
        present(alert, animated: true, completion: nil)
        
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

extension ChatViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
            handleVideoSelected(videoUrl)
            
        } else {
            handleImageSelected(info)
        }
    }
    func handleVideoSelected(_ url:URL){
        let videoName = NSUUID().uuidString
        //print(url)
        StorageService.saveVideoMessage(url: url, id: videoName, onSuccess: {(anyValue) in
                if let dict = anyValue as? [String:Any] {
                    self.sendToFirebase(dict: dict)
                }
            }){(errorMessage) in
                
            }
            self.dismiss(animated: true, completion: nil)
        }
    
    func handleImageSelected(_ info:[UIImagePickerController.InfoKey : Any] ){
        var theSelectedImage : UIImage?
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            theSelectedImage = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            theSelectedImage = imageOriginal
        }
        let imageName = NSUUID().uuidString
        StorageService.savePhotoMessage(image: theSelectedImage, id: imageName, onSuccess: {(anyValue) in
            if let dict = anyValue as? [String:Any] {
                self.sendToFirebase(dict: dict)
            }
        }){(errorMessage) in
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

