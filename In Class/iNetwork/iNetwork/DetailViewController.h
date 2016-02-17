//
//  DetailViewController.h
//  iNetwork
//
//  Created by Thomas Crawford on 10/5/15.
//  Copyright © 2015 VizNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSDictionary *currentFlavor;

@end
