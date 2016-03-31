//
//  LocationDetailViewController.swift
//  JagWeather
//
//
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet var areaLabel: UILabel!
    
    var thisLocation: WeatherLocation!
    
    
    
    // show the state location lable
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        areaLabel.text = thisLocation.name
        
        print(thisLocation.city)
        
        //APIManager.sharedInstance.retrieveConditionData(thisLocation.zmw)
        
        
        // SET UP OURSELVES AS A LISTENER FOR ConditionResults NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateConditions",
            name: "ConditionResults",
            object: nil)
        
    
    } // end viewWillAppear
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "locationForecast" {
            
            
            let forecastViewController = segue.destinationViewController as! ForecastViewController
            
            forecastViewController.thisLocation = thisLocation
            
            
            
            
        } // end if
        
        
    } // end prepareForSegue
    
} // end class
