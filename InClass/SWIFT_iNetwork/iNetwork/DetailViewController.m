//
//  DetailViewController.m
//  iNetwork
//
//  Created by Thomas Crawford on 10/5/15.
//  Copyright © 2015 VizNetwork. All rights reserved.
//

#import "DetailViewController.h"
#import <SafariServices/SafariServices.h>


@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *myWebView;

@end

@implementation DetailViewController

#pragma mark - Interactivity Methods


- (void)dismissMessageControllers {
    [self becomeFirstResponder];            //put keyboard away
    [self dismissViewControllerAnimated:true completion:nil];       //dismiss view controller
}

- (IBAction)emailButtonPressed:(id)sender {
    NSLog(@"email");
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"Can send mail");
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:@"This is my subject"];
        [mailVC setMessageBody:@"This is the body of my email" isHTML:false];
        [mailVC setToRecipients:@[@"blake.oistad@gmail.com"]];
        //must PRESENT the view controller, like safari view controller below
        [self presentViewController:mailVC animated:true completion:nil];
        
    } else {
        NSLog(@"Cannot send mail");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissMessageControllers];
}


- (IBAction)smsButtonPressed:(id)sender {
    NSLog(@"sms");
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
        messageVC.messageComposeDelegate = self;
        messageVC.body = @"This is my text";
        [self presentViewController:messageVC animated:true completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissMessageControllers];
}

- (IBAction)facebookButtonPressed:(id)sender {
    NSLog(@"facebook");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbVC setInitialText:@"Hello FB Friends"];    //didnt work actually
        [self.navigationController presentViewController:fbVC animated:true completion:nil];
    }
}

- (IBAction)twitterButtonPressed:(id)sender {
    NSLog(@"twitter");
}

- (IBAction)shareButtonPressed:(id)sender {
    NSLog(@"share");
}

- (IBAction)showWebsitePressed:(id)sender {          //this opens the webpage in an embedded webView placed in with storyboard
    NSLog(@"show website");
    NSURL *webURL = [[NSURL alloc] initWithString:@"http://www.reddit.com"];
    [_myWebView loadRequest:[NSURLRequest requestWithURL:webURL]];
}

- (IBAction)showHTMLPressed:(id)sender {
    NSLog(@"show HTML");
    NSString *htmlString = @"<html><body><p>This is my first HTML page. Isn't this a blast!?<img src='o_tomato_sauce.png'></p></body></html>";
    [_myWebView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (IBAction)showPDFPressed:(id)sender {
    NSLog(@"show PDF");
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"MobileHIG" ofType:@"pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:imagePath]];
    [_myWebView loadRequest:request];
}

- (IBAction)showImagePressed:(id)sender {
    NSLog(@"show Image");
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"TomatoSauce" ofType:@"png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:imagePath]];
    [_myWebView loadRequest:request];
}

- (IBAction)showSafariPressed:(id)sender {          //this gives you a precreated view controller with safari controls ontop of current viewcontroller
    NSLog(@"show Safarai");
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.recode.net"]];
//    safariVC.delegate = self;                     //if using delegate methods, call it here
    [self.navigationController presentViewController:safariVC animated:true completion:nil];
}

- (IBAction)phoneButtonPressed:(id)sender {
    NSLog(@"phone pressed");
    NSString *phoneString = @"tel://8005551212";   //this is actually a URL
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    }
}

- (IBAction)openURLPressed:(id)sender {            //this opens the webpage in safari, not within the app itself
    NSLog(@"openURL");
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.theverge.com"]]) {
        NSLog(@"Can open");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.theverge.com"]];
    } else {
        NSLog(@"Cant open");
    }
}

- (IBAction)skypeButtonPressed:(id)sender {
    NSLog(@"skype");
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Got %@",[_currentFlavor objectForKey:@"name"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
