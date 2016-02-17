//
//  TimerSegments+CoreDataProperties.h
//  Timers
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TimerSegments.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimerSegments (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSNumber *segmentLengthInSecs;
@property (nullable, nonatomic, retain) NSString *segmentName;
@property (nullable, nonatomic, retain) NSNumber *segmentOrder;
@property (nullable, nonatomic, retain) NSNumber *segmentPauseAtEnd;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) Timers *relationshipTimerSegmentTimer;

@end

NS_ASSUME_NONNULL_END
