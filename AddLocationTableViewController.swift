
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
    }
    
    // Delegate method for UIsearchcontroller
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("\(searchController.searchBar.text)")
        
        if (searchController.searchBar.text!.characters.count) > 2{
            
            APIManager.sharedInstance.retrieveAutocompleteData(searchController.searchBar.text!)
        }
        

    }
    
    
    
} // END AddLocationTabelViewController
