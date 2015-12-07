//
//  SaveScreenVC.swift
//  SaveSpot
//
//  Created by Anton Kuznetsov on 12/6/15.
//  Copyright © 2015 Anton Kuznetsov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SaveScreenVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func savePressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter additional info", message: "name/floor", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            (textField) -> Void in
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
            
            let textf = alert.textFields![0] as UITextField
            print(textf.text)
            
        }))

        presentViewController(alert, animated: true, completion: nil)
    }
    
    let locationMgr = CLLocationManager()
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        locationMgr.delegate = self
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recalculatePressed(sender: UIButton) {
        locationMgr.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Apple"
        annotation.subtitle = "San Francisco, CA"
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        
        addressLabel.text = "\(location!.coordinate.latitude) , \(location!.coordinate.longitude) "
        
        locationMgr.stopUpdatingLocation()
    }
}