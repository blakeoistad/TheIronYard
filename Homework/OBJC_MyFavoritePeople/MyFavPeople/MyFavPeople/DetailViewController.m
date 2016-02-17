//
//  DetailViewController.m
//  MyFavPeople
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "TextFieldTableViewCell.h"

@interface DetailViewController ()

@property (nonatomic, strong)               AppDelegate                 *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext      *managedObjectContext;

@property (nonatomic, weak)     IBOutlet    UITableView                 *contactInfoTableView;
@property (nonatomic, strong)               NSMutableArray              *cellLabelArray;
@property (nonatomic, strong)               NSMutableArray              *cellTypeArray;
@property (nonatomic, strong)               NSArray                     *defaultCellLabelArray;
@property (nonatomic, strong)               NSArray                     *defaultCellTypeArray;
@property (nonatomic, strong)               NSArray                     *emailArray;

//@property (nonatomic, weak)     IBOutlet    UITextField                 *personFirstNameTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personLastNameTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personPhoneNumberTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personAddressStreetTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personAddressCityTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personAddressStateTextField;
//@property (nonatomic, weak)     IBOutlet    UITextField                 *personAddressZipTextField;


@end

@implementation DetailViewController

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextFieldTableViewCell *textCell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    textCell.cellLabel.text = _cellLabelArray[indexPath.row];
    if (indexPath.row == 0) {
        textCell.cellTextField.text = _currentPerson.personFirstName;
    } else if (indexPath.row == 1) {
        textCell.cellTextField.text = _currentPerson.personLastName;
    } else if (indexPath.row == 2) {
        textCell.cellTextField.text = _currentPerson.personPhoneNumber;
    } else if (indexPath.row == 3) {
        textCell.cellTextField.text = _currentPerson.personAddressStreet;
    } else if (indexPath.row == 4) {
        textCell.cellTextField.text = _currentPerson.personAddressCity;
    } else if (indexPath.row == 5) {
        textCell.cellTextField.text = _currentPerson.personAddressState;
    } else if (indexPath.row == 6) {
        textCell.cellTextField.text = _currentPerson.personAddressZip;
    }
    return textCell;
}





#pragma mark - Navigation Methods

- (void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}






#pragma mark - Interactivity

- (IBAction)saveButtonPressed:(id)sender {
    NSIndexPath *indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
    TextFieldTableViewCell *textCell0 = [_contactInfoTableView cellForRowAtIndexPath:indexPath0];
    _currentPerson.personFirstName = textCell0.cellTextField.text;
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    TextFieldTableViewCell *textCell1 = [_contactInfoTableView cellForRowAtIndexPath:indexPath1];
    _currentPerson.personLastName = textCell1.cellTextField.text;
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
    TextFieldTableViewCell *textCell2 = [_contactInfoTableView cellForRowAtIndexPath:indexPath2];
    _currentPerson.personPhoneNumber = textCell2.cellTextField.text;
    
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
    TextFieldTableViewCell *textCell3 = [_contactInfoTableView cellForRowAtIndexPath:indexPath3];
    _currentPerson.personAddressStreet = textCell3.cellTextField.text;
    
    NSIndexPath *indexPath4 = [NSIndexPath indexPathForRow:4 inSection:0];
    TextFieldTableViewCell *textCell4 = [_contactInfoTableView cellForRowAtIndexPath:indexPath4];
    _currentPerson.personAddressCity = textCell4.cellTextField.text;
    
    NSIndexPath *indexPath5 = [NSIndexPath indexPathForRow:5 inSection:0];
    TextFieldTableViewCell *textCell5 = [_contactInfoTableView cellForRowAtIndexPath:indexPath5];
    _currentPerson.personAddressState = textCell5.cellTextField.text;
    
    NSIndexPath *indexPath6 = [NSIndexPath indexPathForRow:6 inSection:0];
    TextFieldTableViewCell *textCell6 = [_contactInfoTableView cellForRowAtIndexPath:indexPath6];
    _currentPerson.personAddressZip = textCell6.cellTextField.text;
    
    NSLog(@"Cell Text 0 %@",textCell0.cellTextField.text);
//    _currentPerson.personFirstName = _personFirstNameTextField.text;
//    _currentPerson.personLastName = _personLastNameTextField.text;
//    _currentPerson.personPhoneNumber = _personPhoneNumberTextField.text;
//    _currentPerson.personAddressStreet = _personAddressStreetTextField.text;
//    _currentPerson.personAddressCity =  _personAddressCityTextField.text;
//    _currentPerson.personAddressState = _personAddressStateTextField.text;
//    _currentPerson.personAddressZip = _personAddressZipTextField.text;
    _currentPerson.dateUpdated = [NSDate date];
    _currentPerson.userID = @"User";
    
    [self saveAndPop];
}

- (IBAction)deleteRecord:(id)sender {
    [_managedObjectContext deleteObject:_currentPerson];
    [self saveAndPop];
}







#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _defaultCellLabelArray =  @[@"First Name",@"Last Name",@"Phone Number",@"Street Address",@"City",@"State",@"Zip Code"];
    _defaultCellTypeArray = @[@"",@"",@"",@"",@"",@"",@""];
//    _emailArray = @[@"Work",@"Home",@"Other"];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _cellLabelArray = [NSMutableArray arrayWithArray:_defaultCellLabelArray];
    _cellTypeArray = [NSMutableArray arrayWithArray:_defaultCellTypeArray];
    
    if (_currentPerson != nil) {
//        _personFirstNameTextField.text = _currentPerson.personFirstName;
//        _personLastNameTextField.text = _currentPerson.personLastName;
//        _personPhoneNumberTextField.text = _currentPerson.personPhoneNumber;
//        _personAddressStreetTextField.text = _currentPerson.personAddressStreet;
//        _personAddressCityTextField.text = _currentPerson.personAddressCity;
//        _personAddressStateTextField.text = _currentPerson.personAddressState;
//        _personAddressZipTextField.text = _currentPerson.personAddressZip;
    } else {
        Persons *newPerson = (Persons *)[NSEntityDescription insertNewObjectForEntityForName:@"Persons" inManagedObjectContext:_managedObjectContext];
        newPerson.dateEntered = [NSDate date];
        _currentPerson = newPerson;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
