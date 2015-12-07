//
//  ViewController.swift
//  SaveSpot
//
//  Created by Anton Kuznetsov on 12/6/15.
//  Copyright © 2015 Anton Kuznetsov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationMgr = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMgr.delegate = self
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

