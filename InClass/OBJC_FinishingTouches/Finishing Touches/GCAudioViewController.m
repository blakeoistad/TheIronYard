//
//  GCAudioViewController.m
//  Finishing Touches
//
//  Created by Thomas Crawford on 11/24/13.
//  Copyright (c) 2013 Thomas Crawford. All rights reserved.
//

#import "GCAudioViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface GCAudioViewController () {
    SystemSoundID boingSound;               //not an object, doesnt need a pointer
}

@property (nonatomic,strong) IBOutlet UIButton              *audio2PlayPauseButton;
@property (nonatomic,strong) IBOutlet UIButton              *audio2ResetButton;
@property (readwrite,retain)          AVPlayer              *audioPlayer1;
@property (nonatomic,strong)          AVSpeechSynthesizer   *synthesizer;
@property (nonatomic, weak)  IBOutlet UITextView            *speakThisTextView;

@end

@implementation GCAudioViewController

#pragma mark - Speach Synthesis

- (IBAction)speakThisPressed:(id)sender {
    [self speakThis:_speakThisTextView.text];               //tells button to speak whatevers in the text view
}

- (void)speakThis:(NSString *)string {
    if (_synthesizer.isSpeaking) {                                          //prevents multiple layers of speaking at once
        [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
    [utterance setRate:0.5f];
     AVSpeechSynthesisVoice *voice = [[AVSpeechSynthesisVoice speechVoices] objectAtIndex:5];
    [utterance setVoice:voice];
    [_synthesizer speakUtterance:utterance];
   

    
}



#pragma mark Interactivity Methods

-(void)playerItemDidReachEnd:(NSNotification *)notification {
    NSLog(@"Item Ended");
    AVPlayerItem *item = [notification object];
    if (item == _audioPlayer1.currentItem) {                    //if the item is the curent item, rewind to the beginning
        [_audioPlayer1.currentItem seekToTime:kCMTimeZero];
        [self audio2PlayPauseButtonPressed:self];               //setting play/pause back to original state, which is play instead of pause (after full rewind)
    }
}

- (IBAction)audio1PlayButtonPressed:(id)sender {
    NSLog(@"Play 1");
    AudioServicesPlaySystemSound(boingSound);
}

- (IBAction)audio2PlayPauseButtonPressed:(id)sender {                                       //toggles between play and pause
    if ([[[_audio2PlayPauseButton titleLabel] text] isEqualToString:@"Play"]) {
        NSLog(@"Play 2");
        [_audio2PlayPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [_audioPlayer1 play];
    } else {
        NSLog(@"Pause 2");
        [_audio2PlayPauseButton setTitle:@"Play" forState:UIControlStateNormal];
        [_audioPlayer1 pause];
    }
}

- (IBAction)audio2ResetButtonPressed:(id)sender {
    NSLog(@"Reset");
    [_audioPlayer1.currentItem seekToTime:kCMTimeZero];
    
}

- (IBAction)vibrateButtonPressed:(id)sender {
    NSLog(@"Vibrate");
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark System Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *boingPath = [[NSBundle mainBundle] pathForResource:@"boing" ofType:@"wav"];
    NSURL *boingURL = [NSURL fileURLWithPath:boingPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)boingURL, &boingSound);                 //converts the nsurl to a cfurl with bridge to c (input), output is boing sound
    
    NSURL *laughURL = [[NSBundle mainBundle] URLForResource:@"laugh" withExtension:@"mp3"];     //one line version of above import
    _audioPlayer1 = [AVPlayer playerWithURL:laughURL];                                          //loads current sound into the player
    _audioPlayer1.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    //next line lets us know when player stops then runs playerItemDidReachEnd method from above that resets to play button and rewinds audio
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_audioPlayer1 currentItem]];
    
    
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    [self speakThis:@"Hello Blake!"];
    
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
