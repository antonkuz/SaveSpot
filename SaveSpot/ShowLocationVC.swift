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
    
    var destination : MKMapItem = MKMapItem()
    
    // This value may be passed by `HistoryTVController` in `prepareForSegue(_:sender:)`
    var historySpot: Spot?
    
    let locationMgr = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    @IBAction func closePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer{
        let draw = MKPolylineRenderer(overlay: overlay)
        draw.strokeColor = UIColor.purpleColor()
        draw.lineWidth = 3.0
        print("WASSSSUSUUUP")
        return draw
    }
    
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
        
         //create a place mark and a map item
        let placeMark = MKPlacemark(coordinate: center, addressDictionary: nil)
        
         //This is needed when we need to get direction
        destination = MKMapItem(placemark: placeMark)
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = destination
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            guard let response = response else {
                //handle the error here
                return
            }
            let overlays = self.mapView.overlays
            self.mapView.removeOverlays(overlays)
            
            for route in response.routes {
                
                self.mapView.addOverlay(route.polyline,
                    level: MKOverlayLevel.AboveRoads)
                
                for next  in route.steps {
                    print(next.instructions)
                }
            }
        }
    }
}