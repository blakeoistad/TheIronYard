//
//  ToDoList+CoreDataProperties.m
//  ToDo
//
//  Created by Blake Oistad on 9/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoList+CoreDataProperties.h"

@implementation ToDoList (CoreDataProperties)

@dynamic dateEntered;
@dynamic dateUpdated;
@dynamic todoDescription;
@dynamic todoDone;
@dynamic todoName;
@dynamic todoOrder;
@dynamic todoPriority;
@dynamic userID;
@dynamic todoDueDate;

@end
