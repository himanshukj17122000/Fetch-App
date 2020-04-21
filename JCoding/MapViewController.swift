//
//  MapViewController.swift
//  JCoding
//
//  Created by Donald Groh on 4/20/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnnotation()

        // Do any additional setup after loading the view.
    }
    
    func addAnnotation() {
        var nearByAnnotations: [MKAnnotation] = []
        for user in users {
            let location = CLLocation(latitude: Double(user.dogslat), longitude: Double(user.dogslong))
            
            let annotation = UserAnnotation()
            annotation.coordinate = location.coordinate
            nearByAnnotations.append(annotation)
            
        }
        self.mapView.showAnnotations(nearByAnnotations, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func BackBtnDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
