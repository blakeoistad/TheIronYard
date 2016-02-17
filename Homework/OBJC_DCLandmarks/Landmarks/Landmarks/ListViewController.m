//
//  ListViewController.m
//  Landmarks
//
//  Created by Blake Oistad on 10/8/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ListViewController ()

@property (nonatomic, strong)                   AppDelegate                 *appDelegate;
@property (nonatomic, strong)                   NSManagedObjectContext      *managedObjectContext;

@property (nonatomic, weak)     IBOutlet        UITableView                 *landmarksTableView;

@end

@implementation ListViewController

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appDelegate.landmarksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Landmarks *currentLandmark = _appDelegate.landmarksArray[indexPath.row];
    cell.textLabel.text = currentLandmark.landmarkName;
    NSLog(@"L %@ %@,%@",currentLandmark.landmarkName, currentLandmark.landmarkLat, currentLandmark.landmarkLong);
    return cell;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"segueCellToDetail"]) {
        NSIndexPath *indexPath = [_landmarksTableView indexPathForSelectedRow];
        Landmarks *currentLandmark = _appDelegate.landmarksArray[indexPath.row];
        destController.currentLandmark = currentLandmark;
    }
}





#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _appDelegate.landmarksArray = [[NSArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _appDelegate.landmarksArray = [_appDelegate fetchLandmarks];
    NSLog(@"Count: %li",_appDelegate.landmarksArray.count);
    [_landmarksTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
