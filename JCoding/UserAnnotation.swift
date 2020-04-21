//
//  UserAnnotation.swift
//  JCoding
//
//  Created by Donald Groh on 4/20/20.
//  Copyright © 2020 himanshu. All rights reserved.
//


import Foundation
import MapKit

class UserAnnotation: MKPointAnnotation {
    var uid: String?
    var age: Int?
    var profileImage: UIImage?
    var isMale: Bool?
}
