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
    static var dogbio: String!
}
class DogNameViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var DogBreed: UITextField!
    @IBOutlet weak var DogAge: UITextField!
    @IBOutlet weak var DogName: UITextField!
    @IBOutlet weak var DogBio: UITextView!
    
    @IBOutlet var genderOptions: [UIButton]!
    
    @IBAction func buttonClicked(_ sender: Any) {
        randomuser.dogname = DogName.text!
        print(DogName.text!)
        print(randomuser.dogname)
        randomuser.dogage = DogAge.text!
        randomuser.dogbreed = DogBreed.text!
        randomuser.dogbio = DogBio.text!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func handleSelection(_ sender: UIButton) {
        genderOptions.forEach { (button) in
            UIView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()

            }
            
        }
    }

}
