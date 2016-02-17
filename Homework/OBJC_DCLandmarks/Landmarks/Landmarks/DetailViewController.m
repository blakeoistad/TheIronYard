//
//  DetailViewController.m
//  Landmarks
//
//  Created by Blake Oistad on 10/7/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "ListViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong)                   AppDelegate                 *appDelegate;
@property (nonatomic, strong)                   NSManagedObjectContext      *managedObjectContext;

@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkTitleLabel;
@property (nonatomic, weak)         IBOutlet    UIImageView                 *landmarkImageView;
@property (nonatomic, weak)         IBOutlet    UITextView                  *landmarkDescTextView;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkAddressStreetLabel;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkAddressCityLabel;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkAddressStateLabel;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkAddressZipLabel;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkWebsiteLabel;
@property (nonatomic, weak)         IBOutlet    UILabel                     *landmarkPhoneLabel;
@property (nonatomic, weak)         IBOutlet    UIView                      *infoView;

@end

@implementation DetailViewController


- (IBAction)mapButtonPressed:(id)sender {
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _landmarkTitleLabel.text = _currentLandmark.landmarkName;
    _landmarkImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _currentLandmark.landmarkImageName]];
    _landmarkDescTextView.text = _currentLandmark.landmarkDescription;
    _landmarkAddressStreetLabel.text = _currentLandmark.landmarkStreet;
    _landmarkAddressCityLabel.text = _currentLandmark.landmarkCity;
    _landmarkAddressStateLabel.text = _currentLandmark.landmarkState;
    _landmarkAddressZipLabel.text = _currentLandmark.landmarkZip;
    _landmarkWebsiteLabel.text = _currentLandmark.landmarkWebsite;
    _landmarkPhoneLabel.text = _currentLandmark.landmarkPhone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
