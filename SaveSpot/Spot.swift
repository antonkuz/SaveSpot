//
//  Spot.swift
//  SaveSpot
//
//  Created by Anton Kuznetsov on 12/7/15.
//  Copyright © 2015 Anton Kuznetsov. All rights reserved.
//

import CoreLocation

class Spot{
    var name: String
    var location: CLLocation
    
    init(name: String, location: CLLocation) {
        // Initialize stored properties.
        self.name = name
        self.location = location
    }
}