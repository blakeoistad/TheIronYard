//
//  ViewController.m
//  Landmarks
//
//  Created by Blake Oistad on 10/7/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"
#import "Landmarks.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong)               AppDelegate                 *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext      *managedObjectContext;

@property (nonatomic, strong)               CLLocationManager           *locationManager;
@property (nonatomic, weak)     IBOutlet    MKMapView                   *landmarkMapView;
@property (nonatomic, strong)               NSArray                     *landmarksArray;
@property (nonatomic, strong)               NSString                    *selectedLandmarkName;

@end

@implementation ViewController





#pragma mark - Annotation Methods

- (void)annotateMapLocations {
    NSMutableArray *pinsToRemove = [[NSMutableArray alloc] init];
    
    for (id <MKAnnotation> annot in [_landmarkMapView annotations]) {
        if ([annot isKindOfClass:[MKPointAnnotation class]]) {
            [pinsToRemove addObject:annot];
        }
    }
    [_landmarkMapView removeAnnotations:pinsToRemove];
    
    NSMutableArray *pinsToAdd = [[NSMutableArray alloc] init];
    for (Landmarks *landmark in _appDelegate.landmarksArray) {
        MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
        double lat = [landmark.landmarkLat doubleValue];
        double lon = [landmark.landmarkLong doubleValue];
        pa.coordinate = CLLocationCoordinate2DMake(lat, lon);
        pa.title = landmark.landmarkName;
        [pinsToAdd addObject:pa];
    }

    //place conditional here to stop pins from repeatedly falling?
    [_landmarkMapView addAnnotations:pinsToAdd];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation != mapView.userLocation) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        }
        annotationView.canShowCallout = true;
        annotationView.animatesDrop = true;
        annotationView.pinTintColor = [UIColor blackColor];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
    }
    return nil;
}






#pragma mark - Map Methods

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Pin Tapped");
    _selectedLandmarkName = view.annotation.title;
        [self performSegueWithIdentifier:@"seguePinToDetail" sender:mapView];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"seguePinToDetail"]) {
        Landmarks *currentLandmark = [_appDelegate fetchLandmarkName:_selectedLandmarkName];
        destController.currentLandmark = currentLandmark;
    }
}


- (void)zoomToLocationWithLat:(float)latitude andLon:(float)longitude andDiameter:(float)diameter {
    if (latitude == 0 && longitude == 0) {
        NSLog(@"Passed in Bad Data");
    } else {
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = latitude;
        zoomLocation.longitude = longitude;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, diameter, diameter);
        MKCoordinateRegion adjustedRegion = [_landmarkMapView regionThatFits:viewRegion];
        [_landmarkMapView setRegion:adjustedRegion animated:true];
    }
}

- (void)zoomToPin {
    [_landmarkMapView showAnnotations:[_landmarkMapView annotations] animated:true];
}







#pragma mark - Location Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    NSLog(@"lat:%f long:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
//    [self zoomToLocationWithLat:currentLocation.coordinate.latitude andLon:currentLocation.coordinate.longitude andDiameter:5500];
    [self zoomToPin];
}

- (void)turnOnLocationMonitoring {
    [_locationManager startUpdatingLocation];
    _landmarkMapView.showsUserLocation = true;
}

- (void)setUpLocationMonitoring {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Loc Services Enabled");
        switch ([CLLocationManager authorizationStatus]) {
                
            case kCLAuthorizationStatusAuthorizedAlways:
                [self turnOnLocationMonitoring];
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                [self turnOnLocationMonitoring];
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"Hey User, Turn Location Back On!");
                break;
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"Hey User, Would you like to enable Location Services?");
                if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [_locationManager requestWhenInUseAuthorization];
                } else {
                    NSLog(@"No Selector");
                }
                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"Hey User, Disable Location Restrictions in Settings");
                break;
                
            default:
                break;
        }
    } else {
        NSLog(@"Turn on Location Services in Settings");
    }
}





#pragma mark - Core Data Methods


//- (NSArray *)fetchLandmarks {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    return fetchResults;
//}
//
- (void)tempAddLandmarks {



    Landmarks *newLandmark = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark.landmarkName = @"McDonalds";
    newLandmark.landmarkDescription = @"This McDonald’s is right down the street from The Iron Yard campus and is a great stop for very cheap food if you’re strapped for cash.";
    newLandmark.landmarkLat = @"38.905622";
    newLandmark.landmarkLong = @"-77.044218";
    newLandmark.landmarkImageName = @"dcMcDonalds.jpg";
    newLandmark.landmarkStreet = @"1916 M St NW";
    newLandmark.landmarkCity = @"Washington";
    newLandmark.landmarkState = @"DC";
    newLandmark.landmarkZip = @"20036";
    newLandmark.landmarkWebsite = @"http://www.mcdonalds.com/us/en/home.html";
    newLandmark.landmarkPhone = @"(202)296-8839";



    Landmarks *newLandmark1 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark1.landmarkName = @"Newseum";
    newLandmark1.landmarkDescription = @"The Newseum’s mission is to champion the five freedoms of the First Amendment through exhibits, public programs and education. Established and supported in part by the Freedom Forum.";
    newLandmark1.landmarkLat = @"38.892821";
    newLandmark1.landmarkLong = @"-77.019292";
    newLandmark1.landmarkImageName = @"dcNewseum.jpg";
    newLandmark1.landmarkStreet = @"555 Pennsylvania Ave";
    newLandmark1.landmarkCity = @"Washington";
    newLandmark1.landmarkState = @"DC";
    newLandmark1.landmarkZip = @"20001";
    newLandmark1.landmarkWebsite = @"http://www.newseum.org";
    newLandmark1.landmarkPhone = @"(888)639-7386";



    Landmarks *newLandmark2 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark2.landmarkName = @"Washington Monument";
    newLandmark2.landmarkDescription = @"This momument stands in appreciation of George Washington, the first president of the United States. It pays tribute to his role as a leader while the country struggled to gain independence from Great Britain more than 200 years ago.";
    newLandmark2.landmarkLat = @"38.889333";
    newLandmark2.landmarkLong = @"-77.035306";
    newLandmark2.landmarkImageName = @"dcWashMon.jpg";
    newLandmark2.landmarkStreet = @"2 15th St NW";
    newLandmark2.landmarkCity = @"Washington";
    newLandmark2.landmarkState = @"DC";
    newLandmark2.landmarkZip = @"20007";
    newLandmark2.landmarkWebsite = @"http://http://www.nps.gov/wamo/index.htm";
    newLandmark2.landmarkPhone = @"(202)426-6841";



    Landmarks *newLandmark3 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark3.landmarkName = @"Lincoln Memorial";
    newLandmark3.landmarkDescription = @"Located in the National Mall, the Lincoln Memorial is a tribute to former President Abraham Lincoln. Designed with a Greek Temple theme, this memorial has 36 Doric columns, each representing a state at the time of Lincoln's death. The north wall features an etched version of Lincoln's second inaugural speech.";
    newLandmark3.landmarkLat = @"38.903837";
    newLandmark3.landmarkLong = @"-77.05011";
    newLandmark3.landmarkImageName = @"dcLincolnMem.jpg";
    newLandmark3.landmarkStreet = @"2 Lincoln Memorial Cir NW";
    newLandmark3.landmarkCity = @"Washington";
    newLandmark3.landmarkState = @"DC";
    newLandmark3.landmarkZip = @"20037";
    newLandmark3.landmarkWebsite = @"http://www.nps.gov/linc/index.htm";
    newLandmark3.landmarkPhone = @"(202)426-6841";



    Landmarks *newLandmark4 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark4.landmarkName = @"The Iron Yard";
    newLandmark4.landmarkDescription = @"This is the location of The Iron Yard DC, a coding bootcamp that helps you get the career.";
    newLandmark4.landmarkLat = @"38.906004";
    newLandmark4.landmarkLong = @"-77.041880";
    newLandmark4.landmarkImageName = @"dcIronYard.jpg";
    newLandmark4.landmarkStreet = @"1200 18th St NW";
    newLandmark4.landmarkCity = @"Washington";
    newLandmark4.landmarkState = @"DC";
    newLandmark4.landmarkZip = @"20036";
    newLandmark4.landmarkWebsite = @"http://www.theironyard.com/locations/washington-dc/";
    newLandmark4.landmarkPhone = @"(571)733-9744";



    Landmarks *newLandmark5 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark5.landmarkName = @"Verizon Center";
    newLandmark5.landmarkDescription = @"Home of the Washington Capitals and Wizards.  Formally known as the MCI Center, the Verizon Center also serves as an entertainment arena for various artists and performers.";
    newLandmark5.landmarkLat = @"38.897540";
    newLandmark5.landmarkLong = @"-77.020955";
    newLandmark5.landmarkImageName = @"dcVerizonCenter.png";
    newLandmark5.landmarkStreet = @"601 F St NW";
    newLandmark5.landmarkCity = @"Washington";
    newLandmark5.landmarkState = @"DC";
    newLandmark5.landmarkZip = @"20004";
    newLandmark5.landmarkWebsite = @"http://verizoncenter.monumentalnetwork.com";
    newLandmark5.landmarkPhone = @"(202)628-3200";



    Landmarks *newLandmark6 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark6.landmarkName = @"Martin Luther King Memorial";
    newLandmark6.landmarkDescription = @"This McDonald’s is right down the street from The Iron Yard campus and is a great stop for very cheap food if you’re strapped for cash.";
    newLandmark6.landmarkLat = @"38.886081";
    newLandmark6.landmarkLong = @"-77.044335";
    newLandmark6.landmarkImageName = @"dcMLKMem.jpg";
    newLandmark6.landmarkStreet = @"1964 Independence Ave SW";
    newLandmark6.landmarkCity = @"Washington";
    newLandmark6.landmarkState = @"DC";
    newLandmark6.landmarkZip = @"20024";
    newLandmark6.landmarkWebsite = @"http://www.nps.gov/mlkm/index.htm";
    newLandmark6.landmarkPhone = @"(202)426-6841";



    Landmarks *newLandmark7 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark7.landmarkName = @"Vietnam Memorial";
    newLandmark7.landmarkDescription = @"This memorial is intended to remember the American military who sacrificed their lives during the Vietnam War. This was the nation's least popular war. Featured in the memorial is the Wall of names, the Three Servicemen Statue and Flagpole. Also featured is the Vietnam Women's Memorial.";
    newLandmark7.landmarkLat = @"38.891106";
    newLandmark7.landmarkLong = @"-77.047712";
    newLandmark7.landmarkImageName = @"dcVietnamMem.jpg";
    newLandmark7.landmarkStreet = @"5 Henry Bacon Dr NW";
    newLandmark7.landmarkCity = @"Washington";
    newLandmark7.landmarkState = @"DC";
    newLandmark7.landmarkZip = @"20245";
    newLandmark7.landmarkWebsite = @"http://www.nps.gov/vive/index.htm";
    newLandmark7.landmarkPhone = @"(202)426-6841";



    Landmarks *newLandmark8 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark8.landmarkName = @"WWII Memorial";
    newLandmark8.landmarkDescription = @"The National World War II Memorial honors the 16 million Americans who served in WWII and the more than 400,000 that died. The memorial is located on 17th Street, between Constitution and Independence Avenues. It is between the Washington Monument and Lincoln Memorial.";
    newLandmark8.landmarkLat = @"38.889439";
    newLandmark8.landmarkLong = @"-77.040347";
    newLandmark8.landmarkImageName = @"dcWWII.jpg";
    newLandmark8.landmarkStreet = @"17th Street & Independence Avenues NW";
    newLandmark8.landmarkCity = @"Washington";
    newLandmark8.landmarkState = @"DC";
    newLandmark8.landmarkZip = @"20024";
    newLandmark8.landmarkWebsite = @"http://www.wwiimemorial.com";
    newLandmark8.landmarkPhone = @"(202)619-7222";



    Landmarks *newLandmark9 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark9.landmarkName = @"FDR Memorial";
    newLandmark9.landmarkDescription = @"Located near the National Mall, along Cherry Tree Walk. The memorial features four outdoor rooms, each one representing one of his four terms. There is also a 10-foot statue of the former President in a wheelchair. Roosevelt was the 32nd President and came into office during the Great Depression.";
    newLandmark9.landmarkLat = @"38.883200";
    newLandmark9.landmarkLong = @"-77.042815";
    newLandmark9.landmarkImageName = @"dcFDR.jpg";
    newLandmark9.landmarkStreet = @"1850 W Basin Drive";
    newLandmark9.landmarkCity = @"Washington";
    newLandmark9.landmarkState = @"DC";
    newLandmark9.landmarkZip = @"20024";
    newLandmark9.landmarkWebsite = @"http://www.nps.gov/frde/index.htm";
    newLandmark9.landmarkPhone = @"(202)426-6841";



    Landmarks *newLandmark10 = (Landmarks *)[NSEntityDescription insertNewObjectForEntityForName:@"Landmarks" inManagedObjectContext:_managedObjectContext];

    newLandmark10.landmarkName = @"Jefferson Memorial";
    newLandmark10.landmarkDescription = @"Honoring the former President's life and his contribution to the United States, a 19-foot bronze statue of Thomas Jefferson surrounded by his most famous writings stands as the centerpiece of the memorial.";
    newLandmark10.landmarkLat = @"38.879889";
    newLandmark10.landmarkLong = @"-77.036519";
    newLandmark10.landmarkImageName = @"dcJeffMem.jpg";
    newLandmark10.landmarkStreet = @"13 E Basin Dr SW";
    newLandmark10.landmarkCity = @"Washington";
    newLandmark10.landmarkState = @"DC";
    newLandmark10.landmarkZip = @"20242";
    newLandmark10.landmarkWebsite = @"http://www.nps.gov/thje/index.htm";
    newLandmark10.landmarkPhone = @"(202)426-6841";


    [_appDelegate saveContext];
}







#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _appDelegate.landmarksArray = [_appDelegate fetchLandmarks];

    


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpLocationMonitoring];
    _landmarksArray = [_appDelegate fetchLandmarks];
//    [self tempAddLandmarks];
    NSLog(@"count:%li",_appDelegate.landmarksArray.count);
    [self annotateMapLocations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
