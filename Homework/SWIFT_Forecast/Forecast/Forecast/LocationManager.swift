//
//  LocationManager.swift
//  Forecast
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let sharedInstance = LocationManager()
    
    var dataManager = DataManager.sharedInstance
    var locationManager = CLLocationManager()
    var userLocationCoordinates = CLLocationCoordinate2D()
    
    //MARK: - Permission Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocationCoordinates = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        print("Lat: \(userLocationCoordinates.latitude) Long: \(userLocationCoordinates.longitude)")
        locationManager.stopUpdatingLocation()
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newUserLocationReceived", object: nil))
    }
    
    func setUpLocationMonitoring() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .Denied, .Restricted:
                print("Location services disabled/restricted")
            case .NotDetermined:
                print("Turn location services on in Settings")
                if (locationManager.respondsToSelector("requestWhenInUseAuthorization")) {
                    locationManager.requestWhenInUseAuthorization()
                }

            }
        } else {
            print("Turn on location services in Settings!")
        }
    }
    
    
    
    
    //MARK: - Geocode Methods
    
    func convertCoordinateToString(coordinate: CLLocationCoordinate2D) -> String {
        print("\(coordinate.latitude),\(coordinate.longitude)")
        return "\(coordinate.latitude),\(coordinate.longitude)"
    }
    
    
    func addressSearch(search: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(search) { (placemarks, error) -> Void in
            if let placemark = placemarks?.first {
                print("Coordinate:\(placemark.location!.coordinate.latitude),\(placemark.location!.coordinate.longitude)")
                let coordinates = placemark.location!.coordinate
            self.dataManager.getDataFromServer(self.convertCoordinateToString(coordinates))
            }
        }
    }
}
