//
//  GCAnimationViewController.m
//  Finishing Touches
//
//  Created by Thomas Crawford on 11/24/13.
//  Copyright (c) 2013 Thomas Crawford. All rights reserved.
//

#import "GCAnimationViewController.h"

@interface GCAnimationViewController ()

@property (nonatomic,strong) IBOutlet UIView                *menuView;
@property (nonatomic,weak)   IBOutlet NSLayoutConstraint    *menuTopConstraint;

@end

@implementation GCAnimationViewController

#pragma mark - Interactivity Methods

- (IBAction)toggleMenuView:(id)sender {
    NSLog(@"Toggled");
    if (_menuView.hidden) {
        [_menuView setHidden:NO];
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //Code goes here
//            [_menuView setAlpha:1.0];
            [_menuTopConstraint setConstant:0.0];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            //More code goes here
        }];
    } else {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //code goes here
//            [_menuView setAlpha:0.0];
            CGFloat offscreen = -1 * _menuView.frame.size.height;
            [_menuTopConstraint setConstant:offscreen];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            //more code goes here
            [_menuView setHidden:true];
        }];
    }
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
