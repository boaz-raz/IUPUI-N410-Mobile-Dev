//
//  WeatherLocation.swift
//  JagWeather
//
//  Created by Rob Elliott on 2/16/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class WeatherLocation: NSObject {
    var name: String
    var city: String
    var state: String
    var country: String
    var latitude: Double
    var longitude: Double
    var elevation: Double
    var zmw: String
    
    init (name: String, city: String, state: String, country: String, latitude: Double, longitude: Double, elevation: Double, zmw: String) {
        self.name = name
        self.city = city
        self.state = state
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.elevation = elevation
        self.zmw = zmw
        
        super.init()
    }
}
