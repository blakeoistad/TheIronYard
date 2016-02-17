//
//  PersonsEmail+CoreDataProperties.h
//  MyFavPeople
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonsEmail.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonsEmail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *emailAddress;
@property (nullable, nonatomic, retain) NSString *emailType;
@property (nullable, nonatomic, retain) Persons *relationshipPersonsEmailPersons;

@end

NS_ASSUME_NONNULL_END
