//
//  DataManager.swift
//  Forecast
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    static let sharedInstance = DataManager()
    
    //MARK: - Properties
    
    var baseURLString = "api.forecast.io"
    var currentWeather = Locations()
    
    
    
    //MARK: - Get Data Methods
    
    func parseWeatherData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("currently") as! NSDictionary
            
            let newLoc = Locations()
            newLoc.temperature = tempDictArray.objectForKey("temperature") as! NSNumber
            newLoc.icon = tempDictArray.objectForKey("icon") as! String
            newLoc.precipProbability = tempDictArray.objectForKey("precipProbability") as! NSNumber
            newLoc.summary = tempDictArray.objectForKey("summary") as! String
            currentWeather = newLoc
            print("Icon:\(newLoc.icon) + Precip:\(newLoc.precipProbability) + Summary:\(newLoc.summary) + Temp:\(newLoc.temperature)")
            dispatch_async(dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
            }
        } catch {
            print("JSON parsing error")
        }
    }
    
    func getDataFromServer(coordinateString: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "https://\(baseURLString)/forecast/1c6466ee433871019969e4719519e4b9/\(coordinateString)")
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data!")
                self.parseWeatherData(data!)
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
}
