//
//  ViewController.m
//  MyFavPeople
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Persons.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong)               AppDelegate             *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, strong)               NSArray                 *personsArray;
@property (nonatomic, weak)     IBOutlet    UITableView             *personsTableView;


@end

@implementation ViewController

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *subtitleCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SubtitleCell"];
    Persons *currentPerson = _personsArray[indexPath.row];
    subtitleCell.textLabel.text = [NSString stringWithFormat:@"%@ %@",currentPerson.personFirstName, currentPerson.personLastName];
    subtitleCell.detailTextLabel.text = currentPerson.personPhoneNumber;
    return subtitleCell;
}







#pragma mark - Interactivity Methods

- (IBAction)editButtonPressed:(id)sender {
    if (_personsTableView.isEditing) {
        [_personsTableView setEditing:false];
    } else {
        [_personsTableView setEditing:true];
    }
    
//    [_personsTableView setEditing:!_personsTableView.isEditing];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Going to delete %li", indexPath.row);
        Persons *personToDelete = _personsArray[indexPath.row];
        [_managedObjectContext deleteObject:personToDelete];
        [_appDelegate saveContext];
        _personsArray = [self fetchPersons];
        [_personsTableView reloadData];
    }
}






#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"segueEditPerson"]) {
        NSIndexPath *indexPath = [_personsTableView indexPathForSelectedRow];
        Persons *currentPerson = _personsArray[indexPath.row];
        destController.currentPerson = currentPerson;
        NSLog(@"Edit current person");
    } else if ([[segue identifier] isEqualToString:@"segueAddPerson"]) {
        NSLog(@"Add button pressed");
        destController.currentPerson = nil;
    }
}







#pragma mark - Search Methods


//- (IBAction)searchButtonPressed:(id)sender {
//    NSLog(@"Search Button Pressed");
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText {
//    //-Load in seachBar code here
//}







#pragma mark - Core Data Methods

//- (void)tempAddRecords {
//    ToDos *newToDo = (ToDos *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDos" inManagedObjectContext:_managedObjectContext];
//    // the user will enter this through a text field; we just hardcoded this for now
//    newToDo.toDoName = @"ToDo Item";
//    newToDo.toDoDescription = @"Here is the description";
//    newToDo.toDoPriority = @"!!";
//    newToDo.toDoCompleteDone = false;
//    newToDo.dateEntered = [NSDate date];
//    newToDo.userID = @"System";
//    // this should only occur when the user hits the 'Save' button or when a new record is added
//    [_appDelegate saveContext];
//}

//- (void)tempAddRecords {
//    Persons *newPerson = (Persons *)[NSEntityDescription insertNewObjectForEntityForName:@"Persons" inManagedObjectContext:_managedObjectContext];
//    newPerson.personFirstName = @"Blake";
//    newPerson.personLastName = @"Oistad";
//    newPerson.personPhoneNumber = @"(804)432-1353";
//    newPerson.personRole = @"Student";
//    newPerson.personSkypeID = @"blake_oistad";
//    newPerson.personTwitterID = @"blake_oistad";
//    newPerson.personCategory = @"Self";
//    newPerson.personImageName = @"blake_oistad.png";
//    [_appDelegate saveContext];
//}

//- (IBAction)updateRecord:(id)sender {
//    Persons *updatePerson = _personsArray[0];
//    updatePerson.personFirstName = @"Blake";
//    updatePerson.personLastName = @"Oistad";
//    updatePerson.personPhoneNumber = @"(804)432-1353";
//    updatePerson.personRole = @"Student";
//    updatePerson.personSkypeID = @"blake_oistad";
//    updatePerson.personTwitterID = @"blake_oistad";
//    updatePerson.personCategory = @"Self";
//    updatePerson.personImageName = @"blake_oistad.png";
//    
//}

//- (IBAction)deleteRecord:(id)sender {
//    Persons *personToDelete = _personsArray[0];
//    [_managedObjectContext deleteObject:personToDelete];
//}

//- (IBAction)rollbackChanges:(id)sender {
//    [_managedObjectContext rollback];
//}

- (NSArray *)fetchPersons {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Persons" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //-Set up Sorting Here
    
    
    //-Set up Search Here
    
    
    //-Execute the Fetch
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}







#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _personsArray = [[NSArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _personsArray = [self fetchPersons];
    [_personsTableView reloadData];
//    [self tempAddRecords];
//    Persons *firstPerson = _personsArray[0];
//    NSLog(@"Count: %li First:%@ Last:%@",_personsArray.count, firstPerson.personFirstName, firstPerson.personLastName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
