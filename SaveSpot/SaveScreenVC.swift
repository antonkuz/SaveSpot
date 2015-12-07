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
    var lastLocation : CLLocation?
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func savePressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter name", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            (textField) -> Void in
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
            
            let textf = alert.textFields![0] as UITextField
            lastSpot = Spot(name: textf.text!, location: self.lastLocation!)
            spotList.append(lastSpot!)
            self.dismissViewControllerAnimated(true, completion:nil)
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
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Location to be saved"
        
        //delete old annotations
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove)
        
        //add new one
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        
        addressLabel.text = "\(location!.coordinate.latitude) , \(location!.coordinate.longitude) "
        self.lastLocation = location
        
        locationMgr.stopUpdatingLocation()
        
        CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {
            (placemarks, error) -> Void in
            if placemarks!.count > 0{
                let placemark = placemarks![0]
                
                var addressString : String = ""
                if placemark.subThoroughfare != nil {
                    addressString = placemark.subThoroughfare! + " "
                }
                if placemark.thoroughfare != nil {
                    addressString = addressString + placemark.thoroughfare! + ", "
                }
                if placemark.postalCode != nil {
                    addressString = addressString + placemark.postalCode! + " "
                }
                if placemark.locality != nil {
                    addressString = addressString + placemark.locality! + ", "
                }
                if placemark.administrativeArea != nil {
                    addressString = addressString + placemark.administrativeArea! + " "
                }
                if placemark.country != nil {
                    addressString = addressString + placemark.country!
                }
                self.addressLabel.text = addressString
            }
        })
    }
}