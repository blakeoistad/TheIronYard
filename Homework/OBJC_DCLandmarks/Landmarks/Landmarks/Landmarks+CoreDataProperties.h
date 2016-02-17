//
//  Landmarks+CoreDataProperties.h
//  Landmarks
//
//  Created by Blake Oistad on 10/7/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Landmarks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Landmarks (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *landmarkName;
@property (nullable, nonatomic, retain) NSString *landmarkDescription;
@property (nullable, nonatomic, retain) NSString *landmarkLat;
@property (nullable, nonatomic, retain) NSString *landmarkLong;
@property (nullable, nonatomic, retain) NSString *landmarkImageName;
@property (nullable, nonatomic, retain) NSString *landmarkStreet;
@property (nullable, nonatomic, retain) NSString *landmarkCity;
@property (nullable, nonatomic, retain) NSString *landmarkState;
@property (nullable, nonatomic, retain) NSString *landmarkZip;
@property (nullable, nonatomic, retain) NSString *landmarkWebsite;
@property (nullable, nonatomic, retain) NSString *landmarkPhone;

@end

NS_ASSUME_NONNULL_END
