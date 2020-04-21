//
//  PrefViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class PrefViewController: UIViewController {

    
    
    @IBOutlet weak var PrefFemale: RoundedButton!
    
    @IBOutlet weak var distancelbl: UILabel!
    @IBOutlet weak var PrefBoth: RoundedButton!
    @IBOutlet weak var PrefMale: RoundedButton!
    
    @IBAction func continueTapped(_ sender: Any) {
        randomuser.distance = distancelbl.text
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
   
    @IBAction func PrefFemaleTapped(_ sender: Any) {
        if PrefFemale.backgroundColor == UIColor.white{
            PrefMale.backgroundColor = UIColor.white
            PrefBoth.backgroundColor = UIColor.white
            PrefFemale.backgroundColor = UIColor.lightGray
            randomuser.prefgender = "female"
        }
        else if PrefFemale.backgroundColor == UIColor.lightGray {
            PrefFemale.backgroundColor = UIColor.white
        }
    }
    @IBAction func dismissController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func PrefMaleTapped(_ sender: Any) {
        if PrefMale.backgroundColor == UIColor.white {
            PrefFemale.backgroundColor = UIColor.white
            PrefBoth.backgroundColor = UIColor.white
            PrefMale.backgroundColor = UIColor.lightGray
            randomuser.prefgender = "male"
        }
        else if PrefMale.backgroundColor == UIColor.lightGray {
            PrefMale.backgroundColor = UIColor.white
            
        }
    }
    @IBAction func PrefBothTapped(_ sender: Any) {
        
        if PrefBoth.backgroundColor == UIColor.white {
            PrefMale.backgroundColor = UIColor.white
            PrefFemale.backgroundColor = UIColor.white
            PrefBoth.backgroundColor = UIColor.lightGray
            randomuser.prefgender = "both"
        }
        else if PrefBoth.backgroundColor == UIColor.lightGray {
            PrefBoth.backgroundColor = UIColor.white
        }
    }
    
    @IBOutlet weak var sldr: UISlider!
    @IBOutlet weak var lbl: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        lbl.text = "\(currentValue)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
