//
//  AppDelegate.m
//  blakeSweepstakes
//
//  Created by Blake Oistad on 10/21/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Core Methods

- (void)setUpAppearance {
    [[UIButton appearance] setBackgroundColor:[UIColor rustOrangeColor]];
    [[UIButton appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:24]}];
    
    [[UIDatePicker appearance] setBackgroundColor:[UIColor rustOrangeColor]];
    [[UIDatePicker appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITableView appearance] setBackgroundColor:[UIColor rustOrangeColor]];
    
    [[UISegmentedControl appearance] setBackgroundColor:[UIColor rustOrangeColor]];
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];
}



#pragma mark - App Lifecycle Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Initialize Parse
    [Parse setApplicationId:@"hpDX2cNju34de66OcRqRmiMoicfe3gIcQLhoto1w"
                  clientKey:@"sUyWqt0JGuJ52lfQIBZ42h46RTUBs9lFpCKzYmzw"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self setUpAppearance];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
