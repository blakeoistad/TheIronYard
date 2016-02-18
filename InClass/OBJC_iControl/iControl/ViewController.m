//
//  ViewController.m
//  iControl
//
//  Created by Blake Oistad on 9/23/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView             *discoverTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl     *characterSegControl;
@property (nonatomic, weak) IBOutlet UISwitch               *favSwitch;
@property (nonatomic, weak) IBOutlet UIStepper              *ratingStepper;
@property (nonatomic, weak) IBOutlet UIDatePicker           *meetingDatePicker;
@property (nonatomic, strong)        NSArray                *personArray;

@end

@implementation ViewController

#pragma mark - Interactivity Methods

- (IBAction)segControlValueChanged :(UISegmentedControl *)segControl {
    NSString *nameString = [segControl titleForSegmentAtIndex:(segControl.selectedSegmentIndex)];
    NSLog(@"Value changed %li %@", segControl.selectedSegmentIndex, nameString);
}

- (IBAction)switchValueChanged:(UISwitch *)myswitch {
    NSLog(@"Switch changed %i", myswitch.isOn);
}

- (IBAction)ratingValueChanged:(UIStepper *)stepper {
    NSLog(@"Stepper changed %f", stepper.value);
}

- (IBAction)meetingDateChanged:(UIDatePicker *)datePicker {
    NSLog(@"Date: %@", datePicker.date);
}

#pragma mark - Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _personArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *currentPerson = _personArray[row];
    NSLog(@"Current Person: %@", currentPerson);
    return currentPerson[@"firstName"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDictionary *currentPerson = _personArray[row];
    NSLog(@"Selected %li %@", row, currentPerson[@"lastName"]);
}


#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _discoverTextView.text = @"Phone: (888)555-1212\nEmail: blake.oistad@gmail.com\nAddress: 3080 Woodlin Dr. Gum Spring, VA 23065\nLink: http://www.facebook.com";
    [_characterSegControl setSelectedSegmentIndex:0];
    [_favSwitch setOn:false animated:true];
    [_ratingStepper setValue:5];
    
    NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:(24*60*60)];
    
//   Subtracts a date as opposed to adding a day like the above implementation
//   NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:(-1*24*60*60)];
    
    [_meetingDatePicker setDate:newDate];
    
    
    NSDictionary *person1Dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Blake", @"firstName", @"Oistad", @"lastName",@"iOS Student",@"role",@"blake-oistad",@"imageName", nil];
    NSDictionary *person2Dict = @{@"firstName":@"Su",@"lastName":@"Kim",@"role":@"Campus Director",@"imageName":@"su-kim"};
    NSDictionary *person3Dict = @{@"firstName":@"James",@"lastName":@"Dabbs",@"role":@"Ruby Instructor",@"imageName":@"james-dabbs"};
    _personArray = @[person1Dict,person2Dict,person3Dict];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
