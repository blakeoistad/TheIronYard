//
//  DetailViewController.h
//  MyFavPeople
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Persons.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Persons   *currentPerson;

@end
