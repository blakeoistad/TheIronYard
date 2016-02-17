//
//  ViewController.m
//  FunWithXibs
//
//  Created by Blake Oistad on 11/12/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)goTo2ButtonPressed:(id)sender {
    NSLog(@"Button Pressed");
    SecondViewController *destController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    destController.currentString = @"Hello # 2!";              //pass string value into public string in dest controller (secondviewController)
    [self.navigationController pushViewController:destController animated:true];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"View # 1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
