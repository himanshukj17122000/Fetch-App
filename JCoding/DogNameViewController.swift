//
//  DogNameViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
class randomuser {
    static var dogname: String!
    static var dogage: String!
    static var dogbreed: String!
    static var doggender: String!
    static var dogbio: String!
}
class DogNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var female: RoundedButton!
    @IBOutlet weak var male: RoundedButton!
    
    @IBOutlet weak var DogBreed: UITextField!
    @IBOutlet weak var DogAge: UITextField!
    @IBOutlet weak var DogName: UITextField!
    
    @IBOutlet weak var DogBio: UITextView!
    
    @IBOutlet var genderOptions: [UIButton]!
    
    @IBAction func femaleClicked(_ sender: Any) {
        if female.backgroundColor == UIColor.white{
            male.backgroundColor = UIColor.white
            female.backgroundColor = UIColor.lightGray
            randomuser.doggender = "female"
        }
        else if female.backgroundColor == UIColor.lightGray {
            female.backgroundColor = UIColor.white
        }
    }
    
    
    @IBAction func maleClicked(_ sender: Any) {
        if male.backgroundColor == UIColor.white{
            female.backgroundColor = UIColor.white
            male.backgroundColor = UIColor.lightGray
            randomuser.doggender = "male"
        }
        else if male.backgroundColor == UIColor.lightGray {
            male.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func continuebuttonClicked(_ sender: Any) {
        randomuser.dogname = DogName.text!
        randomuser.dogage = DogAge.text!
        randomuser.dogbreed = DogBreed.text!
        randomuser.dogbio = DogBio.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    }


