//
//  ForecastViewController.swift
//  JagWeather
//
//
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    // this is just testing if the object passed
    
    @IBOutlet var areaLabel: UILabel!
    
    // show the state location lable
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        areaLabel.text = " My object: " + thisLocation.name
        
    } // end viewWillAppear
    
    
    var thisLocation: WeatherLocation!
    
}
