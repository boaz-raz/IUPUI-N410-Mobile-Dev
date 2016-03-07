
//
//  AddLocationTableViewController.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/29/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class AddLocationTabelViewController: UITableViewController, UISearchResultsUpdating {
    //
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
        
        
        
        //LISTEN FOR NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: "updateSearchResultsTable", name: "AutocompleteResults",object:nil)
        
        
    }
    
    
    //DELEGATE METHOD FOR UISEARCHRESULTSUPDATING
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("\(searchController.searchBar.text!)")
        
        //Call APIManager and Search
        if (searchController.searchBar.text!.characters.count) > 2 {
            APIManager.sharedInstance.retrieveAutocompleteData(searchController.searchBar.text!)
            
            //CAN'T RELOAD TABLE DATA HERE
        }
        
    }
    
    //TABLE VIEW METHODS
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIManager.sharedInstance.searchResultLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("locationTableReusableCell", forIndexPath: indexPath)
        
        let possibleLocation = APIManager.sharedInstance.searchResultLocations[indexPath.row]
        
        cell.textLabel!.text = possibleLocation.name
        
        return cell
    }
    
    func updateSearchResultsTable() {
        tableView.reloadData()
    }

    
    
} // END AddLocationTabelViewController
