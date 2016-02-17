//
//  Contact+CoreDataProperties.swift
//  SwiftContact
//
//  Created by Blake Oistad on 10/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var contactAddressCity: String?
    @NSManaged var contactAddressState: String?
    @NSManaged var contactAddressStreet: String?
    @NSManaged var contactAddressZipCode: String?
    @NSManaged var contactEmail: String?
    @NSManaged var contactFirstName: String?
    @NSManaged var contactLastName: String?
    @NSManaged var contactPhone: String?
    @NSManaged var contactRating: NSNumber?
    @NSManaged var dateEntered: NSDate?
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var userID: String?

}
