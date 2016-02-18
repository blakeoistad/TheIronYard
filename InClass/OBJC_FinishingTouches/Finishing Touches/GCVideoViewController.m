//
//  GCVideoViewController.m
//  Finishing Touches
//
//  Created by Thomas Crawford on 11/24/13.
//  Copyright (c) 2013 Thomas Crawford. All rights reserved.
//

#import "GCVideoViewController.h"

@interface GCVideoViewController ()

@property (nonatomic,strong) IBOutlet UIButton  *videoPlayPauseButton;

@end

@implementation GCVideoViewController

#pragma mark - Interactivity Methods

- (IBAction)videoPlayPauseButtonPressed:(id)sender {
    if ([[[_videoPlayPauseButton titleLabel] text] isEqualToString:@"Play"]) {
        NSLog(@"Play");
        [_videoPlayPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    } else {
        NSLog(@"Pause");
        [_videoPlayPauseButton setTitle:@"Play" forState:UIControlStateNormal];
    }
}

- (IBAction)videoResetButtonPressed:(id)sender {
    NSLog(@"Reset");
}

#pragma mark - System Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
