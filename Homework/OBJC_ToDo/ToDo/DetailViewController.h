//
//  DetailViewController.h
//  ToDo
//
//  Created by Blake Oistad on 9/29/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoList.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) ToDoList *currentTodoItem;

@end
