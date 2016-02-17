//
//  ViewController.m
//  iNetwork
//
//  Created by Blake Oistad on 10/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)  NSString *hostName;

@end

@implementation ViewController

Reachability *hostReach;            //can you get the server?
Reachability *internetReach;        //can you get internet?
Reachability *wifiReach;            //can you see network connection options

bool internetAvailable;
bool serverAvailable;


#pragma mark - Interactivity Methods


- (IBAction)getFilePressed:(id)sender {
    //before you get a file from the internet, see if connection available
    if (serverAvailable) {
        NSLog(@"Server Available");
        
//        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/classfiles/iOS_URL_Class_Get_File.txt",_hostName]];
        NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/classfiles/flavors.json",_hostName]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData]; //ignores if file was previously downloaded and downloads again
        [request setTimeoutInterval:30.0];
        NSURLSession *session = [NSURLSession sharedSession];         //using this makes this process happen on a background thread, the execution is the next line down
        
        //when task is finished, exectute code in braces  ------------- blocks notified by ^ and parameters are in parenthases
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (([data length] > 0) && (error == nil)) {
                
                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];    //makes data viewable as json
                NSLog(@"Json: %@",json);
                
                NSArray *flavorStringArray = [(NSDictionary *) json objectForKey:@"flavors"];     //created array of dictionary items in flavors called flavorStringArray
                for (NSDictionary *flavorDict in flavorStringArray) {                             //loops through the array and spits out whatever you choose in the dictionary
                    NSLog(@"Flavor:%@",[flavorDict objectForKey:@"name"]);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // MAIN THREAD CODE GOES HERE        for instance, this is where you'd say [tableView reloadData], which updates the table which exists on the main thread
                });
                
//                NSLog(@"Got Data %@", data);
//                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];      //format the hexidecimal data into whatever data type and log it
//                NSLog(@"Got String %@", dataString);
                
                
            } else {
                NSLog(@"No Data");
            }
        }] resume];
        
        
    } else {
        NSLog(@"Server Not Available");  //give notification to let know no internet connection
    }
}



#pragma mark - Network Methods

- (void)updateReachabilityStatus: (Reachability *)currReach {
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [currReach currentReachabilityStatus];    //tell us the current network status
    if (currReach == hostReach) {                                       //if we reach the host, check the netstatus of said host connection
        switch (netStatus) {
                
            case NotReachable:                                          //if host is not reachable, log not available, server available set to false
                NSLog(@"Server Not Reachable");
                serverAvailable = false;
                break;
                
                case ReachableViaWiFi:
                NSLog(@"Server Reachable via Wifi");
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
                internetAvailable = false;
                break;
                
            case ReachableViaWiFi:
                NSLog(@"Internet Reachable via Wifi");
                internetAvailable = true;
                break;
                
            case ReachableViaWWAN:
                NSLog(@"Internet Reachable via Wide Area Network");
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
    
    //write a listener
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil]; //k stands for constant
    
    
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
