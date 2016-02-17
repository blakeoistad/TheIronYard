//
//  ContractTableViewCell.h
//  iBounty
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 Blake & Jamal - TIYDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContractTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet    UILabel     *contractNameLabel;
@property (nonatomic, weak) IBOutlet    UISwitch    *contractConfirmSwitch;

@end
