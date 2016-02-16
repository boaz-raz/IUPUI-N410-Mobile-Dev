//
//  WeatherLocationStore.swift
//  JagWeather
//
//  Created by Rob Elliott on 2/16/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
//

import UIKit

class WeatherLocationStore {
    
    var allLocations = [WeatherLocation]()
    
    init() {
        
        let indianapolis = WeatherLocation(name: "Indianapolis, IN", city: "Indianapolis", state: "IN", country: "US", latitude: 39.77510452, longitude: -86.10947418, elevation: 238.0)
        
        let austin = WeatherLocation(name: "Austin, TX", city: "Austin", state: "TX", country: "US", latitude: 30.280539, longitude: 97.754555, elevation: 167.0)
        
        allLocations.append(indianapolis)
        allLocations.append(austin)
        
    }
}
