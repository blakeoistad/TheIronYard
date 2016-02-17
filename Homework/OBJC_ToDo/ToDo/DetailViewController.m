//
//  DetailViewController.m
//  ToDo
//
//  Created by Blake Oistad on 9/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField                *todoTextField;
@property (nonatomic, strong)        AppDelegate                *appDelegate;
@property (nonatomic, strong)        NSManagedObjectContext     *managedObjectContext;
@property (nonatomic, weak) IBOutlet UISegmentedControl         *prioritySegControl;
@property (nonatomic, weak) IBOutlet UITextView                 *todoDescriptionTextView;
@property (nonatomic, weak) IBOutlet UIDatePicker               *todoDueDatePicker;

@end

@implementation DetailViewController






#pragma mark - Interactivity Methods


- (void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)saveButtonPressed:(id)sender {
    _currentTodoItem.todoName = _todoTextField.text;
    _currentTodoItem.todoDescription = _todoDescriptionTextView.text;
    _currentTodoItem.dateUpdated = [NSDate date];
    _currentTodoItem.todoDueDate = _todoDueDatePicker.date;
    _currentTodoItem.userID = @"User";
    _currentTodoItem.todoPriority = [_prioritySegControl titleForSegmentAtIndex:_prioritySegControl.selectedSegmentIndex];
    [self saveAndPop];
}

- (IBAction)deleteTodo:(id)sender {
    [_managedObjectContext deleteObject:_currentTodoItem];
    [self saveAndPop];
}

- (IBAction)segControlValueChanged:(UISegmentedControl *)segControl {
    NSString *priorityString = [segControl titleForSegmentAtIndex:(segControl.selectedSegmentIndex)];
    NSLog(@"Value changed %li %@", segControl.selectedSegmentIndex, priorityString);
}




#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_currentTodoItem != nil) {
        
        _todoTextField.text = _currentTodoItem.todoName;
        _todoDescriptionTextView.text = _currentTodoItem.todoDescription;
        _todoDueDatePicker.date = _currentTodoItem.todoDueDate;
        
        NSLog(@"xxx%@xxx",_currentTodoItem.todoPriority);
        if ([_currentTodoItem.todoPriority isEqualToString:@"!"]) {
            [_prioritySegControl setSelectedSegmentIndex:0];
        } else if ([_currentTodoItem.todoPriority isEqualToString:@"!!"]) {
            [_prioritySegControl setSelectedSegmentIndex:1];
        } else if ([_currentTodoItem.todoPriority isEqualToString:@"!!!"]) {
            [_prioritySegControl setSelectedSegmentIndex:2];
        }
        
        
        
    } else {
        ToDoList *newTodo = (ToDoList *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoList" inManagedObjectContext:_managedObjectContext];
        newTodo.dateEntered = [NSDate date];
        _currentTodoItem = newTodo;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
