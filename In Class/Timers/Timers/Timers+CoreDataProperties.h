//
//  Timers+CoreDataProperties.h
//  Timers
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Timers.h"

NS_ASSUME_NONNULL_BEGIN

@interface Timers (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSString *timerDirection;
@property (nullable, nonatomic, retain) NSString *timerName;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSNumber *timerLengthInSecs;
@property (nullable, nonatomic, retain) NSSet<TimerSegments *> *relationshipTimerTimerSegments;

@end

@interface Timers (CoreDataGeneratedAccessors)

- (void)addRelationshipTimerTimerSegmentsObject:(TimerSegments *)value;
- (void)removeRelationshipTimerTimerSegmentsObject:(TimerSegments *)value;
- (void)addRelationshipTimerTimerSegments:(NSSet<TimerSegments *> *)values;
- (void)removeRelationshipTimerTimerSegments:(NSSet<TimerSegments *> *)values;

@end

NS_ASSUME_NONNULL_END
