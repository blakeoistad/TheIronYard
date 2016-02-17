//
//  BeaconsManager.swift
//  AttendanceLog
//
//  Created by Blake Oistad on 11/12/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconsManager: NSObject, ESTBeaconManagerDelegate {

    static let beaconsManager = BeaconsManager()
    let beaconManager = ESTBeaconManager()
    let viewController = ViewController()
    var lastRegion: CLBeaconRegion?
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let nearestBeacon = beacons[0]      //beacon nearest
            if region != lastRegion {           //dont repeat if last beacon is the same one youre near
                switch nearestBeacon.proximity {
                case .Immediate:
                    print("Ranged Immediate \(region.identifier)")
                    dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "recievedDataFromServer", object: nil))
                        print("Logged Check-In")
                    }
                case .Near:
                    print("Ranged Near \(region.identifier)")
                case .Far:
                    print("Ranged Far \(region.identifier)")
                case .Unknown:
                    print("Ranged Unknown \(region.identifier)")
                }
                lastRegion = region
            }
        }
    }
    
    
    
    
    func setUpBeacons() {
        print("Setting up beacons")
        let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"             //set beacon uuid string (this is the iron yards key)
        let beaconUUID = NSUUID(UUIDString: uuidString)!
        //we need to know when were in range of one beacon, and when in range of all of them (entered the building) creates groups of beacons
        
        let beaconIdentifier = "IronYard"
        let allBeaconsRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier)      //creates a region of all beacons
        beaconManager.startMonitoringForRegion(allBeaconsRegion)
        
        // 3 categories of distance, immediate (next to/on beacon), near (in close proximity), far (i can see it, but not that close)
        
        let beacon1Major: CLBeaconMajorValue = 39380
        let beacon1Minor: CLBeaconMinorValue = 44024
        let beacon1Identifier = "PurpleBeacon"
        let purpleBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon1Major, minor: beacon1Minor, identifier: beacon1Identifier)
        beaconManager.startRangingBeaconsInRegion(purpleBeaconRegion)
        
        let beacon2Major: CLBeaconMajorValue = 31640
        let beacon2Minor: CLBeaconMinorValue = 65404
        let beacon2Identifier = "BlueBeacon"
        let blueBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon2Major, minor: beacon2Minor, identifier: beacon2Identifier)
        beaconManager.startRangingBeaconsInRegion(blueBeaconRegion)
        
        let beacon3Major: CLBeaconMajorValue = 34909
        let beacon3Minor: CLBeaconMinorValue = 15660
        let beacon3Identifier = "MintBeacon"
        let mintBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon3Major, minor: beacon3Minor, identifier: beacon3Identifier)
        beaconManager.startRangingBeaconsInRegion(mintBeaconRegion)
        
    }
    
    
    func checkForLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {        //check phones location services turned on
            print("Location Services ON")
            
            switch ESTBeaconManager.authorizationStatus() {     //estimote subclassed location manager, hence estbeaconmanager
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Start Up")
                setUpBeacons()
            case .Denied, .Restricted:
                print("Turn on Permission in Settings")
            case .NotDetermined:
                print("Not Determined")
                if beaconManager.respondsToSelector("requestAlwaysAuthorization") {     //get permission
                    print("Requesting Always")
                    beaconManager.requestAlwaysAuthorization()
                }
            }
        } else {
            print("Turn on Location Services")
        }
    }

    
    
    
    
}
