//
//  TextFieldTableViewCell.h
//  MyFavPeople
//
//  Created by Blake Oistad on 10/2/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet    UILabel        *cellLabel;
@property (nonatomic, weak) IBOutlet    UITextField    *cellTextField;

@end

