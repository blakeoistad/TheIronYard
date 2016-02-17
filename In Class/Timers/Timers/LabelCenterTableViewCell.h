//
//  LabelCenterTableViewCell.h
//  Timers
//
//  Created by Blake Oistad on 10/1/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCenterTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel  *cellLabel;
@property (nonatomic, weak) IBOutlet UISwitch *cellSwitch;

@end
