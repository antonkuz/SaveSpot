//
//  HistoryTVC.swift
//  SaveSpot
//
//  Created by Anton Kuznetsov on 12/7/15.
//  Copyright © 2015 Anton Kuznetsov. All rights reserved.
//
import UIKit
import CoreLocation

class HistoryTVController: UITableViewController {
    
    @IBAction func closePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spotList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HistoryTVCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HistoryTVCell
        // Configure the cell...
        let spot = spotList[indexPath.row]
        cell.titleString.text = spot.name
        CLGeocoder().reverseGeocodeLocation(spot.location, completionHandler: {
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
                cell.subtitleString.text = addressString
            }
        })
        return cell
    }
    
    // Preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let locationDetailVC = segue.destinationViewController as! ShowLocationVC
            
            // Get the cell that generated this segue.
            if let selectedSpotCell = sender as? HistoryTVCell {
                let indexPath = tableView.indexPathForCell(selectedSpotCell)!
                let selectedSpot = spotList[indexPath.row]
                locationDetailVC.historySpot = selectedSpot
            }
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            spotList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
