//
//  LocationViewController.swift
//  JCoding
//
//  Created by Bilge Tatar on 4/19/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    @IBAction func close(_ sender: Any) {
navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        randomuser.doglat = locValue.latitude
        randomuser.doglong = locValue.longitude
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        print(randomuser.doglat ??  0)
        print(randomuser.doglong ?? 0)
        
    }
}
