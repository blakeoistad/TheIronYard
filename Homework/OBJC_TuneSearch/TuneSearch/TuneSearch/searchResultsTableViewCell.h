//
//  searchResultsTableViewCell.h
//  TuneSearch
//
//  Created by Blake Oistad on 10/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchResultsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *cellArtistLabel;
@property (nonatomic, weak) IBOutlet UILabel *cellGenreLabel;
@property (nonatomic, weak) IBOutlet UILabel *cellDateLabel;

@end
