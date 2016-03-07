//
//  APIManager.swift
//  JagWeather
//
//  Created by Boaz Raz on 2/29/16.
//  Copyright © 2016 Rob Elliott. All rights reserved.
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
    
    
    // OBJECT FOR SENDING AND RECEIVING HTTP REQUESTS
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    // USE AN NSURLSessionDataTask TO EXECUTE A "GET" REQUEST AND RETRIEVE DATA INTO MEMORY
    var dataTask: NSURLSessionDataTask?
    
    
    // CREATE A VARIABLE THAT ALLOWS US TO STORE AN ARRAY OF WEATHERLOCATIONS RETRIEVED IN SEARCH
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
                
                    let jasonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let foundLocations = jasonData["RESULTS"] as? [[String: AnyObject]] {
                        
                        for thisLocation in foundLocations {
                            //print(thisLocation)
                            
                            let newLocation = PossibleWeatherLocation(name: thisLocation["name"]! as? String, country: thisLocation["c"]! as? String, latitude: thisLocation["lat"]! as? Double, longitude: thisLocation["lon"]! as? Double, zmw: thisLocation["zmw"]! as? String)
                            
                            searchResultLocations.append(newLocation)

                        }
                        
                        print("Found \(searchResultLocations.count) Locations")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            NSNotificationCenter.defaultCenter().postNotificationName("AutocompleteResults", object: self)
                        }
                        
                    } // END LOOP
                    
                }  catch {
                    print("Error serilizing JASON: \(error)")
                }
                
                
                
                }
            
        } // END processAutoCompleteData
        
        
    }; // END APIManager class
}