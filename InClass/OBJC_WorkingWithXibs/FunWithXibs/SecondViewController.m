//
//  SecondViewController.m
//  FunWithXibs
//
//  Created by Blake Oistad on 11/12/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController






#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"View # 2"];
    NSLog(@"Got %@", _currentString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
