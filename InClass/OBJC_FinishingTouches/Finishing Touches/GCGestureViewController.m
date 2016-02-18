//
//  GCGestureViewController.m
//  Finishing Touches
//
//  Created by Thomas Crawford on 11/24/13.
//  Copyright (c) 2013 Thomas Crawford. All rights reserved.
//

#import "GCGestureViewController.h"

@interface GCGestureViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *universeImageView;

@end

@implementation GCGestureViewController

CGFloat lastScale;
CGFloat lastRotation;
CGFloat firstX;
CGFloat firstY;


#pragma mark - Interactivity Methods

- (IBAction)imageDoubleTapped:(id)sender {
    NSLog(@"Double Tapped");
}

- (IBAction)imageTwoFingerLongTapped:(id)sender {
    NSLog(@"Long Tapped");
}

- (IBAction)imageSwiped:(UISwipeGestureRecognizer *)gesture {               //UISwipeGestureRecognizer helps us know information about the swipe, like the direction
    NSLog(@"Swipe Performed");
    
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"Up");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"Down");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Left");
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"Right");
            break;
            
        default:
            break;
    }
}

- (IBAction)imagePinched:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"Pinch Recognized");
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale - gesture.scale);
    CGAffineTransform currentTransform = _universeImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_universeImageView setTransform:newTransform];
    lastScale = gesture.scale;
}

- (IBAction)imageRotated:(UIRotationGestureRecognizer *)gesture {
    NSLog(@"Rotated Image");
    if (gesture.state == UIGestureRecognizerStateEnded) {
        lastRotation = 0;
        return;
    }
    CGFloat rotation = 0.0 - (lastRotation - gesture.rotation);
    CGAffineTransform currentTransform = _universeImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    [_universeImageView setTransform:newTransform];
    lastRotation = gesture.rotation;
    
}

- (IBAction)imagePanned:(UIPanGestureRecognizer *)gesture {
    NSLog(@"Panned image");
    CGPoint translatedPoint = [gesture translationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        firstX = _universeImageView.center.x;
        firstY = _universeImageView.center.y;
    }
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    [_universeImageView setCenter:translatedPoint];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}



#pragma mark - Life Cycle Methods

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
