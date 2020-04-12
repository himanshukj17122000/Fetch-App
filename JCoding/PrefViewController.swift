//
//  PrefViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class PrefViewController: UIViewController {

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
