//
//  ToDos+CoreDataProperties.swift
//  SwiftToDo
//
//  Created by Blake Oistad on 10/27/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDos {

    @NSManaged var dateEntered: NSDate?
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var todoComplete: NSNumber?
    @NSManaged var todoDateDue: NSDate?
    @NSManaged var todoDescription: String?
    @NSManaged var userID: String?

}
