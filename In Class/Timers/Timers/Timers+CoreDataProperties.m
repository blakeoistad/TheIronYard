//
//  Timers+CoreDataProperties.m
//  Timers
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Timers+CoreDataProperties.h"

@implementation Timers (CoreDataProperties)

@dynamic dateEntered;
@dynamic dateUpdated;
@dynamic timerDirection;
@dynamic timerName;
@dynamic userID;
@dynamic timerLengthInSecs;
@dynamic relationshipTimerTimerSegments;

@end
