//
//  AddLocationViewController.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/24/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet var textName: UITextField!
    @IBAction func btnSave(sender: AnyObject) {
        
        let newLocation = WeatherLocation(name: textName.text!)

        WeatherLocationStore.sharedInstance.allLocations.append(newLocation)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
