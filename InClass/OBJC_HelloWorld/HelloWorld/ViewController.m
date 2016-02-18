//
//  ViewController.m
//  HelloWorld
//
//  Created by Blake Oistad on 9/21/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel        *welcomeLabel;

@property (nonatomic, weak) IBOutlet UITextField    *nameTextField;

@property (nonatomic, strong)        UILabel        *testLabel;

@end

@implementation ViewController

#pragma mark - Interactivity Methods

- (IBAction)goButtonPressed:(id)sender {
    NSLog(@"ButtonPressed %@",_nameTextField.text);
    _welcomeLabel.text = [NSString stringWithFormat:@"Hello %@!",_nameTextField.text];
    _testLabel.text = @"I'm real!";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark - Life Cycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _testLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(20.0, 200.0, 100.0, 21.0)];
    _testLabel.text = @"I'm a test label";
    [self.view addSubview:_testLabel];
    
    
    
    

}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
