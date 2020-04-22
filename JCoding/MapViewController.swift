//
//  MapViewController.swift
//  JCoding
//
//  Created by Donald Groh on 4/20/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        addAnnotation()

        // Do any additional setup after loading the view.
    }
    
    func addAnnotation() {
        var nearByAnnotations: [MKAnnotation] = []
        for user in users {
            let location = CLLocation(latitude: Double(user.dogslat), longitude: Double(user.dogslong))
            
            let annotation = UserAnnotation()
            annotation.title = user.dogname
            annotation.subtitle = "Gender: \(user.dogGender)"
//            let profileImageurl = user.profileImageUrl
            let url = URL(string:user.profileImageUrl)
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data)!
                annotation.profileImage = image
            }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        var annotationView: MKAnnotationView?
        
        // reuse the annotation if possible
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "icon-user")
        } else if let deqAno = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = deqAno
            annotationView?.annotation = annotation
        } else {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annoView.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            annotationView = annoView
        }
        
        if let annotationView = annotationView, let anno = annotation as? UserAnnotation {
            annotationView.canShowCallout = true
            
            let image = anno.profileImage
            let resizeRenderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            resizeRenderImageView.layer.cornerRadius = 25
            resizeRenderImageView.clipsToBounds = true
            resizeRenderImageView.contentMode = .scaleAspectFill
            resizeRenderImageView.image = image
            
            UIGraphicsBeginImageContextWithOptions(resizeRenderImageView.frame.size, false, 0.0)
            resizeRenderImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            annotationView.image = thumbnail
            
//            let btn = UIButton()
//            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            btn.setImage(UIImage(named: "icon-direction"), for: UIControl.State.normal)
//            annotationView.rightCalloutAccessoryView = btn
//
//            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//            annotationView.leftCalloutAccessoryView = leftIconView
        }
        return annotationView
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
