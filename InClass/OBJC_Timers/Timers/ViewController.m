//
//  ViewController.m
//  Timers
//
//  Created by Blake Oistad on 9/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "Timers.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "LabelCenterTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong)           AppDelegate               *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext    *managedObjectContext;
@property (nonatomic, strong)           NSArray                   *timerArray;
@property (nonatomic, weak)   IBOutlet  UITableView               *timersTableView;
@property (nonatomic, weak)   IBOutlet  UISearchBar               *timerSearchBar;

@end

@implementation ViewController

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _timerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 2) {
        UITableViewCell *basicCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
        Timers *currentTimer = _timerArray[indexPath.row];
        basicCell.textLabel.text = currentTimer.timerName;
        return basicCell;
    } else {
        LabelCenterTableViewCell *labelCell = (LabelCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CenterLabelCell"];
        Timers *currentTimer = _timerArray[indexPath.row];
        labelCell.cellLabel.text = currentTimer.timerName;
        labelCell.cellSwitch.on = false;
        return labelCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"segueEditTimer" sender:self];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row < 2) {
        return 44.0;
    } else {
        return 112.5;
    }
}

- (IBAction)editButtonPressed:(id)sender {
    if (_timersTableView.isEditing) {
        [_timersTableView setEditing:false];
        
    } else {
        [_timersTableView setEditing:true];
    }
    
//   this is a simpler way of stating the above, "whatever you are, do the opposite"  [_timersTableView setEditing:!_timersTableView.isEditing];
}


// this also activates swipe delete, oddly enough
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Going to delete %li", indexPath.row);
        Timers *timerToDelete = _timerArray[indexPath.row];
        [_managedObjectContext deleteObject:timerToDelete];
        [_appDelegate saveContext];
        _timerArray = [self fetchTimers];
        [_timersTableView reloadData];
    }
}

#pragma mark - Interactivy Methods

- (IBAction)cellSwitchChanged:(id)sender {
    
    
    //need to know where switch lives, where they touched in relation to the tableview
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:_timersTableView];
    
    //create index path and look within timerstableview for which indexpath was touched
    NSIndexPath *indexPath = [_timersTableView indexPathForRowAtPoint:touchPoint];
    
    NSLog(@"Switch changed %li", indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *destController = [segue destinationViewController];
    
    
    if ([[segue identifier] isEqualToString:@"segueEditTimer"]) {
        NSIndexPath *indexPath = [_timersTableView indexPathForSelectedRow];
        Timers *currentTimer = _timerArray[indexPath.row];
        destController.currentTimer = currentTimer;
        
    } else if ([[segue identifier] isEqualToString:@"segueAddTimer"]) {
        destController.currentTimer = nil;
        
    }
}


#pragma mark - Core Data Methods


//saves the data
- (IBAction)addRecord:(id)sender {
    Timers *newTimer = (Timers *)[NSEntityDescription insertNewObjectForEntityForName:@"Timers" inManagedObjectContext:_managedObjectContext];
    newTimer.timerName = @"TIY Timer"; //TIY Timer will be passed in by user through a text field
    newTimer.timerDirection = @"Up";
    newTimer.dateEntered = [NSDate date];
    newTimer.userID = @"System";
    
}

- (IBAction)updateRecord:(id)sender {
    Timers *updateTimer = _timerArray[0];
    updateTimer.timerName = @"TIY Timer Updated"; //TIY Timer will be passed in by user through a text field
    updateTimer.timerDirection = @"Up";
    updateTimer.dateUpdated = [NSDate date];
    updateTimer.userID = @"System";
}


- (IBAction)deleteRecord:(id)sender {
    Timers *timerToDelete = _timerArray[0];
    [_managedObjectContext deleteObject:timerToDelete];
}

- (IBAction)rollbackChanges:(id)sender {
    [_managedObjectContext rollback];
}


- (IBAction)searchButtonPressed:(id)sender {
    NSLog(@"Search");
    _timerSearchBar.hidden = !_timerSearchBar.hidden;  //toggle function to hide and unhide the search bar
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _timerArray = [self fetchTimers];
    [_timersTableView reloadData];
}


//grabs the data
- (NSArray *)fetchTimers {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timers" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Sorting
    NSSortDescriptor *sortDescriptorName = [NSSortDescriptor sortDescriptorWithKey:@"timerName" ascending:true];
    NSArray *sortDescriptors = @[sortDescriptorName]; //shorthand for creating an array, an array of only one item here
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //search  (will only run if there is text in the search bar AND the search bar is not hidden
    if (_timerSearchBar.text.length > 0 && !_timerSearchBar.hidden) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timerName contains[cd] %@", _timerSearchBar.text];
        [fetchRequest setPredicate:predicate];
    }
    
    
    //Exectuting Fetch
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _timerArray = [[NSArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _timerArray = [self fetchTimers];
    Timers *firstTimer = _timerArray[0];
    NSLog(@"Count: %li First:%@",_timerArray.count,firstTimer.timerName);
    [_timersTableView reloadData]; //forces the table to reload the new data that has been created from the DetailViewController
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
