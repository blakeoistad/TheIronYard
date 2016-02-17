//
//  Character+CoreDataProperties.h
//  iBounty
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 Blake & Jamal - TIYDC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Character.h"

NS_ASSUME_NONNULL_BEGIN

@interface Character (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *characterImageName;
@property (nullable, nonatomic, retain) NSString *characterLocation;
@property (nullable, nonatomic, retain) NSString *characterName;
@property (nullable, nonatomic, retain) NSString *profileImageName;
@property (nullable, nonatomic, retain) NSString *profileName;
@property (nullable, nonatomic, retain) NSNumber *contractSwitch;

@end

NS_ASSUME_NONNULL_END
