//
//  ViewController.m
//  Inevitable Calculator
//
//  Created by Blake Oistad on 9/22/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *displayLabel;

@property (nonatomic, strong)        NSString *currentOperator;


@end

@implementation ViewController


float left = 0.0;
float right = 0.0;
float result  = 0.0;
int currentPosition = 1;

#pragma mark - Number Keys



- (IBAction)oneButtonPressed:(id)sender {
    NSLog(@"One Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"1"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)twoButtonPressed:(id)sender {
    NSLog(@"Two Button Pressed");
//    _displayLabel.text = @"";

     _displayLabel.text = [_displayLabel.text stringByAppendingString:@"2"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)threeButtonPressed:(id)sender {
    NSLog(@"Three Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"3"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)fourButtonPressed:(id)sender {
    NSLog(@"Four Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"4"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)fiveButtonPressed:(id)sender {
    NSLog(@"Five Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"5"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)sixButtonPressed:(id)sender {
    NSLog(@"Six Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"6"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)sevenButtonPressed:(id)sender {
    NSLog(@"Seven Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"7"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)eightButtonPressed:(id)sender {
    NSLog(@"Eight Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"8"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)nineButtonPressed:(id)sender {
    NSLog(@"Nine Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"9"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)zeroButtonPressed:(id)sender {
    NSLog(@"Zero Button Pressed");
//    _displayLabel.text = @"";

    _displayLabel.text = [_displayLabel.text stringByAppendingString:@"0"];
    if ([_currentOperator isEqualToString:@""]) {
        left = [_displayLabel.text floatValue];
        
    } else {
        right = [_displayLabel.text floatValue];
    }
}

- (IBAction)decimalButtonPressed:(id)sender {
    NSLog(@"Decimal Button Pressed");
//    _displayLabel.text = @"";
    
    if (![_displayLabel.text containsString:@"."]) {
        NSLog(@"Found it");
        _displayLabel.text = [_displayLabel.text stringByAppendingString:@"."];
    }
}


#pragma mark - Operator Buttons

- (IBAction)plusButtonPressed:(id)sender {
    NSLog(@"currentOperator is addition");
    _displayLabel.text = @"";
    _currentOperator = @"+";
    currentPosition = 2;
}

- (IBAction)minusButtonPressed:(id)sender {
    NSLog(@"currentOperator is subtraction");
    _displayLabel.text = @"";
    _currentOperator = @"-";
    currentPosition = 2;
}

- (IBAction)multiplyButtonPressed:(id)sender {
    NSLog(@"currentOperator is multiplication");
    _displayLabel.text = @"";
    _currentOperator = @"*";
    currentPosition = 2;
}

- (IBAction)divideButtonPressed:(id)sender {
    NSLog(@"currentOperator is division");
    _displayLabel.text = @"";
    _currentOperator = @"/";
    currentPosition = 2;
}


- (IBAction)equalsButtonPressed:(id)sender {
    if ([_currentOperator isEqualToString:@"+"]) {
        result = left+right;
        left = result;
        NSLog(@"Equals Button Pressed %f + %f = %f",left, right, result);
        _displayLabel.text = [NSString stringWithFormat:@"%f", result];
    } else if ([_currentOperator isEqualToString:@"-"]) {
        result = left-right;
        left = result;
        NSLog(@"Equals Button Pressed %f - %f = %f",left, right, result);
        _displayLabel.text = [NSString stringWithFormat:@"%f", result];
    } else if ([_currentOperator isEqualToString:@"*"]) {
        result = left*right;
        left = result;
        NSLog(@"Equals Button Pressed %f * %f = %f",left,right, result);
        _displayLabel.text = [NSString stringWithFormat:@"%f", result];
    } else if ([_currentOperator isEqualToString:@"/"]) {
        result = left/right;
        left = result;
        NSLog(@"Equals Button Pressed %f / %f = %f",left,right, result);
        _displayLabel.text = [NSString stringWithFormat:@"%f", result];
    }
    
    
    
}

- (IBAction)clearButtonPressed:(id)sender {
    NSLog(@"Clear Button Pressed");
    currentPosition = 1;
    left=0;
    right=0;
    _currentOperator = @"";
    _displayLabel.text = @"";
    
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentOperator = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
