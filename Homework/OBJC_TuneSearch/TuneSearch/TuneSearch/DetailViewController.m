//
//  DetailViewController.m
//  TuneSearch
//
//  Created by Blake Oistad on 10/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "DetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel        *detailArtistLabel;
@property (nonatomic, weak) IBOutlet UILabel        *detailSongLabel;
@property (nonatomic, weak) IBOutlet UIImageView    *detailArtworkImageView;
@property (nonatomic, weak) IBOutlet UIButton       *audioPlayerPlayPauseButton;
@property (readwrite, retain)        AVPlayer       *audioPlayer;

@end

@implementation DetailViewController

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    NSLog(@"Item Ended");
    AVPlayerItem *item = [notification object];
    if (item == _audioPlayer.currentItem) {
        [_audioPlayer.currentItem seekToTime:kCMTimeZero];
    }
}

- (IBAction)audioPlayPauseButtonPressed:(id)sender {
    if ([[[_audioPlayerPlayPauseButton titleLabel] text] isEqualToString:@"Play"]) {
        NSLog(@"Play");
        [_audioPlayerPlayPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [_audioPlayer play];
        
    } else {
        NSLog(@"Pause");
        [_audioPlayerPlayPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        [_audioPlayer pause];
    }
}






- (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSLog(@"DocPath:%@",paths[0]);
    return paths[0];
}

- (BOOL)fileIsLocal:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:filename];
    return [fileManager fileExistsAtPath:filePath];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _detailArtistLabel.text = [_currentResult objectForKey:@"artistName"];
    _detailSongLabel.text = [_currentResult objectForKey:@"trackName"];
    
    NSString *filenameURL = [_currentResult objectForKey:@"artworkUrl60"];
    NSString *filenameFull = [filenameURL stringByReplacingOccurrencesOfString:@"/" withString:@""];
    filenameFull = [filenameFull stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSLog(@"Files %@ & %@",filenameFull,filenameURL);
        _detailArtworkImageView.image = [UIImage imageNamed:[[self getDocumentsDirectory] stringByAppendingPathComponent:filenameFull]];
    
    NSURL  *previewUrl = [NSURL URLWithString: [_currentResult objectForKey:@"previewUrl"]];
    _audioPlayer = [AVPlayer playerWithURL:previewUrl];
    _audioPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_audioPlayer currentItem]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
