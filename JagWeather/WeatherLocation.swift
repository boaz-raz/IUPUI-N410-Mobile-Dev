//
//  WeatherLocation.swift
//  JagWeather
//
//  Created by Rob Elliott on 2/16/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class WeatherLocation: NSObject, NSCoding {
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
    
    
    init (name: String) {
        self.name = name
        self.city = ""
        self.state = ""
        self.country = ""
        self.latitude = 0
        self.longitude = 0
        self.elevation = 0
        self.zmw = ""
        
        super.init()
    }
    
    
    // CODE CHUNK 1:
    // THE FOLLOWING METHODS ALLOW THE WEATHERLOCATION CLASS TO ENCODE AND DECODE INSTANCES SO THAT THEY CAN BE ARCHIVED
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(city, forKey: "city")
        aCoder.encodeObject(state, forKey: "state")
        aCoder.encodeObject(country, forKey: "country")
        
        aCoder.encodeDouble(latitude, forKey: "latitude")
        aCoder.encodeDouble(longitude, forKey: "longitude")
        aCoder.encodeDouble(elevation, forKey: "elevation")
        
        aCoder.encodeObject(zmw, forKey: "zmw")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        city = aDecoder.decodeObjectForKey("city") as! String
        state = aDecoder.decodeObjectForKey("state") as! String
        country = aDecoder.decodeObjectForKey("country") as! String
        
        latitude = aDecoder.decodeDoubleForKey("latitude")
        longitude = aDecoder.decodeDoubleForKey("longitude")
        elevation = aDecoder.decodeDoubleForKey("elevation")
        
        zmw = aDecoder.decodeObjectForKey("zmw") as! String
    }

    
    
    
}
