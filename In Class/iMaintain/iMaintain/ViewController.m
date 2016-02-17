//
//  ViewController.m
//  iMaintain
//
//  Created by Blake Oistad on 10/21/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController



#pragma mark - Parse Methods

- (void)fetchLogItems {
    PFQuery *logItemQuery = [PFQuery queryWithClassName:@"MaintainanceLog"];
    [logItemQuery addAscendingOrder:@"dateSent"];                           //put the oldest ontop
    [logItemQuery setLimit:1000];                                           //set return limits
    [logItemQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"Got: %li", objects.count);
        for (PFObject *logItem in objects) {
            NSLog(@"Name:%@ Email:%@", [logItem objectForKey:@"fullName"], [logItem objectForKey:@"email"]);
        }
    }];
}

- (void)tempAddRecords {
    PFObject *maintainLog1 = [PFObject objectWithClassName:@"MaintainanceLog"];
    maintainLog1[@"email"] = @"blake.oistad@gmail.com";
    maintainLog1[@"fullName"] = @"Blake Oistad";
    maintainLog1[@"phone"] = @"8044321353";
    maintainLog1[@"repairDesc"] = @"fix the toilet";
    maintainLog1[@"dateSent"] = [NSDate date];
    maintainLog1[@"repairComplete"] = [NSNumber numberWithBool:false];
    maintainLog1[@"priority"] = [NSNumber numberWithInt:11];
    [maintainLog1 saveInBackground];
}





#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchLogItems];
//    [self tempAddRecords];
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
