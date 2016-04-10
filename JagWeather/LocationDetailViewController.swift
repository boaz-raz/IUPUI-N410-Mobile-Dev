//
//  LocationDetailViewController.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/16/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var lblCondition: UILabel!
    

    @IBOutlet weak var bkImage: UIImageView!
        
    @IBOutlet weak var lblText: UILabel!
    var thisLocation: WeatherLocation!
    
    override func viewWillAppear(animated: Bool) {
        
        print(thisLocation.city)
        
        APIManager.sharedInstance.retrieveConditionData(thisLocation.zmw)
        
        
        // SET UP OURSELVES AS A LISTENER FOR ConditionResults NOTIFICATION
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateConditions:",
            name: "ConditionResults",
            object: nil)
        
    }
    

    func updateConditions(notification:NSNotification) {
        print("I am going to update conditions now!")
        
        let conditionData:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
        
        print(conditionData["temp_f"]!)
        print(conditionData["wind_string"]!)
        print(conditionData["display_location"]!)
        print(conditionData["weather"]!)
        
    
        lblCity.text = conditionData["display_location"]
        lblTemp.text = conditionData["temp_f"]
        lblWind.text = conditionData["wind_string"]
        
        lblText.text = conditionData["temp_f"]
        lblCondition.text = conditionData["weather"]
        
        
        // Change the background image on each diffrent wether condition
        if(conditionData["weather"] == "Overcast"){
            lblCondition.text = conditionData["weather"]
            bkImage.image = UIImage(named: "overcast.jpg")
            
        } else if (conditionData["weather"] == "Rain"){
            bkImage.image = UIImage(named: "rain.jpg")
            
        } else if (conditionData["weather"] == "Partly Cloudy") {
            
            bkImage.image = UIImage(named: "partlyCloudy.jpg")
            
        } else if (conditionData["weather"] == "Clear") {
            
            bkImage.image = UIImage(named: "clear.jpg")
            
        } else if (conditionData["weather"] == "Mostly Cloudy") {

            bkImage.image = UIImage(named: "mostlyCloudy.jpg")
            
        } else if (conditionData["weather"] == "Snow") {
            
            bkImage.image = UIImage(named: "snow.jpg")
            
        } else if (conditionData["weather"] == "Fog") {
            
            bkImage.image = UIImage(named: "fog.jpg")
        } else {
            bkImage.image = UIImage(named: "paradise.jpgi")
        }

        
        activityIndicator.stopAnimating()
    }
    
}
