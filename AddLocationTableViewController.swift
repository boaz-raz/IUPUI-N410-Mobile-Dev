
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
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateReachResultsTable", name: "AutocompleteResults", object: nil)
    }
    
    
    
    
    
    // Delegate method for UIsearchcontroller
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("\(searchController.searchBar.text)")
        
        if (searchController.searchBar.text!.characters.count) > 2{
            
            APIManager.sharedInstance.retrieveAutocompleteData(searchController.searchBar.text!)
        }
      
        

    }
    
    
    
    // ADD function here!!
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
//        APIManager.sharedInstance.retrieveAutocompleteData()
    }
    

    
    // TABLE VIEW METHODS
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("locationTableResusblleCell", forIndexPath: indexPath)
            
            let possibleLocation = APIManager.sharedInstance.searchResultLocations[indexPath.row]
            
            cell.textLabel!.text = possibleLocation.name
        
            return cell
    }
    
    func updatesearchResutabel(){
        tableView.reloadData()
    }

    
    
} // END AddLocationTabelViewController
