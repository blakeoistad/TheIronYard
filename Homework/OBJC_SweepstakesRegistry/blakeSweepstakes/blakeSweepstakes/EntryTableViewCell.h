//
//  EntryTableViewCell.h
//  blakeSweepstakes
//
//  Created by Blake Oistad on 10/21/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet    UILabel     *entryFullNameLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryFirstNameLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryLastNameLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryPhoneLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryEmailLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryFullAddressLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryCityLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryStateLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryWinCounterLabel;
@property (nonatomic, weak) IBOutlet    UILabel     *entryDateAddedLabel;

@end
