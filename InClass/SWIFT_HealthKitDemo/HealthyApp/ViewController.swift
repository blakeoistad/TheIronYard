//
//  ViewController.swift
//  HealthyApp
//
//  Created by Blake Oistad on 11/10/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    var healthStore = HKHealthStore()
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var stepsLabel: UILabel!
    
    
    
    
    
    //MARK: - Health Kit Methods
    
    //the three types of data we will be writing
    //these are samples because these values are values that change through time, height, weight, heart rate...
    func dataTypesToWrite() -> Set<HKSampleType> {
        let heightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        let heartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        let weightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
        
        return [heightType, heartRateType, weightType]
    }
    
    func dataTypesToRead() -> Set<HKObjectType> {
        let heightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        let heartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        let weightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
        
        //birthday is not a sample, its a constant, therefor we MUST return a set of objecttypes, not sample types
        let birthdayType = HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!
        let stepsType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!
        
        return [heightType, heartRateType, weightType, birthdayType, stepsType]
    }
    
    func updateUserAgeLabel() {
        do {
            let dateOfBirth = try healthStore.dateOfBirth()
            let ageComponents = NSCalendar.currentCalendar().components(.Year, fromDate: dateOfBirth, toDate: NSDate(), options: .WrapComponents)
            let userAge = ageComponents.year
            print("Age: \(userAge)")
            ageLabel.text = "Age: \(userAge)"
        } catch {
            print("Got DOB Error, breh")
        }
    }
    
    func updateUserStepsLabel() {
        let stepsType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let endDate = NSDate()
        let dayCount = -7
        let startDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: dayCount, toDate: endDate, options: [])
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
        let query = HKSampleQuery(sampleType: stepsType!, predicate: predicate, limit: 1000, sortDescriptors: nil) { (query, results, error) -> Void in
            var totalSteps = 0.0
            for steps in results as! [HKQuantitySample] {
                totalSteps += steps.quantity.doubleValueForUnit(HKUnit.countUnit())
            }
            let avgSteps = totalSteps / Double(abs(dayCount))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.stepsLabel.text = "Total: \(totalSteps) Avg: \(avgSteps)"
            })
        }
        healthStore.executeQuery(query)
    }
    
    //MARK: - Life Cycle Methods
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //is there a health store?
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorizationToShareTypes(dataTypesToWrite(), readTypes: dataTypesToRead(), completion: { (success, error) -> Void in
                if success {
                    //this is happing in the background thread, hence must bring it to foreground below
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.updateUserAgeLabel()
                        self.updateUserStepsLabel()
                    })
                } else {
                    print(error)
                }
            })
        } else {
            print("Aint got no health sto!")
        }
        
        //get permission
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

