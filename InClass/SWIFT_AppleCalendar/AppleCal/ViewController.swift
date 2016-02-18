//
//  ViewController.swift
//  AppleCal
//
//  Created by Blake Oistad on 10/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    let eventStore = EKEventStore()                                     //remember () is alloc init
    @IBOutlet weak var calTextField :UITextField!
    @IBOutlet weak var calStartDatePicker :UIDatePicker!
    @IBOutlet weak var calEndDatePicker :UIDatePicker!
    @IBOutlet weak var latTextField :UITextField!
    @IBOutlet weak var lonTextField :UITextField!
    
    //MARK: - Interactivity Methods
    
    
    
    //MARK: - Reminder Methods
    
    @IBAction func createReminder(sender: UIBarButtonItem) {
        print("Add Reminder Button Pressed")
        let reminder = EKReminder(eventStore: eventStore)
        reminder.calendar = eventStore.defaultCalendarForNewReminders()
        if calTextField.text!.characters.count > 0 {
            
            reminder.title = calTextField.text!
            
            let alarm = EKAlarm(absoluteDate: calStartDatePicker.date)          //created alarm based on start date picker and added it to the reminder
            reminder.addAlarm(alarm)
            
            if latTextField.text!.characters.count > 0 && lonTextField.text!.characters.count > 0 {             //only add location based stuff if the user has entered this information in
                let locAlarm = EKAlarm()
                let ekLoc = EKStructuredLocation(title: calTextField.text!)              //need a location to add the alarm to when the location is hit
                let loc = CLLocation(latitude: Double(latTextField.text!)!, longitude: Double(lonTextField.text!)!)
                ekLoc.geoLocation = loc
                ekLoc.radius = 100                                                      //sets the fence radius of the geofence for the alarm, in meters
                locAlarm.structuredLocation = ekLoc
                locAlarm.proximity = .Enter                                             //what triggers the alarm? entering the location or exiting the location
                reminder.addAlarm(locAlarm)
            }
            
            do {
                try eventStore.saveReminder(reminder, commit: true)
            } catch {
                print("Got Error")
            }
        } else {
            print("You need a title fool!")                         //send user message or disable button
        }
    }
    
    @IBAction func fetchReminders() {
        let reminderLists = eventStore.calendarsForEntityType(.Reminder)            //gets us all reminder calendars
        let predicate = eventStore.predicateForRemindersInCalendars(reminderLists)  //gets us all reminders in all reminder calendars (can also grab completed or incompleted)
        eventStore.fetchRemindersMatchingPredicate(predicate) { (reminders) -> Void in
            if reminders!.count > 0 {
                for reminder in reminders! {
                    print(reminder.title)
                }
            }
            
        }
    }
    
    
    
    //MARK: - Calendar Methods
    
    @IBAction func createCalEvent(sender: UIBarButtonItem) {
        print("Add Cal Button Pressed")
        let calEvent = EKEvent(eventStore: eventStore)
        calEvent.calendar = eventStore.defaultCalendarForNewEvents      //consider adding a picker field or something that allows them to choose which calendar to add to
        calEvent.title = calTextField.text!                             //if theres no text for title, it will just create a blank title
        calEvent.startDate = calStartDatePicker.date
        calEvent.endDate = calEndDatePicker.date
        //data base saving is not guaranteed, so do try
        do {
            try eventStore.saveEvent(calEvent, span: .ThisEvent, commit: true)
        } catch {
            print("Got Error")
        }
    }
    
    @IBAction func fetchCalEvents(sender: UIBarButtonItem) {
        let calendars = eventStore.calendarsForEntityType(.Event)           //gives us an array of calendars that are used for calendar events
        let predicate = eventStore.predicateForEventsWithStartDate(calStartDatePicker.date, endDate: calEndDatePicker.date, calendars: calendars)           //search all calendars for whats between pickers
        let events = eventStore.eventsMatchingPredicate(predicate)          //events will be an array of matching events
        if events.count > 0 {
            for event in events {
                print("Title: \(event.title) start:\(event.startDate) end:\(event.endDate)")
            }
        } else {
            print("No Events in Range")
        }
    }
    
    //MARK: - Permission Methods
    
    func requestAccessToEKType(type: EKEntityType) {
        eventStore.requestAccessToEntityType(type) { (accessGranted, error) -> Void in              //reminder, (accessGranted, error) is a tuple
            if accessGranted {
                print("Granted")
            } else {
                print("Not Granted")
            }
        }
    }
    
    func checkEKAuthorizationStatus(type: EKEntityType) {
        let status = EKEventStore.authorizationStatusForEntityType(type)            //check current status 
        switch status {
        case .NotDetermined:
            print("Not Determined")
            requestAccessToEKType(type)
        case .Authorized:
            print("Authorized")
        case .Restricted, .Denied:
            print("Restricted/Denied")
        }
    }
    
    
    
    
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEKAuthorizationStatus(.Event)
        checkEKAuthorizationStatus(.Reminder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

