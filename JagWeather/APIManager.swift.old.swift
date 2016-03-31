//
//  APIManager.swift
//  JagWeather
//
//  Created by Elliott, Rob on 2/29/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

// DECLARE A STRUCT THAT WILL HOLD OUR DATA ABOUT OUR POSSIBLE WEATHER LOCATIONS

struct PossibleWeatherLocation {
    
    var name: String?
    var country: String?
    var latitude: Double?
    var longitude: Double?
    var zmw: String?
    
}

// DECLARE A CLASS FOR API MANAGER
class APIManager: NSObject {
    
    
    // MAKE THIS CLASS A SINGLETON
    static let sharedInstance = APIManager()
    
    // DECLARE THE URL THAT WILL BE THE BASE OF OUR AUTOCOMPLETE LOOKUP
    let autoCompleteURLString: String = "https://autocomplete.wunderground.com/aq?h=0&query="
    
    
    // DECLARE THE URL THAT WILL BE THE BASE OF OUR GEOLOOKUP
    let geolookupURLString: String = "https://api.wunderground.com/api/4009a293c3e11ed0/geolookup/q/zmw="
    
    
    // OBJECT FOR SENDING AND RECEIVING HTTP REQUESTS
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    // USE AN NSURLSessionDataTask TO EXECUTE A "GET" REQUEST AND RETRIEVE DATA INTO MEMORY
    var dataTask: NSURLSessionDataTask?
    
    
    // CREATE A VARIABLE THAT ALLOWS US TO STORE AN ARRAY OF POSSIBLEWEATHERLOCATIONS RETRIEVED IN SEARCH
    var searchResultLocations = [PossibleWeatherLocation]()
    
    
    // THIS FUNCTION WILL INITIATE THE CALL TO THE API
    func retrieveAutocompleteData(searchText: String) {
        
        // CANCEL ANY EXISTING CALLS TO THE API
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        
        // SHOW THE USER THE NETWORK ACTIVITY INDICATOR
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // BUILD OUR QUERY
        
        let expectedCharset = NSCharacterSet.URLQueryAllowedCharacterSet()
        
        let searchTerm = searchText.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharset)!
        
        let requestURL: NSURL = NSURL(string: "\(autoCompleteURLString)\(searchTerm)")!
        
        
        // SET UP THE DATA RETRIEVAL TASK AND WRITE THE CODE TO EXECUTE WHEN THE TRANSACTION IS COMPLETE
        
        dataTask = defaultSession.dataTaskWithURL(requestURL, completionHandler: processAutoCompleteData)
        
        
        // START THE DATA RETRIEVAL IN A BACKGROUND THREAD
        dataTask!.resume()
        
    }
    
    
    // THIS FUNCTION TAKES IN THE "data" FROM THE API AND PROCESSES IT
    func processAutoCompleteData (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        
        // THIS HAS TO CALL THE MAIN THREAD BECAUSE UI ACTIVITY ALWAYS HAPPENS ON THE MAIN THREAD
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        // CLEAR OUT THE PREVIOUS SEARCH RESULTS
        searchResultLocations.removeAll()
        
        // CHECK DATA FOR ERRORS
        
        if let error = error {
            
            print("Autocomplete lookup \(error.localizedDescription)")
            
        }
            
        else if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 { // THIS IS THE CODE FOR A VALID, COMPLETE RESPONSE
                
                
                print("AutoComplete data retrieved!")
                //print(data)
                
                
                do {
                    // PARSE RETURNED DATA INTO JSON
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                // GRAB THE ARRAY FOUND IN THE RESULTS OBJECT
                if let foundLocations = jsonData["RESULTS"] as? [[String: AnyObject]] {
                    
                    // LOOP THROUGH THE ARRAY
                    for thisLocation in foundLocations {
                        
                        let newLocation = PossibleWeatherLocation(
                            name: thisLocation["name"]! as? String,
                            country: thisLocation["c"]! as? String,
                            latitude: thisLocation["lat"]!.doubleValue as Double,
                            longitude: thisLocation["lon"]!.doubleValue as Double,
                            zmw: thisLocation["zmw"]! as? String)
                        
                        searchResultLocations.append(newLocation)
                        
                        //print(thisLocation)
                        
                    }
                    
                    print("Found \(searchResultLocations.count) search locations")
                    
                    // PUNT PROCESSING TO MAIN THREAD
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        // POST NOTIFICATION TO NOTIFICATION CENTER
                        NSNotificationCenter.defaultCenter().postNotificationName("AutocompleteResults", object: self)
                        
                    }
                    
                    
                }
                    
                    
                    
                } catch {
                    print("Error serializing JSON: \(error)")
                }
                
                
            }
            
        }


    }// END processAutoCompleteData
    
    
    
    // THIS FUNCTION WILL INITIATE THE CALL TO THE API FOR GEOLOOKUP
    func retrieveGeolookupData(zmw: String) {
        
        // CANCEL ANY EXISTING CALLS TO THE API
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        
        // SHOW THE USER THE NETWORK ACTIVITY INDICATOR
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // BUILD OUR QUERY
        
//        let expectedCharset = NSCharacterSet.URLQueryAllowedCharacterSet()
//        
//        let searchTerm = searchText.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharset)!
        
let requestURL:NSURL = NSURL(string: "\(geolookupURLString)\(zmw).json")!
        
        
        // SET UP THE DATA RETRIEVAL TASK AND WRITE THE CODE TO EXECUTE WHEN THE TRANSACTION IS COMPLETE
        
        dataTask = defaultSession.dataTaskWithURL(requestURL, completionHandler: processGeolookupData)
        
        
        // START THE DATA RETRIEVAL IN A BACKGROUND THREAD
        dataTask!.resume()
        
    }

    
    
    // THIS FUNCTION TAKES IN THE "data" FROM THE GEOLOOKUP API AND PROCESSES IT
    func processGeolookupData (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        
        // THIS HAS TO CALL THE MAIN THREAD BECAUSE UI ACTIVITY ALWAYS HAPPENS ON THE MAIN THREAD
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
//        
//        // CLEAR OUT THE PREVIOUS SEARCH RESULTS
//        searchResultLocations.removeAll()
        
        // CHECK DATA FOR ERRORS
        
        if let error = error {
            
            print("Geolookup error ALERT HELP CRAP  \(error.localizedDescription)")
            
        }
            
        else if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 { // THIS IS THE CODE FOR A VALID, COMPLETE RESPONSE
                
                
                print("Geolookup data retrieved!")
                //print(data)
                
                
                do {
                    // PARSE RETURNED DATA INTO JSON
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let thisLocation = jsonData.objectForKey("location") as? [String:AnyObject] {
                        
                        let name: String = "\(thisLocation["city"]), \(thisLocation["state"])"
                        
                        let city: String = thisLocation["city"] as! String
                        let state: String = thisLocation["state"] as! String
                        let country: String = thisLocation["country_name"] as! String
                        let latitude: Double = thisLocation["lat"]!.doubleValue as Double
                        let longitude: Double = thisLocation["lon"]!.doubleValue as Double
                        
                        let zmw: String = "\(thisLocation["zip"]).\(thisLocation["magic"]).\(thisLocation["wmo"])"
                        
                        let newLocation = WeatherLocation(name: name, city: city, state: state, country: country, latitude: latitude, longitude: longitude, elevation: 0.0, zmw: zmw)
                        
                        WeatherLocationStore.sharedInstance.allLocations.append(newLocation)
                        
                        
                    }
                        
                        // PUNT PROCESSING TO MAIN THREAD
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            // POST NOTIFICATION TO NOTIFICATION CENTER
                            NSNotificationCenter.defaultCenter().postNotificationName("GeolookupResults", object: self)
                            
                        }

                    
                    
                } catch {
                    print("Error serializing JSON: \(error)")
                }
                
                
            }
            
        }
        
        
    }// END processGeolookupData
    
    
    
    
    
    

} // END APIManager class
