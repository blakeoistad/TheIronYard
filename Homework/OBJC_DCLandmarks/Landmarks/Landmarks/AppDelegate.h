//
//  AppDelegate.h
//  Landmarks
//
//  Created by Blake Oistad on 10/7/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Landmarks.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

@property (nonatomic, strong)           NSArray                         *landmarksArray;

- (NSArray *)fetchLandmarks;
- (Landmarks *)fetchLandmarkName:(NSString *)landmarkName;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;







@end

