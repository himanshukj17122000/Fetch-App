//
//  ProfileTableViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/12/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var dognamelbl: UITextField!
    @IBOutlet weak var dogagelbl: UITextField!
    @IBOutlet weak var dogbreedlbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeData()
    
    }
    func observeData() {
    }

}
