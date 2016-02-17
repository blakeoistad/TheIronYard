//
//  Persons+CoreDataProperties.h
//  MyFavPeople
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Persons.h"

NS_ASSUME_NONNULL_BEGIN

@interface Persons (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *personAddressCity;
@property (nullable, nonatomic, retain) NSString *personAddressState;
@property (nullable, nonatomic, retain) NSString *personAddressStreet;
@property (nullable, nonatomic, retain) NSString *personAddressZip;
@property (nullable, nonatomic, retain) NSString *personCategory;
@property (nullable, nonatomic, retain) NSString *personFirstName;
@property (nullable, nonatomic, retain) NSString *personImageName;
@property (nullable, nonatomic, retain) NSString *personLastName;
@property (nullable, nonatomic, retain) NSString *personPhoneNumber;
@property (nullable, nonatomic, retain) NSString *personRole;
@property (nullable, nonatomic, retain) NSString *personSkypeID;
@property (nullable, nonatomic, retain) NSString *personTwitterID;
@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSSet<PersonsEmail *> *relationshipPersonsPersonsEmail;

@end

@interface Persons (CoreDataGeneratedAccessors)

- (void)addRelationshipPersonsPersonsEmailObject:(PersonsEmail *)value;
- (void)removeRelationshipPersonsPersonsEmailObject:(PersonsEmail *)value;
- (void)addRelationshipPersonsPersonsEmail:(NSSet<PersonsEmail *> *)values;
- (void)removeRelationshipPersonsPersonsEmail:(NSSet<PersonsEmail *> *)values;

@end

NS_ASSUME_NONNULL_END
