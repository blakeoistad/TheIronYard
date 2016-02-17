//
//  ViewController.m
//  ToDo
//
//  Created by Blake Oistad on 9/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "ToDoList.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong)           AppDelegate               *appDelegate;
@property (nonatomic, strong)           NSManagedObjectContext    *managedObjectContext;
@property (nonatomic, strong)           NSArray                   *todoArray;
@property (nonatomic, weak)   IBOutlet  UITableView               *todoTableView;

@end

@implementation ViewController





#pragma mark - Table View Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todoArray.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Going to delete %li", indexPath.row);
        ToDoList *todoToDelete = _todoArray[indexPath.row];
        [_managedObjectContext deleteObject:todoToDelete];
        [_appDelegate saveContext];
        _todoArray = [self fetchTodoList];
        [_todoTableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    ToDoList *currentItem = _todoArray[indexPath.row];
    cell.textLabel.text = currentItem.todoName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (IBAction)editButtonPressed:(id)sender {
    if (_todoTableView.isEditing) {
        [_todoTableView setEditing:false];
    } else {
        [_todoTableView setEditing:true];
    }
}







#pragma mark - Interactivity Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"segueEditToDo"]) {
    NSIndexPath *indexPath = [_todoTableView indexPathForSelectedRow];
    ToDoList *currentItem = _todoArray[indexPath.row];
    destController.currentTodoItem = currentItem;
        
    } else if ([[segue identifier] isEqualToString:@"segueAddToDo"]) {
        destController.currentTodoItem = nil;
    }

}





#pragma mark - Core Data Methods


- (IBAction)addRecord:(id)sender {
    ToDoList *newTodo = (ToDoList *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoList" inManagedObjectContext:_managedObjectContext];
    newTodo.todoName = @"";
    newTodo.dateEntered = [NSDate date];
    newTodo.userID = @"User";
}

- (IBAction)updateRecord:(id)sender {
    ToDoList *updateTodo = _todoArray[0];
    updateTodo.todoName = @"Dummy";
    updateTodo.dateEntered = [NSDate date];
    updateTodo.userID = @"User";
}


- (IBAction)deleteRecord:(id)sender {
    ToDoList *toDoToDelete = _todoArray[0];
    [_managedObjectContext deleteObject:toDoToDelete];
}

- (IBAction)rollbackChanges:(id)sender {
    [_managedObjectContext rollback];
}

- (NSArray *)fetchTodoList {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoList" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}





#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _todoArray = [[NSArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _todoArray = [self fetchTodoList];
//    ToDoList *firstTodo = _todoArray[0];
//    NSLog(@"Count: %li First:%@", _todoArray.count, firstTodo.todoName);
    [_todoTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
