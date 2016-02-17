//
//  AppDelegate.swift
//  PushIt
//
//  Created by Blake Oistad on 11/17/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK:- Local Notification Methods (consider making a notification manager class)
    
    func getNotificationPermission() {
        let category1 = UIMutableUserNotificationCategory()             //create notification categories
        category1.identifier = "DEFAULT_CATEGORY"
        
        let category2 = UIMutableUserNotificationCategory()
        category2.identifier = "TEXT_CATEGORY"
        let textAction = UIMutableUserNotificationAction()
        textAction.identifier = "TEXT_ACTION"
        textAction.title = "Reply"
        textAction.activationMode = .Background
        textAction.authenticationRequired = false               //if user may need to log in to send message
        textAction.destructive = false                          //button blue or red (destructive means red, may delete data like delete button)
        textAction.behavior = .TextInput
        category2.setActions([textAction], forContext: .Minimal)
        category2.setActions([textAction], forContext: .Default)
        
        let category3 = UIMutableUserNotificationCategory()
        category3.identifier = "BUTTON_CATEGORY"
        let okAction = UIMutableUserNotificationAction()
        okAction.identifier = "OK_ACTION"
        okAction.title = "Ok"
        okAction.activationMode = .Background
        okAction.destructive = false
        okAction.authenticationRequired = false
        let editAction = UIMutableUserNotificationAction()
        editAction.identifier = "EDIT_ACTION"
        editAction.title = "Edit"
        let deleteAction = UIMutableUserNotificationAction()
        deleteAction.identifier = "DELETE_ACTION"
        deleteAction.title = "Delete"
        deleteAction.destructive = true
        category3.setActions([okAction, editAction, deleteAction], forContext: .Default)
        category3.setActions([editAction, deleteAction], forContext: .Minimal)          //dont have enough space for three buttons in minimal, left out the ok
        
        
        let categories = NSSet(objects: category1, category2, category3) as! Set<UIUserNotificationCategory>      //make set of notification categories
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("Got Local Notification")
    }
    
    
    //want to know if they responded and what they responded with
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        
        if identifier == "EDIT_ACTION" {
            print("Got edit intent")
        } else if identifier == "DELETE_ACTION" {
            print("Got delete intent")
        } else if identifier == "TEXT_ACTION" {
            let reply = responseInfo[UIUserNotificationActionResponseTypedTextKey]
            print("Reply: \(reply)")                //normally would store this response inside a database or something for later use
        }
        
        completionHandler()
    }
    
    
    //MARK:- App Life Cycle Methods
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        getNotificationPermission()
        return true
    }

}

