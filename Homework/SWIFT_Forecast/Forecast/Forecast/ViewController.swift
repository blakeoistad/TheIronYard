//
//  ViewController.swift
//  Forecast
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    
    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    var locationManager = LocationManager.sharedInstance
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var weatherDisplayView: UIView!
    @IBOutlet weak var weatherLocationLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherPrecipProbLabel: UILabel!
    
    
    
    //MARK: - Interactivity Methods
    
    
    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
        if networkManager.serverAvailable {
            print("Getting Data")
            if locationSearchBar.text!.characters.count > 0 {
                locationManager.addressSearch(locationSearchBar.text!)
                weatherDisplayView.hidden = true
            }
        } else {
            print("Server Not Available")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if locationSearchBar.isFirstResponder() {
            locationSearchBar.resignFirstResponder()
        }
    }
    
    
    func newDataReceived() {
        let roundedTemp = Float(dataManager.currentWeather.temperature)
        let roundedPrecipProb = Float(dataManager.currentWeather.precipProbability)
        
        weatherDisplayView.hidden = false
        weatherSummaryLabel.text = dataManager.currentWeather.summary
        weatherLocationLabel.text = locationSearchBar.text!
        weatherTemperatureLabel.text = String(dataManager.currentWeather.temperature) + String("°")
        weatherTemperatureLabel.text = String(format: "%.f", roundedTemp) + String("°")
        weatherPrecipProbLabel.text = String(format: "%.f", roundedPrecipProb) + String("%") + String(" Chance of Rain")
        
        switch dataManager.currentWeather.icon {
            
        case "clear-day":
            weatherIconImageView.image = UIImage(named: "sunny")
            self.view.backgroundColor = UIColor.sunnyColor()
        case "clear-night":
            weatherIconImageView.image = UIImage(named: "night")
            self.view.backgroundColor = UIColor.nightColor()
        case "partly-cloudy-day":
            weatherIconImageView.image = UIImage(named: "partlyCloudyDay")
            self.view.backgroundColor = UIColor.partlyCloudyDayColor()
        case "wind":
            weatherIconImageView.image = UIImage(named: "windy")
            self.view.backgroundColor = UIColor.windyColor()
        case "partly-cloudy-night":
            weatherIconImageView.image = UIImage(named: "partlyCloudyNight")
            self.view.backgroundColor = UIColor.partlyCloudyNightColor()
        case "cloudy":
            weatherIconImageView.image = UIImage(named: "cloudy")
            self.view.backgroundColor = UIColor.cloudyColor()
        case "fog":
            weatherIconImageView.image = UIImage(named: "foggy")
            self.view.backgroundColor = UIColor.foggyColor()
        case "rain":
            weatherIconImageView.image = UIImage(named: "rainy")
            self.view.backgroundColor = UIColor.rainyColor()
        case "sleet":
            weatherIconImageView.image = UIImage(named: "sleet")
            self.view.backgroundColor = UIColor.sleetColor()
        case "snow":
            weatherIconImageView.image = UIImage(named: "snowy")
            self.view.backgroundColor = UIColor.snowyColor()
        default:
            weatherIconImageView.image = nil
        }
    }
    
    func newLocationReceived() {
        print("NULR")
        dataManager.getDataFromServer(locationManager.convertCoordinateToString(locationManager.userLocationCoordinates))
        
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.setUpLocationMonitoring()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newLocationReceived", name: "newUserLocationReceived", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        weatherDisplayView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

