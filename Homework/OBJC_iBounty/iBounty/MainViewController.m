//
//  MainViewController.m
//  iBounty
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 Blake & Jamal - TIYDC. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "Character.h"
#import "ContractsListViewController.h"
#import "ContractTableViewCell.h"

@interface MainViewController ()

@property (nonatomic, strong)                   AppDelegate                 *appDelegate;
@property (nonatomic, strong)                   NSManagedObjectContext      *managedObjectContext;

@property (nonatomic, strong)                   NSString                    *hostName;

@property (nonatomic, strong)                   NSArray                     *characterArray;

@property (nonatomic, weak)      IBOutlet       UILabel                     *characterNameLabel;
@property (nonatomic, weak)      IBOutlet       UIImageView                 *characterImageView;
@property (nonatomic, weak)      IBOutlet       UIButton                    *characterLocationButton;



@end


@implementation MainViewController

Reachability *hostReach;
Reachability *internetReach;
Reachability *wifiReach;

bool internetAvailable;
bool serverAvailable;
int currentCharacter;

#pragma mark - Interactivity Methods


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    ContractsListViewController *destController = [segue destinationViewController];
//    NSIndexPath *indexPath = [destController.contractsListViewTableView indexPath.row];
//    
//}


- (IBAction)passButtonPressed:(id)sender {
    NSLog(@"Pass Pressed");
}

- (IBAction)killButtonPressed:(id)sender {
    NSLog(@"Kill Pressed");
//    ContractsListViewController *destController = [[ContractsListViewController alloc] init];
//    destController = self.myModel.name;
//    [self.navigationController pushViewController:destinationController animated:YES];
}

- (IBAction)imageSwiped:(UISwipeGestureRecognizer *)gesture {
    NSLog(@"Swipe Performed");
    
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Swiped Left");
            currentCharacter++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"Swiped Right");
            
//            ContractsListViewController *contractsListView = [self.storyboard instantiateViewControllerWithIdentifier:@"contractsListView"];
//            screenB.objectPointerInOtherClass = self.objectIWantToPass;
//            
//            [self screenB animated:YES];
            
//            [self performSegueWithIdentifier:@"segueSwipeRightToContractList" sender:gesture];
            break;
            
        default:
            break;
    }
    currentCharacter++;                                         //after swipe is done, move to next character in array
    [self displayCurrentCharacter];                             //display said character, refreshing image, name, and location
}

#pragma mark - Segue Methods

#pragma mark - Core Data Methods






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
                NSLog(@"Server Reachable via WiFi");
                serverAvailable = true;
                break;
            case ReachableViaWWAN:
                NSLog(@"Server Reachable via Wide Area Network");
                serverAvailable = true;
                break;
                
            default:
                break;
        }
    }
    if (currReach == internetReach) {
        switch (netStatus) {
            case NotReachable:
                NSLog(@"Internet Not Reachable");
                serverAvailable = false;
                break;
            case ReachableViaWiFi:
                NSLog(@"Internet Reachable via WiFi");
                serverAvailable = true;
                break;
            case ReachableViaWWAN:
                NSLog(@"Internet Reachable via Wide Area Network");
                serverAvailable = true;
                break;
                
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
        if ([self fileIsLocal:localFilename]) {
            NSLog(@"Found Local");
            _characterImageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename]];
        } else {
            NSLog(@"Not Local %@",fullFilename);
            
            NSURL *fileURL = [NSURL URLWithString:fullFilename];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:fileURL];
            [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            [request setTimeoutInterval:30.0];
            
            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (([data length] > 0) && (error == nil)) {
                    NSLog(@"Got Image Data");
                    NSString *savedFilePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename];
                    UIImage *imageTemp = [UIImage imageWithData:data];
                    if (imageTemp != nil) {
                        [data writeToFile:savedFilePath atomically:true];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _characterImageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename]];
                        });
                    } else {
                        NSLog(@"No Image Data");
                    }
                }
            }] resume];
        }
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

- (void)displayCurrentCharacter {
    NSDictionary *currentCharacterDict = [_characterArray objectAtIndex:currentCharacter];
    _characterNameLabel.text = [currentCharacterDict objectForKey:@"characterName"];
    NSString *filenameURL = [currentCharacterDict objectForKey:@"characterImage"];
    NSString *filenameFull = [filenameURL stringByReplacingOccurrencesOfString:@"/" withString:@""];
    filenameFull = [filenameFull stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSLog(@"Files %@ & %@",filenameFull,filenameURL);
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if ([self fileIsLocal:filenameFull]) {
        _characterImageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:filenameFull]];
    } else {
        
        
        NSLog(@"Not Local %@",filenameURL);
        
        [self getImageFromServer:filenameFull fromURL:filenameURL atIndexPath:indexPath];
    }
//    if ([self fileIsLocal:localFilename]) {
////        NSLog(@"Found Local");
//        _characterImageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename]];
//    } else {
//        NSLog(@"Not Local %@",fullFilename);
    // IF FILE IS LOCAL
    //    _characterImageView.image = [UIImage imageNamed:[currentCharacterDict objectForKey:@"characterImage"]];
    // ELSE GET FILE FROM SERVER
    [_characterLocationButton setTitle:[currentCharacterDict objectForKey:@"characterOrigin"] forState:UIControlStateNormal];
//    [_characterLocationButton setTitle:(NSString *)[firstCharacter objectForKey:@"characterOrigin"]];
}

- (void)getDataFromServer {
    if (serverAvailable) {
        NSLog(@"Server Available");
        
        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://f5af1204.ngrok.io/ibounty/character"]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (([data length] > 0) && (error == nil)) {
                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                _characterArray = [(NSDictionary *) json objectForKey:@"characters"];
                for (NSDictionary *resultsDictionary in _characterArray) {
                    NSLog(@"Results: %@, %@, %@",[resultsDictionary objectForKey:@"characterName"],[resultsDictionary objectForKey:@"characterOrigin"],[resultsDictionary objectForKey:@"characterImage"]);
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //put code here
                    currentCharacter = 0;
                    [self displayCurrentCharacter];
                });
                
                NSLog(@"JSON: %@",json);
            }
        }]  resume];
        
    } else {
        NSLog(@"Server Not Available");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _characterArray = [[NSArray alloc] init];
    
    _hostName = @"itunes.apple.com";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:_hostName];
    [hostReach startNotifier];
    [self updateReachabilityStatus:hostReach];
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateReachabilityStatus:internetReach];
    
    [self getDataFromServer];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
