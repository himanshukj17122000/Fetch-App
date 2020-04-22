//
//  detailViewController.swift
//  JCoding
//
//  Created by Emma Helmich on 4/20/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    
    

    @IBOutlet weak var MessageBtn: UIButton!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    //var user : User?
    var info : String = ""
    var distance : String = ""
    var gender : String = ""
    var name : String = ""
    var pic : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLbl.text = info
        genderLbl.text = gender
        locLbl.text = distance
        nameLbl.text = name
        photo.image = pic
    }

        
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//
//        // and cast it to the correct class type
//
//        let destVC = segue.destination as! ChatViewController
//        
//        // set the destVC variables from the selected row
//        destVC.imagePartner = pic
//        destVC.userName = user!.username
//        destVC.otherUser = user!.uid
//
//    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
