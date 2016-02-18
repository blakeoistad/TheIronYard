//
//  ViewController.m
//  LifeCycles
//
//  Created by Blake Oistad on 9/22/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     NSLog(@"didLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"willAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"didAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:true];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"willDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:true];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"didDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
     NSLog(@"didReceiveMemoryWarning");
}

@end
