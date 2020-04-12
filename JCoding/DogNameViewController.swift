//
//  DogNameViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class DogNameViewController: UIViewController {

   
    @IBOutlet var genderOptions: [UIButton]!
    
    @IBAction func genderTapped(_ sender: UIButton) {
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
