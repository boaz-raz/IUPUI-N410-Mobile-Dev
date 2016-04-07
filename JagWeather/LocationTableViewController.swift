//
//  LocationTableViewController.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/16/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var weatherLocationStore: WeatherLocationStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LISTEN FOR NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "refreshTable",
            name: "GeolookupResults",
            object: nil)
    }
    
    func refreshTable() {
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        print(WeatherLocationStore.sharedInstance.allLocations.count)
        
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
        
        if segue.identifier == "locationDetail" {
            
            let detailVC = segue.destinationViewController as! LocationDetailViewController
            
            if let row = tableView.indexPathForSelectedRow?.row {
                let tappedLocation = WeatherLocationStore.sharedInstance.allLocations[row]
                detailVC.thisLocation = tappedLocation
            }
            
        }
        
    }
    
    
    
}













