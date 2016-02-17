//
//  ViewController.m
//  iNetwork
//
//  Created by Thomas Crawford on 10/5/15.
//  Copyright © 2015 VizNetwork. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Flavors.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *hostName;
@property (nonatomic, weak)   IBOutlet UITableView *flavorsTableView;
@property (nonatomic, strong) NSMutableArray  *flavorsArray;

@end

@implementation ViewController

Reachability *hostReach;
Reachability *internetReach;
Reachability *wifiReach;
bool internetAvailable;
bool serverAvailable;

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _flavorsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    NSDictionary *currentFlavor = [_flavorsArray objectAtIndex:indexPath.row];
    Flavors *currentFlavor = [_flavorsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentFlavor flavorName];
//    cell.textLabel.text = [currentFlavor objectForKey:@"name"];
    
    NSString *filename = [currentFlavor flavorImageFilename];
    if ([self fileIsLocal:filename]) {
        NSLog(@"Local %@",filename);
        cell.imageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:filename]];    //loads image if its found
    } else {
        
        NSLog(@"Not Local %@",filename);
        [self getImageFromServer:filename fromURL:[NSString stringWithFormat:@"http://%@/classfiles/images/%@",_hostName,filename] atIndexPath:indexPath];
        
    }
    return cell;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    NSDictionary *currentFlavor = [_flavorsArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = [currentFlavor objectForKey:@"name"];
//    
//    NSString *filename = [currentFlavor objectForKey:@"filename"];
//    if ([self fileIsLocal:filename]) {
//        NSLog(@"Local %@",filename);
//        cell.imageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:filename]];    //loads image if its found
//    } else {
//        
//        NSLog(@"Not Local %@",filename);
//        [self getImageFromServer:filename fromURL:[NSString stringWithFormat:@"http://%@/classfiles/images/%@",_hostName,filename] atIndexPath:indexPath];
//        
//    }
//    return cell;
//}


#pragma mark - File System Methods


- (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSLog(@"DocPath:%@",paths[0]);   //logs the directory where the files will be stored
//    NSString *documentDirectory = paths[0];
    return paths[0];    //does the same thing as the above commented line, returns the array in string form
}

//check for existance of file
- (BOOL)fileIsLocal:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:filename];
    return [fileManager fileExistsAtPath:filePath];
}








#pragma mark - Interactivity Methods

- (IBAction)getFilePressed:(id)sender {
    if (serverAvailable) {
        NSLog(@"Server Available");
//        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/classfiles/iOS_URL_Class_Get_File.txt",_hostName]];
        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/classfiles/flavors.json",_hostName]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setTimeoutInterval:30.0];
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (([data length] > 0) && (error == nil)) {
//                NSLog(@"Got Data %@", data);
//                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"Got String %@",dataString);
                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"Json: %@",json);
                NSMutableArray *tempArray = [(NSDictionary *) json objectForKey:@"flavors"];
                _flavorsArray = [(NSDictionary *) json objectForKey:@"flavors"];
                for (NSDictionary *flavorDict in tempArray) {
                    
                    Flavors *currentFlavor = [[Flavors alloc] initWithName:[flavorDict objectForKey:@"name"] andImageName:[flavorDict objectForKey:@"filename"]];
//                    NSLog(@"flavor:%@",[flavorDict objectForKey:@"name"]);
                    [_flavorsArray addObject:currentFlavor];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // MAIN THREAD CODE GOES HERE
                    [_flavorsTableView reloadData];
                });
            } else {
                NSLog(@"No Data");
            }
        }] resume];
    } else {
        NSLog(@"Server Not Available");
    }
}

- (void)getImageFromServer:(NSString *)localFilename fromURL:(NSString *)fullFilename atIndexPath:
(NSIndexPath *)indexPath {
    if (serverAvailable) {
        NSURL *fileURL = [NSURL URLWithString:fullFilename];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setTimeoutInterval:30.0];
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (([data length] > 0) && (error == nil)) {              //converts data to image file from file path
                NSString *savedFilePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:localFilename];
                UIImage *imageTemp = [UIImage imageWithData:data];
                if (imageTemp != nil) {          //if it wasnt able to create an image...
                    [data writeToFile:savedFilePath atomically:true];     //saved the image
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_flavorsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    });
                }
            } else {
                NSLog(@"No Data");    //would also probably want to notify user instead of just nslogging
            }
        }] resume];
    } else {
        NSLog(@"Server Not Available");
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    NSIndexPath *indexPath = [_flavorsTableView indexPathForSelectedRow];
    destController.currentFlavor = [_flavorsArray objectAtIndex:indexPath.row];
}

#pragma mark - Network Methods

- (void)updateReachabilityStatus:(Reachability *)currReach {
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
                break;
            case ReachableViaWWAN:
                NSLog(@"Server Reachable via WAN");
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
                internetAvailable = false;
                break;
            case ReachableViaWiFi:
                NSLog(@"Internet Reachable via Wifi");
                internetAvailable = true;
                break;
            case ReachableViaWWAN:
                NSLog(@"Internet Reachable via WAN");
                internetAvailable = true;
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

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _hostName = @"www.moveablebytes.com";
    
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
