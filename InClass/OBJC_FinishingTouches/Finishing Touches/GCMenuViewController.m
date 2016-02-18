//
//  GCMenuViewController.m
//  Finishing Touches
//
//  Created by Thomas Crawford on 11/24/13.
//  Copyright (c) 2013 Thomas Crawford. All rights reserved.
//

#import "GCMenuViewController.h"

@interface GCMenuViewController ()

@property (nonatomic,strong) NSArray                *menuArray;
@property (nonatomic,strong) IBOutlet UITableView   *menuTableView;

@end

@implementation GCMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _menuArray = @[@"Audio",@"Video",@"Animation",@"Gestures",@"Drawing",@"Appearance",@"Dynamics"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_menuArray objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath row]) {
        case 0:
            [self performSegueWithIdentifier:@"audioSegue" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"videoSegue" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"animationSegue" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"gesturesSegue" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"drawingSegue" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"appearanceSegue" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"dynamicsSegue" sender:self];
            break;
        default:
            break;
    }
}

@end
