//
//  ForecastViewController.swift
//  JagWeather
//
//  Created by Rob Elliott on 2/16/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
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
