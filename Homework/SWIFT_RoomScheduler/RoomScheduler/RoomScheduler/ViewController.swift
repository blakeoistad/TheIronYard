//
//  ViewController.swift
//  RoomScheduler
//
//  Created by Blake Oistad on 10/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let eventStore = EKEventStore()
    var eventsArray = [EKEvent]()
    
    @IBOutlet weak var eventsTableView :UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let eventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
        let currentEvent = eventsArray[indexPath.row]
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        let startDateString = formatter.stringFromDate(currentEvent.startDate)
        let endDateString = formatter.stringFromDate(currentEvent.endDate)
        
        eventCell.eventTitleLabel.text = currentEvent.title
        eventCell.eventStartLabel.text = startDateString
        eventCell.eventEndLabel.text = endDateString
        
        return eventCell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "segueEdit" {
            let indexPath = eventsTableView.indexPathForSelectedRow!
            let selectedEvent = eventsArray[indexPath.row]
            destController.selectedEvent = selectedEvent
            eventsTableView.deselectRowAtIndexPath(indexPath, animated: true)
            print("Edit Event")
        } else if segue.identifier == "segueAdd" {
            destController.selectedEvent = nil
            print("Add Event")
        }
    }
    
    
    //MARK: - Reminder Methods
    
    
    
    
    
    
    //MARK: - Calendar Methods
    
    func fetchCalendarEvents() -> [EKEvent] {
        let calendars = eventStore.calendarsForEntityType(.Event)
        let startDate = NSDate()
        let endDate = NSDate().dateByAddingTimeInterval(60*60*24*7)
        let predicate = eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: calendars)
        let events = eventStore.eventsMatchingPredicate(predicate)
        if events.count > 0 {
            for event in events {
                print("Title: \(event.title) start:\(event.startDate) end:\(event.endDate)")
                
            }
        } else {
            print("No Events in Range")
        }
        return events
    }
    
    
    
    
    //MARK: - Permission Methods
    
    func requestAccessToEKType(type: EKEntityType) {
        eventStore.requestAccessToEntityType(type) { (accessGranted, error) -> Void in
            if accessGranted {
                print("Granted")
            } else {
                print("Not Granted")
            }
        }
    }
    
    func checkEKAuthorizationStatus(type: EKEntityType) {
        let status = EKEventStore.authorizationStatusForEntityType(type)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        eventsArray = fetchCalendarEvents()
        eventsTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

