//
//  DataManager.swift
//  SwiftTune
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    
    //MARK: - Properties
    
    var baseURLString = "itunes.apple.com"
    var tunesArray = [Tunes]()
    
    
    
    //MARK: - Get Image Methods
    
    //need to add images to documents folder, check if it already exists, and if not, to download it to the documents directory
    
    func cleanStringForFileManager(dirtyString: String) -> String {
        let removedSlashString = dirtyString.stringByReplacingOccurrencesOfString("/", withString: "")
        let removedColonString = removedSlashString.stringByReplacingOccurrencesOfString(":", withString: "")
        return removedColonString
    }
    
    
    func fileIsLocal(filename :String) -> Bool {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.fileExistsAtPath(getDocumentPathForFile(filename))  //using getdocumentpathforfile to see if said filename exists in the directory
    }
    
    
    
    func getDocumentPathForFile(filename: String) -> String {                           //gets the document path
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        return documentPath.stringByAppendingPathComponent(filename)
    }
    
    func getImageFromServer(localFilename: String, remoteFilename: String, indexPathRow: Int) {
        let remoteURL = NSURL(string: remoteFilename)
        let imageData = NSData(contentsOfURL: remoteURL!)                   //TODO: Gets the data, but is running on foreground, move to background
        let imageTemp :UIImage? = UIImage(data: imageData!)         //the data may or may not be image data, now need to unwrap and check data type
        if let _ = imageTemp {
            imageData!.writeToFile(getDocumentPathForFile(localFilename), atomically: false)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "gotImageFromServer", object: nil, userInfo: nil))
        }
    }
    
    
    
    //MARK: - Get Data Methods
    
    func parseTuneData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("results") as! [NSDictionary]
//            self.tunesArray.removeAll()         //clear out the array incase there was anything theree
//            for tuneDict in tempDictArray {
//                let newTune = Tunes()
//                newTune.artistName = tuneDict.objectForKey("artistName") as! String
//                newTune.trackName = tuneDict.objectForKey("trackName") as! String
//                newTune.artworkUrl100 = tuneDict.objectForKey("artworkUrl100") as! String
//                newTune.previewURL = tuneDict.objectForKey("previewUrl") as! String
//                if let uCollectionName = tuneDict.objectForKey("collectionName") as? String {
//                    newTune.collectionName = uCollectionName
//                }
//                self.tunesArray.append(newTune)
//                print("TrackName:\(newTune.trackName)")
//            }
//            dispatch_async(dispatch_get_main_queue()) {                     //adds notifier that weve gotten data into the array
//                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
//            }
            print(jsonResult)
            
        } catch {
            print("JSON parsing error")
        }
    }
    
    
    func getDataFromServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true                //gives visual spinner for network activity
        defer {                                                 //no matter what, when we leave this method, it will turn off the indicator
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "http://\(baseURLString)/search?term=rogan")
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        let urlSession = NSURLSession.sharedSession()                                               //accessing the nsurlsession singleton
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            
            if data != nil {
                print("Got Data")
                self.parseTuneData(data!)
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
}
