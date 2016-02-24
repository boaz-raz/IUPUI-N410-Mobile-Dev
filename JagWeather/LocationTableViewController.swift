//
//  LocationTableViewController.swift
//  JagWeather
//
//  Created by Rob Elliott on 2/16/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var weatherLocationStore: WeatherLocationStore!
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocationStore.allLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Create or grab a reuseable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        
        // Get an instance of IKEA for the correct location in the table
        let WeatherLocation = weatherLocationStore.allLocations[indexPath.row]
        
        
        cell.textLabel?.text = WeatherLocation.name
        
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Check segue name
        
        if segue.identifier == "locationDetail" {
            
            //Figure out which row was selected
            if let row = tableView.indexPathForSelectedRow?.row {
                let tappedLocatoin = weatherLocationStore.allLocations[row]
                
                let detailViewController = segue.destinationViewController as! LocationDetailViewController
                
                detailViewController.thisLocation = tappedLocatoin
                
                
            } // end if let
            
        }// end if segue
    } // end prepareForSegue

} // end of class