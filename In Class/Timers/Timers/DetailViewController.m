//
//  DetailViewController.m
//  Timers
//
//  Created by Blake Oistad on 9/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@property (nonatomic, weak)     IBOutlet    UITextField               *timerNameTextField;
@property (nonatomic, weak)     IBOutlet    UISegmentedControl        *timerDirectionSegControl;
@property (nonatomic, strong)               AppDelegate               *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext    *managedObjectContext;

@end

@implementation DetailViewController

#pragma mark - Interactivity Methods




- (void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)saveButtonPressed:(id)sender {
    _currentTimer.timerName = _timerNameTextField.text;
    _currentTimer.dateUpdated = [NSDate date];
    _currentTimer.userID = @"User";
    [self saveAndPop]; //this basically invokes the back button funcitonality, takes you back one viewcontroller in the stack (history)
}

- (IBAction)deleteRecord:(id)sender {
    [_managedObjectContext deleteObject:_currentTimer];
    [self saveAndPop];
    // you could put an alert in here to ask if user is sure they want to delete this data
}



#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_currentTimer != nil) {
    _timerNameTextField.text = _currentTimer.timerName;
    } else {
        Timers *newTimer = (Timers *)[NSEntityDescription insertNewObjectForEntityForName:@"Timers" inManagedObjectContext:_managedObjectContext];
        newTimer.dateEntered = [NSDate date];
        _currentTimer = newTimer;

    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
