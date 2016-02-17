//
//  DataManager.swift
//  Maintain_Tennant
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    var repairsArray = [Repair]()
//    var baseURLString = "e7217d50.ngrok.io"
    var baseURLString = "tenant-manager.herokuapp.com"
    var repairListURLString = "/api/repairs"
    var repairRequestURLString = "/api/request_repair"
    var hostName = ""
    
    
    
    
    //MARK: - Put Methods
    
    
    
    
    func tempAddRecord() {
        let currentRepair = Repair()
        currentRepair.repairTitle = "Kill the Rats"
        currentRepair.repairDesc = "Kill the Rats that are living in my room please!"
        let currentRepair2 = Repair()
        currentRepair2.repairTitle = "Fix the Ceiling"
        currentRepair2.repairDesc = "Some drywall fell on my face last night!"
        
        repairsArray.append(currentRepair)
        repairsArray.append(currentRepair2)
    }
    
    
    
    func postRepairsToServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        
        let url = NSURL(string: "https://\(baseURLString)/\(repairRequestURLString)")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        urlRequest.HTTPMethod = "POST" // OR "PUT"
        let token = "tenant_token"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization") // OR OTHER VALUES FOR OTHER FIELDS
        let postString = "title=\(repairsArray.last!.repairTitle!) & description=\(repairsArray.last!.repairDesc!)"
        let postData = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlRequest.HTTPBody = postData
        
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            
            if data != nil {
                print("Sent Data")
            } else {
                print("Did not send data")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    //MARK: - Get Methods
    
    
    func parseRepairData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("repairs") as! [NSDictionary]
            
            repairsArray.removeAll()
            for repairDict in tempDictArray {
                let newRepair = Repair()
                newRepair.repairTitle = (repairDict.objectForKey("title") as! String)
                newRepair.repairDesc = (repairDict.objectForKey("description") as! String)
                newRepair.date_submitted = (repairDict.objectForKey("date_submitted") as! String)
                repairsArray.append(newRepair)
                print("Title: \(newRepair.repairTitle!) Description: \(newRepair.repairDesc!)")
                print("Count: \(repairsArray.count)")
                print(jsonResult)
            }
            
            dispatch_async(dispatch_get_main_queue()) {                     //adds notifier that weve gotten data into the array
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
            }
            
        } catch {
            print("JSON Parsing Error")
        }
    }
    
    
    func getRepairsFromServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        
        let url = NSURL(string: "https://\(baseURLString)/\(repairListURLString)")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        urlRequest.HTTPMethod = "GET" // OR "PUT"
        let token = "tenant_token"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization") // OR OTHER VALUES FOR OTHER FIELDS
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            
            if data != nil {
                print("Got Data")
                self.parseRepairData(data!)
            } else {
                print("Got No Data")
            }
        }
        task.resume()
    }
}




