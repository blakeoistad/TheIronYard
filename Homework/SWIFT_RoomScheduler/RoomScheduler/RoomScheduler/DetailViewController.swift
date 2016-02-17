//
//  DetailViewController.swift
//  RoomScheduler
//
//  Created by Blake Oistad on 10/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import EventKit

class DetailViewController: UIViewController {

    let eventStore = EKEventStore()
    @IBOutlet weak var eventTitleTextField :UITextField!
    @IBOutlet weak var eventStartDatePicker :UIDatePicker!
    @IBOutlet weak var eventEndDatePicker :UIDatePicker!
    @IBOutlet weak var arrivalReminderButton :UIButton!
    var selectedEvent :EKEvent!

    
    //MARK: - Reminder Methods
    
    @IBAction func arrivalReminderButtonPressed(sender: UIButton) {
        print("Arrival Reminder Pressed")
        
        let reminder = EKReminder(eventStore: eventStore)
        reminder.calendar = eventStore.defaultCalendarForNewReminders()
        if eventTitleTextField.text!.characters.count > 0 {
            reminder.title = String("Arrival Reminder for \(eventTitleTextField.text!)")
            
            let alarm = EKAlarm(absoluteDate: eventStartDatePicker.date)
            reminder.addAlarm(alarm)
            let locAlarm = EKAlarm()
            let ekLoc = EKStructuredLocation(title: String("The Iron Yard"))
            let loc = CLLocation(latitude: 39.905945, longitude: -77.041997)
            ekLoc.geoLocation = loc
            ekLoc.radius = 50
            locAlarm.structuredLocation = ekLoc
            locAlarm.proximity = .Enter
            reminder.addAlarm(locAlarm)
            
            do {
                try eventStore.saveReminder(reminder, commit: true)
                print("Reminder Saved")
            } catch {
                print("Got Error Saving Reminder")
            }
        } else {
            print("You must input a title")
        }
        
        
        arrivalReminderButton.enabled = false
    }
    
    
    
    
    //MARK: - Calendar Methods
    
    @IBAction func createCalEvent(sender: UIBarButtonItem) {
        print("Add Event Button Pressed")
        
        
        if (checkEventOverlap(eventStartDatePicker.date, end: eventEndDatePicker.date)) {
            let calEvent = EKEvent(eventStore: eventStore)
            calEvent.calendar = eventStore.defaultCalendarForNewEvents
            calEvent.title = eventTitleTextField.text!
            calEvent.startDate = eventStartDatePicker.date
            calEvent.endDate = eventEndDatePicker.date
            do {
                try eventStore.saveEvent(calEvent, span: .ThisEvent, commit: true)
                self.navigationController!.popToRootViewControllerAnimated(true)
            } catch {
                print("Got Error")
            }
        }
    }
    
    func checkEventOverlap(start: NSDate, end: NSDate) -> Bool {
        let calendars = eventStore.calendarsForEntityType(.Event)
        let predicate = eventStore.predicateForEventsWithStartDate(eventStartDatePicker.date, endDate: eventEndDatePicker.date, calendars: calendars)
        let checkArray = eventStore.eventsMatchingPredicate(predicate)
        print("Count: \(checkArray.count)")
        return (checkArray.count == 0)
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if selectedEvent != nil {
            eventTitleTextField.text = selectedEvent.title
            eventStartDatePicker.date = selectedEvent.startDate
            eventEndDatePicker.date = selectedEvent.endDate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
