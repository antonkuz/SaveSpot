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

class ShowLocationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // This value may be passed by `HistoryTVController` in `prepareForSegue(_:sender:)`
    var historySpot: Spot?
    
    let locationMgr = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    @IBAction func closePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        locationMgr.delegate = self
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        loadTheLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTheLocation(){
        var spot = lastSpot
        if let oldSpot = historySpot {
            //historyspot was passed
            spot = oldSpot
        }
        let location = spot!.location
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = spot!.name
        mapView.addAnnotation(annotation)
        mapView.setRegion(region,animated:true)
        myPosition = locationMgr.location!.coordinate
    }
}