//
//  ViewController.m
//  TableViewIntro
//
//  Created by Blake Oistad on 9/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (nonatomic, strong)        NSArray                *personArray;
@property (nonatomic, weak) IBOutlet UITableView            *personTableView;

@end

@implementation ViewController


#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *currentPerson = _personArray[indexPath.row];
    cell.textLabel.text = currentPerson[@"firstName"];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:30.0];
    cell.detailTextLabel.text = currentPerson[@"role"];
//    cell.imageView.image
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    Below: Sets first row of index to larger than other rows. could set this based on location, color, anything)
//    if (indexPath.row == 0) {
//        return 100.0;
//    }
    return 70.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    NSIndexPath *indexPath = [_personTableView indexPathForSelectedRow];
    NSDictionary *currentPerson = _personArray[indexPath.row];
    destController.currentPersonDict = currentPerson;
}


#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    NSDictionary *person1Dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Blake", @"firstName", @"Oistad", @"lastName",@"iOS Student",@"role",@"blake-oistad",@"imageName", nil];
    NSDictionary *person2Dict = @{@"firstName":@"Su",@"lastName":@"Kim",@"role":@"Campus Director",@"imageName":@"su-kim"};
    NSDictionary *person3Dict = @{@"firstName":@"James",@"lastName":@"Dabbs",@"role":@"Ruby Instructor",@"imageName":@"james-dabbs"};
    _personArray = @[person1Dict,person2Dict,person3Dict];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
