//
//  ContractsListViewController.m
//  iBounty
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 Blake & Jamal - TIYDC. All rights reserved.
//

#import "ContractsListViewController.h"
#import "MainViewController.h"
#import "ContractTableViewCell.h"
#import "Character.h"

@interface ContractsListViewController ()

@property (nonatomic, strong)                       NSMutableArray             *activeContractsArray;
@property (nonatomic, weak)       IBOutlet          UITableView         *contractsListViewTableView;

@end

@implementation ContractsListViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activeContractsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContractTableViewCell *contractCell = (ContractTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"contractCell"];
//    Character *currentContract = _activeContractsArray[indexPath.row];
//    contractCell.contractNameLabel.text = currentContract.characterName;
//    contractCell.contractConfirmSwitch.on = false;
    return contractCell;
}




- (void)viewDidLoad {
    [super viewDidLoad];
//    _activeContractsArray = @[@"Tom",@"Blake"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
