//
//  LastLocationVC.swift
//  SaveSpot
//
//  Created by Anton Kuznetsov on 12/7/15.
//  Copyright © 2015 Anton Kuznetsov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LastLocationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationMgr = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        locationMgr.delegate = self
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        print(lastSpot!.name)
        loadTheLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTheLocation(){
        let spot = lastSpot
        let location = spot!.location
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = spot!.name
        mapView.addAnnotation(annotation)
        mapView.setRegion(region,animated:true)
        myPosition = locationMgr.location!.coordinate
    }
}