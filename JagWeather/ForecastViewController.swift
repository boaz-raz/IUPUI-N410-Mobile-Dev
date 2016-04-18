//
//  ForecastViewController.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/16/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    
    @IBOutlet weak var lblLocationName: UILabel!
    

    @IBOutlet weak var lbllocationName: UILabel!
    
    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var imgUrl: UIImageView!
    
    @IBOutlet weak var lblForecast: UILabel!
    
    @IBOutlet weak var lblDay2: UILabel!

    @IBOutlet weak var lblForecast2: UILabel!
    
    @IBOutlet weak var lblDay3: UILabel!
    
    @IBOutlet weak var lblForecast3: UILabel!
    
    var thisLocation: WeatherLocation!
    
    
    // show the state location lable
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        print(thisLocation.city)
        
        APIManager.sharedInstance.retrieveFrecastData(thisLocation.zmw)
        
        
        lbllocationName.text = " 3 days forecast for : " + thisLocation.name
        

        
        // SET UP OURSELVES AS A LISTENER FOR ConditionResults NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateConditions:",
            name: "ForecastResults",
            object: nil)

    } // end viewWillAppear
    
    
    
    
    func updateConditions(notification:NSNotification) {

        let conditionData:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        
        // TESTING
//        print(conditionData["11"]!)
//        print(conditionData["12"]!)
//        print(conditionData["13"]!)
//        print("------------")
//        
//        
//        
//        print(conditionData["21"]!)
//        print(conditionData["22"]!)
//        print(conditionData["23"]!)
//        print("------------")
//        
//        
//        print(conditionData["31"]!)
//        print(conditionData["32"]!)
//        print(conditionData["33"]!)
//        print("------------")
        
        if let url = NSURL(string: "\(conditionData["13"])") {
            if let data = NSData(contentsOfURL: url) {
                imgUrl.image = UIImage(data: data)
                print("TEST THE ITMG URL")
            }        
        }
        
        lblDay.text = conditionData["11"]
        lblForecast.text = conditionData["12"]
        //imgUrl.image = UIImage(data: "http://icons.wxug.com/i/c/k/clear.gif")
        
        lblDay2.text = conditionData["21"]
        lblForecast2.text = conditionData["22"]
        
        lblDay3.text = conditionData["31"]
        lblForecast3.text = conditionData["32"]
    
    } // END updateConditions
    
} // END CLASS