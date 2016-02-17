//
//  ViewController.m
//  blakeSweepstakes
//
//  Created by Blake Oistad on 10/21/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "EntryTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong)               NSArray             *entriesArray;
@property (nonatomic, weak)     IBOutlet    UISegmentedControl  *sortSegControl;
@property (nonatomic, weak)     IBOutlet    UITableView         *entriesTableView;
@property (nonatomic, weak)     IBOutlet    UIDatePicker        *startDatePicker;
@property (nonatomic, weak)     IBOutlet    UIDatePicker        *endDatePicker;

@end

@implementation ViewController






#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _entriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryTableViewCell *entryCell = (EntryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"entryCell"];
    PFObject *currentEntry = _entriesArray[indexPath.row];
    
    entryCell.entryFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", [currentEntry objectForKey:@"firstName"], [currentEntry objectForKey:@"lastName"]];
    entryCell.entryFirstNameLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"firstName"]];
    entryCell.entryLastNameLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"lastName"]];
    entryCell.entryFullAddressLabel.text = [NSString stringWithFormat:@"%@, %@", [currentEntry objectForKey:@"city"], [currentEntry objectForKey:@"state"]];
    entryCell.entryCityLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"city"]];
    entryCell.entryStateLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"state"]];
    entryCell.entryPhoneLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"phone"]];
    entryCell.entryEmailLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"email"]];
//    entryCell.entryDateAddedLabel.text = [NSString stringWithFormat:@"%@", [currentEntry objectForKey:@"createdAt"]];
    entryCell.entryDateAddedLabel.text = [NSString stringWithFormat:@"%@", [currentEntry createdAt]];
    entryCell.entryWinCounterLabel.text = [NSString stringWithFormat:@"%li", [[currentEntry objectForKey:@"winCount"] integerValue]];
    
    if ([[currentEntry objectForKey:@"winCount"] integerValue] > 0) {
        entryCell.backgroundColor = [UIColor lightOrangeColor];
    } else {
        entryCell.backgroundColor = [UIColor rustOrangeColor];
    }

    return entryCell;
}


#pragma mark - Interactivity Methods


- (IBAction)segControlValueChanged:(UISegmentedControl *)segControl {
    
    NSString *sortValueString = [segControl titleForSegmentAtIndex:(segControl.selectedSegmentIndex)];
    NSLog(@"Value changed %@", sortValueString);
    
    [self fetchEntriesWithSort:_sortSegControl.selectedSegmentIndex];
}

- (IBAction)getStartDatePicker:(UIDatePicker *)datePicker {
    NSLog(@"Start Date: %@", datePicker.date);
}

- (IBAction)getEndDatePicker:(UIDatePicker *)datePicker {
    NSLog(@"End Date: ^%@", datePicker.date);
}


#pragma mark - Decision Methods


- (IBAction)winButtonPressed:(UIButton *)sender {
    NSLog(@"Win Button Pressed");
    int randomWinner = arc4random_uniform((u_int32_t)_entriesArray.count);
    NSLog(@"Person number: %i", randomWinner);
    PFObject *winningPerson = [_entriesArray objectAtIndex:randomWinner];
    NSString *winningPersonName = [NSString stringWithFormat:@"%@ %@", [winningPerson objectForKey:@"firstName"], [winningPerson objectForKey:@"lastName"]];
    NSLog(@"Winning Entry Name: %@", winningPersonName);
    int winCount = [winningPerson[@"winCount"] intValue] +1;
    winningPerson[@"winCount"] = [NSNumber numberWithInt:winCount];
    [winningPerson saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Winner: %@ WinCount: %d", winningPersonName, winCount);
        [_entriesTableView reloadData];
    }];
}


//- (IBAction)resetButtonPressed:(id)sender {
//    NSLog(@"Reset");
//    
//    
//    for (PFObject *entriesToReset in _entriesArray) {
//
//    }
//}

#pragma mark - Parse Methods

- (void)fetchEntriesWithSort:(long)sortOrder {
    PFQuery *entryItemQuery = [PFQuery queryWithClassName:@"SweepsLog"];
    
    switch (sortOrder) {
        case 0:
            [entryItemQuery addAscendingOrder:@"firstName"];
            break;
        case 1:
            [entryItemQuery addAscendingOrder:@"lastName"];
            break;
        case 2:
            [entryItemQuery addDescendingOrder:@"winCount"];
            break;
        case 3:
            [entryItemQuery addAscendingOrder:@"createdAt"];
        default:
            break;
    }
    
    [entryItemQuery setLimit:1000];
    [entryItemQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        _entriesArray = objects;
        [_entriesTableView reloadData];
    }];
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
    NSLog(@"Filter Results");
    PFQuery *dateRangeQuery = [PFQuery queryWithClassName:@"SweepsLog"];
    
    [dateRangeQuery whereKey:@"createdAt" greaterThanOrEqualTo:_startDatePicker.date];
    [dateRangeQuery whereKey:@"createdAt" lessThanOrEqualTo:_endDatePicker.date];
    NSLog(@"Step 1");
    [dateRangeQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"Got: %li, %@", objects.count, objects);
                _entriesArray = objects;
//        for (PFObject *entry in _entriesArray) {
//            NSLog(@"Entry %@", entry);
//            NSLog(@"Step 2");
//        }
        [_entriesTableView reloadData]; 
        NSLog(@"Step 3");
    }];

    
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [_startDatePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    [_endDatePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_sortSegControl setSelectedSegmentIndex:0];
    [self fetchEntriesWithSort:_sortSegControl.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
