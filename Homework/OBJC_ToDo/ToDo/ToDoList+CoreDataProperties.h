//
//  ToDoList+CoreDataProperties.h
//  ToDo
//
//  Created by Blake Oistad on 9/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSString *todoDescription;
@property (nullable, nonatomic, retain) NSNumber *todoDone;
@property (nullable, nonatomic, retain) NSString *todoName;
@property (nullable, nonatomic, retain) NSNumber *todoOrder;
@property (nullable, nonatomic, retain) NSString *todoPriority;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSDate *todoDueDate;

@end

NS_ASSUME_NONNULL_END
