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
}
