//
//  AddLocationTableViewController.swift
//  JagWeather
//
//  Created by Elliott, Rob on 2/29/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class AddLocationTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // DONE BUTTON
    @IBAction func btnDone(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        
        tableView.tableHeaderView = searchController.searchBar

        
        // LISTEN FOR NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateSearchResultsTable",
            name: "AutocompleteResults",
            object: nil)
        
        
    }
    
    // DELEGATE METHOD FOR UISEARCHCONTROLLER
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("\(searchController.searchBar.text!)")
        
        // CALL THE API MANAGER AND SEARCH
        if (searchController.searchBar.text!.characters.count > 2) {
        APIManager.sharedInstance.retrieveAutocompleteData(searchController.searchBar.text!)
            
            // CAN'T RELOAD TABLE DATA HERE
            
        }
    }
    
    
    
    // TABLE VIEW METHODS
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIManager.sharedInstance.searchResultLocations.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
        
        let possibleLocation = APIManager.sharedInstance.searchResultLocations[indexPath.row]
        
        cell.textLabel!.text = possibleLocation.name
        
        return cell
        
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("I clicked a table cell")
        
        // FIGURE OUT WHICH ROW (CELL) WAS CLICKED
        
        if let selectedRow = tableView.indexPathForSelectedRow?.row {
            print ("row is \(selectedRow)")
            
            
            // GET THE POSSIBLE WEATHER LOCATION THAT CORRESPONDS TO THAT CELL
            print (APIManager.sharedInstance.searchResultLocations[selectedRow])
            
            let tappedPossibleLocation = APIManager.sharedInstance.searchResultLocations[selectedRow]
            
            // TELL APIMANAGER TO GET THE GEOLOOKUP INFO FOR THIS POSSIBLE WEATHER LOCATION
            
            APIManager.sharedInstance.retrieveGeolookupData(tappedPossibleLocation.zmw!)
            
            // DISMISS THE ADD LOCATION TABLE VIEW
            searchController.active = false
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    
    
    // RELOAD THE TABLE DATA WHEN NOTIFICATION OCCURS
    func updateSearchResultsTable() {
        tableView.reloadData()
    }
    
    
    
}  // END AddLocationTableViewController











