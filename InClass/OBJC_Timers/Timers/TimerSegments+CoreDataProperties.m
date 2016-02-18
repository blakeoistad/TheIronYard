//
//  TimerSegments+CoreDataProperties.m
//  Timers
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TimerSegments+CoreDataProperties.h"

@implementation TimerSegments (CoreDataProperties)

@dynamic dateEntered;
@dynamic dateUpdated;
@dynamic segmentLengthInSecs;
@dynamic segmentName;
@dynamic segmentOrder;
@dynamic segmentPauseAtEnd;
@dynamic userID;
@dynamic relationshipTimerSegmentTimer;

@end
