//
//  DogInfoViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import Foundation
class randomuser {
    static var dogname: String?

}
class DogInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var namedog: UITextField!
    
    //@IBOutlet weak var biodog: UITextView!
    
    @IBAction func buttonClicked(_ sender: Any) {
        randomuser.dogname = namedog.text!

        //randomuser.dogbio = biodog.text!
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        namedog.delegate = self

            //biodog.delegate = self


        // Do any additional setup after loading the view.
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
