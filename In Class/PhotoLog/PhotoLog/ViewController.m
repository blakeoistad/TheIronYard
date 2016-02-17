//
//  ViewController.m
//  PhotoLog
//
//  Created by Blake Oistad on 10/19/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"





@interface ViewController ()

@property (nonatomic, weak)     IBOutlet        UIImageView         *selectedImageView;

@end





@implementation ViewController

#pragma mark - Interactivity Methods

- (IBAction)galleryButtonTapped:(id)sender {
    NSLog(@"Gallery");
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:ipc animated:true completion:nil];
}

- (IBAction)cameraButtonTapped:(id)sender {
    NSLog(@"Camera");
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    //if the camera is available to this device
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:true completion:nil];
    } else {
        NSLog(@"Warn user no camera");    //or disable camera button for said device
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    NSLog(@"Save");
    NSString *imageFileName = [self getNewImageFilename];
    //only save if we got a filename, otherwise stop
    if (imageFileName) {
        NSString *newImagePath = [self getDocumentPathForFile:[NSString stringWithFormat:@"%@.png", imageFileName]];
        NSLog(@"New Path:%@", newImagePath);
        //make sure theres not already the same imagename in that path and that they have taken a new image to save
        if (![self fileDoesExistAtPath:newImagePath] && _selectedImageView.image) {
            //writes file to new png
            [UIImagePNGRepresentation(_selectedImageView.image) writeToFile:newImagePath atomically:true];
            NSLog(@"Saved %@", newImagePath);
        }
    }
    
}


#pragma mark - Image Picker Delegate Methods

//pick something, set image view to it, dismiss controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    _selectedImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:true completion:nil];
}


//simply dismisses controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}






#pragma mark - Core Methods
//these would likely exist in AppDelegate so they are available universally, each method is "dumb" and only knows about the one thing it does


//does the file exist at a given path?
- (BOOL)fileDoesExistAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

//gets path for documents directory
- (NSString *)getDocumentPathForFile:(NSString *)filename {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    NSLog(@"Docs:%@",path);
    return [path stringByAppendingPathComponent:filename];
}

//tell it where to copy from and to, and make sure there was no error
- (void)copyFromPath:(NSString *)fromPath toPath:(NSString *)toPath {
    NSError *error = nil;
    [[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"Error:%@",error);
    }
}

//only copy if needed
- (void)copyFileIfNeededFromPath:(NSString *)fromPath toPath:(NSString *)toPath {
    if (![self fileDoesExistAtPath:toPath]) {
        [self copyFromPath:fromPath toPath:toPath];
    }
}

//creates names for new image files
- (NSString *)getNewImageFilename {
    NSString *settingsPath = [self getDocumentPathForFile:@"Settings.plist"];
    //root in settings.plist is a dictionary, therefor we need to create a dictionary for the file
    NSMutableDictionary *settingsPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
    long counter = [[settingsPlist objectForKey:@"ImageNameCounter"] integerValue];
    NSString *imageFileName = [NSString stringWithFormat:@"image%li", counter];
    //increments the counter so that duplicate filenames aren't created
    [settingsPlist setValue:[NSNumber numberWithLong:counter++] forKey:@"ImageNameCounter"];
    //if not able to write new filename (issues with counter perhaps), then stop, don't contiinue to overwrite existing file
    BOOL didWriteToFile = [settingsPlist writeToFile:settingsPath atomically:true];
    if (didWriteToFile) {
        return imageFileName;
    }
    return nil;
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString *fromPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSString *toPath = [self getDocumentPathForFile:@"Settings.plist"];
    [self copyFileIfNeededFromPath:fromPath toPath:toPath];
    
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
