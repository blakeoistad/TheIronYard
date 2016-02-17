//
//  ViewController.m
//  TuneSearch
//
//  Created by Blake Oistad on 10/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "searchResultsTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong)               NSString            *hostName;

@property (nonatomic, weak)     IBOutlet    UITableView         *searchTableView;
@property (nonatomic, strong)               NSArray             *searchArray;

@property (nonatomic, weak)     IBOutlet    UISearchBar         *searchSearchBar;
@property (nonatomic, weak)     IBOutlet    NSLayoutConstraint  *SearchBarTopConstraint;
@property (nonatomic, weak)     IBOutlet    NSLayoutConstraint  *searchTableViewTopConstraint;


@end

@implementation ViewController

Reachability *hostReach;
Reachability *internetReach;
Reachability *wifiReach;

bool internetAvailable;
bool serverAvailable;

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ResultsCell"];
    NSDictionary *currentTune = [_searchArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentTune objectForKey:@"trackName"];
    cell.detailTextLabel.text = [currentTune objectForKey:@"artistName"];
    
    NSString *filenameURL = [currentTune objectForKey:@"artworkUrl60"];
    NSString *filenameFull = [filenameURL stringByReplacingOccurrencesOfString:@"/" withString:@""];
    filenameFull = [filenameFull stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSLog(@"Files %@ & %@",filenameFull,filenameURL);
    if ([self fileIsLocal:filenameFull]) {
        cell.imageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:filenameFull]];
    } else {
    
    
        NSLog(@"Not Local %@",filenameURL);
    
        [self getImageFromServer:filenameFull fromURL:filenameURL atIndexPath:indexPath];
    }
    
    return cell;
}





#pragma mark - Interactivity Methods

//- (IBAction)checkButtonPressed:(id)sender {
//    
//    if (serverAvailable) {
//        NSLog(@"Server Available");
//        
//        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@/search?term=metallica",_hostName]];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fileURL];
//        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//        [request setTimeoutInterval:30.0];
//        
//        NSURLSession *session = [NSURLSession sharedSession];
//        
//        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            if (([data length] > 0) && (error == nil)) {
//                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                NSLog(@"JSON: %@",json);
//            }
//        }] resume];
//        
//    }
//         
//}

- (IBAction)toggleSearchBar:(id)sender {
    NSLog(@"Toggled");
    if (_searchSearchBar.hidden) {
        [_searchSearchBar setHidden:NO];
        NSLog(@"Before");
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_SearchBarTopConstraint setConstant:0.0];
            CGFloat tableViewPos = -1 * [UIApplication sharedApplication].statusBarFrame.size.height;
            [_searchTableViewTopConstraint setConstant:tableViewPos];
            [self.view layoutIfNeeded];
            NSLog(@"After");
        } completion:^(BOOL finished) {

        }];
    } else {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGFloat offscreen = -1 * _searchSearchBar.frame.size.height;
            [_SearchBarTopConstraint setConstant:offscreen];
            CGFloat tableViewPos = (-1 * self.navigationController.navigationBar.frame.size.height) - [UIApplication sharedApplication].statusBarFrame.size.height;
            [_searchTableViewTopConstraint setConstant:tableViewPos];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [_searchSearchBar setHidden:true];
        }];
    }
}

//- (IBAction)searchButtonPressed:(id)sender {
//    NSLog(@"Search button pressed");
//    if (_resultsSearchBar.hidden) {
//        [_resultsSearchBar setHidden:false];
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            [_searchBarTopConstraint setConstant:0.0];
//            CGFloat tableViewPos = -1 * [UIApplication sharedApplication].statusBarFrame.size.height;
//            [_resultsTableTopConstraint setConstant:tableViewPos];
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//        }];
//    } else {
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            //        [_resultsSearchBar setHidden:true];
//            CGFloat offScreen = -1 * _resultsSearchBar.frame.size.height;
//            [_searchBarTopConstraint setConstant:offScreen];
//            CGFloat tableViewPos = (-1 * self.navigationController.navigationBar.frame.size.height) - [UIApplication sharedApplication].statusBarFrame.size.height;
//            [_resultsTableTopConstraint setConstant:tableViewPos];
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            [_resultsSearchBar setHidden:YES];
//        }];
//    }
//}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [searchBar resignFirstResponder];
    if (serverAvailable) {
        NSLog(@"Server Available");
 
        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@/search?term=%@",_hostName,_searchSearchBar.text]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setTimeoutInterval:30.0];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (([data length] > 0) && (error == nil)) {
                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                _searchArray = [(NSDictionary *) json objectForKey:@"results"];
                for (NSDictionary *resultsDict in _searchArray) {
                    NSLog(@"Results: %@",[resultsDict objectForKey:@"trackName"]);
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_searchTableView reloadData];
                });
                
//                NSLog(@"JSON: %@",json);
            }
        }] resume];
        
    } else {
        NSLog(@"Server Not Available");
    }
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    DetailViewController *destController = [segue destinationViewController];
//    NSIndexPath *indexPath = [_searchTableView indexPathForSelectedRow];
//    destController.currentDict = [_searchArray objectAtIndex:indexPath.row];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"DetailsCell"]) {
        NSIndexPath *indexPath = [_searchTableView indexPathForSelectedRow];
        NSDictionary *currentResult = _searchArray[indexPath.row];
        destController.currentResult = currentResult;
    }
}


#pragma mark - Network Methods

- (void)updateReachabilityStatus: (Reachability *)currReach {
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [currReach currentReachabilityStatus];
    if (currReach == hostReach) {
        switch (netStatus) {
                
            case NotReachable:
                NSLog(@"Server Not Reachable");
                serverAvailable = false;
                break;
            case ReachableViaWiFi:
                NSLog(@"Server Reachable via Wifi");
                serverAvailable = true;
            case ReachableViaWWAN:
                NSLog(@"Server Reachable via Wide Area Network");
                serverAvailable = true;
                
            default:
                break;
        }
    }
    if (currReach == internetReach) {
        switch (netStatus) {
                
            case NotReachable:
                NSLog(@"Internet Not Reachable");
                internetAvailable = false;
                break;
            case ReachableViaWiFi:
                NSLog(@"Internet Reachable via Wifi");
                internetAvailable = true;
            case ReachableViaWWAN:
                NSLog(@"Internet Reachable via Wide Area Network");
                internetAvailable = true;
                
            default:
                break;
        }
    }
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability *currReach = [note object];
    [self updateReachabilityStatus:currReach];
}


- (void)getImageFromServer:(NSString *)localFilename fromURL:(NSString *)fullFilename atIndexPath:(NSIndexPath *)indexPath {
    if (serverAvailable) {
        NSURL *fileURL = [NSURL URLWithString:fullFilename];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setTimeoutInterval:30.0];
        NSURLSession *session = [NSURLSession sharedSession];
        NSLog(@"Pre Session");
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"In Session %li &error %@",[data length],error);
            if (([data length] > 0) && (error == nil)) {
                NSLog(@"Got Data");
                NSString *savedFilePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename];
                UIImage *imageTemp = [UIImage imageWithData:data];
                if (imageTemp != nil) {
                    [data writeToFile:savedFilePath atomically:true];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_searchTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    });
                } else {
                    NSLog(@"No Data");
                }
            }
        }] resume];
    } else {
        NSLog(@"Server Not Available");
    }
}




#pragma mark - File System Methods

- (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSLog(@"DocPath:%@",paths[0]);
    return paths[0];
}

- (BOOL)fileIsLocal:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:filename];
    return [fileManager fileExistsAtPath:filePath];
}





#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hostName = @"itunes.apple.com";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    hostReach = [Reachability reachabilityWithHostName:_hostName];
    [hostReach startNotifier];
    [self updateReachabilityStatus:hostReach];
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateReachabilityStatus:internetReach];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
