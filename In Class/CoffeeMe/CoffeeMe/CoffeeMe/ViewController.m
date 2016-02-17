//
//  ViewController.m
//  CoffeeMe
//
//  Created by Blake Oistad on 10/7/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)               CLLocationManager   *locationManager;
@property (nonatomic, weak)     IBOutlet    MKMapView           *coffeeMapView;

@property (nonatomic, weak)     IBOutlet    UISearchBar         *locationSearchBar;
@property (nonatomic, weak)     IBOutlet    UISegmentedControl  *searchTypeSegControl;

@end

@implementation ViewController

#pragma mark - Search Methods


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)segControl {
    NSLog(@"Value Changed");
    switch (_searchTypeSegControl.selectedSegmentIndex) {
        case 0:
            [self appleSearch];                     //allows all of Apples search tools in this search, business name, pizza, etc...
            break;
            
        case 1:                                     //forward search, address to coordinates
            [self addressSearch];
            break;
         
        case 2:
            [self latLongSearch];                   //reverse search, coordinates to address
            break;
        default:
            break;
    }
}

- (void)latLongSearch {
    NSLog(@"LatLongSearch");
    NSArray *coordinateItems = [_locationSearchBar.text componentsSeparatedByString:@","];
    if (coordinateItems.count == 2) {
        float latFloat = [coordinateItems[0] floatValue];
        float longFloat = [coordinateItems[1] floatValue];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:latFloat longitude:longFloat];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks[0];
            NSString *city = [placemark.addressDictionary valueForKey:@"City"];
            NSString *state = placemark.administrativeArea;
            NSString *street = [NSString stringWithFormat:@"%@ %@",placemark.subThoroughfare,placemark.thoroughfare];       //thoroughfare is a street, may not always want it formatted this way as not all places in the world format with street number and then street name
            NSLog(@"%@, %@, %@",street, city, state);
            
            MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
            pa.coordinate = placemark.location.coordinate;
            pa.title = [NSString stringWithFormat:@"%@, %@ %@",street, city, state];
            pa.subtitle = [NSString stringWithFormat:@"Lat/Long Search: %f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
            [_coffeeMapView addAnnotation:pa];
            [self zoomToPins];

        }];
    }
}

- (void)addressSearch {
    NSLog(@"Address Search");
    [_locationSearchBar resignFirstResponder];                      //hides keyboard once addresssegcontol button is pressed
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_locationSearchBar.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        NSString *city = [placemark.addressDictionary valueForKey:@"City"];
        NSString *state = placemark.administrativeArea;
        NSString *street = [NSString stringWithFormat:@"%@ %@",placemark.subThoroughfare,placemark.thoroughfare];       //thoroughfare is a street, may not always want it formatted this way as not all places in the world format with street number and then street name
        NSLog(@"%@, %@, %@",street, city, state);
        
        MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
        pa.coordinate = placemark.location.coordinate;
        pa.title = [NSString stringWithFormat:@"%@, %@ %@",street, city, state];
        pa.subtitle = [NSString stringWithFormat:@"Address Search: %f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
        [_coffeeMapView addAnnotation:pa];
        [self zoomToPins];
    }];
}

- (void)appleSearch {
    NSLog(@"Apple Search");
    [_locationSearchBar resignFirstResponder];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = _locationSearchBar.text;
    request.region = [_coffeeMapView region];
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (response.mapItems.count == 0) {
            NSLog(@"Got Nothing");                  //probably pop up message that tells user nothing came up
        } else {
            for (MKMapItem *item in response.mapItems) {
                MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                pa.coordinate = item.placemark.location.coordinate;
                pa.title = item.name;
                pa.subtitle = [NSString stringWithFormat:@"Apple Search: %f, %f",item.placemark.location.coordinate.latitude,item.placemark.location.coordinate.longitude];
                [_coffeeMapView addAnnotation:pa];
            }
        }
    }];
}



#pragma mark - Annotation Methods



//normally you wouldnt hardcode these in, youd have the data coming from another source and put it into a loop to fill an array
- (void)annotateMapLocations {
    NSMutableArray *pinsToRemove = [[NSMutableArray alloc] init];          //this will be a loop that will go through the current array of annotations and remove them before new ones are placed in
    for (id <MKAnnotation> annot in [_coffeeMapView annotations]) {
        if ([annot isKindOfClass:[MKPointAnnotation class]]) {             //this checks to make sure the type of annotation is a pin, since user location is not a pin, it will not get added to the array pinsToRemove of pins to remove
            [pinsToRemove addObject:annot];
        }
    }
    [_coffeeMapView removeAnnotations:pinsToRemove];
    
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = CLLocationCoordinate2DMake(39, -77);
    pa.title = @"Silver Spring, MD";
    pa.subtitle = @"This is where you live right now";
//    [_coffeeMapView addAnnotation:pa];                        adds the single pin, the line below allows you to add all annotations at once
    MKPointAnnotation *pa2 = [[MKPointAnnotation alloc] init];
    pa2.coordinate = CLLocationCoordinate2DMake(44, -80);
    pa2.title = @"Pin 2";
    
    MKPointAnnotation *pa3 = [[MKPointAnnotation alloc] init];
    pa3.coordinate = CLLocationCoordinate2DMake(42, -85);
    pa3.title = @"Here is a much longer title breh breh breh breh";
    
    [_coffeeMapView addAnnotations:@[pa,pa2,pa3]];                //this adds all annotations
}




#pragma mark - Map Methods


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Tapped");
    //perfrom segue here
    
}

- (void)zoomToLocationWithLat:(float)latitude andLon:(float)longitude andDiameter:(float)diameter {
    if (latitude == 0 && longitude == 0) {
        NSLog(@"You gave me bad data");
    } else {
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = latitude;
        zoomLocation.longitude = longitude;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, diameter, diameter);
        MKCoordinateRegion adjustedRegion = [_coffeeMapView regionThatFits:viewRegion];                         //gets us the surrounding mapping around the square region defined in line above
        [_coffeeMapView setRegion:adjustedRegion animated:true];                                                //exectues the zoom feature, changes the region of the map
    }
}

- (void)zoomToPins {
    [_coffeeMapView showAnnotations:[_coffeeMapView annotations] animated:true];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {             //equivalent in maps for cellForRowAtIndexPath
    if (annotation != mapView.userLocation) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        }
        annotationView.canShowCallout = true;                                                                   //enables showing callouts when pins are tapped
        annotationView.animatesDrop = true;
        annotationView.pinTintColor = [UIColor blackColor];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
    return nil;
}

- (IBAction)mapLongPressed:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {                     //stops it from continuously logging the long press, only logs it when finger is lifted
         NSLog(@"Long Press");
        CGPoint point = [gestureRecognizer locationInView:_coffeeMapView];           //gives us point in mapview coordinates (X,Y)
        CLLocationCoordinate2D pointCoord = [_coffeeMapView convertPoint:point toCoordinateFromView:_coffeeMapView];  //gives us point in lat, long from above x, y
        MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
        pa.coordinate = pointCoord;
        pa.title = [NSString stringWithFormat:@"Long Press:%f,%f",pointCoord.latitude,pointCoord.longitude];
        [_coffeeMapView addAnnotation:pa];
    }
   
}




#pragma mark - Location Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.lastObject;
    NSLog(@"lat:%f long:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
    [self zoomToPins];                                                                                                                //zooms to pins
//    [self zoomToLocationWithLat:currentLocation.coordinate.latitude andLon:currentLocation.coordinate.longitude andDiameter:3300];      //zooms to user location with diameter of 3300 meters
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Enter Region");
    if ([[region identifier] isEqualToString:@"Home"]) {
        NSLog(@"Did Enter Home");
        [_locationManager stopMonitoringForRegion:region];
    }
}


- (void)turnOnLocationMonitoring {
    [_locationManager startUpdatingLocation];
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(38.905938, -77.041997) radius:150 identifier:@"Home"];
    [_locationManager startMonitoringForRegion:region];
    _coffeeMapView.showsUserLocation = true;
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
                NSLog(@"Hey User, Turn us Back On!");
                break;
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"Hey User, Turn on Location Services in Settings");
                if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [_locationManager requestWhenInUseAuthorization];
                }
                
                break;
            case kCLAuthorizationStatusRestricted:
                
                break;
                
            default:
                break;
        }
    } else {
        NSLog(@"Turn On Location Services in Settings");   //send user a message telling them that, likely an alert
    }
}









#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpLocationMonitoring];
    [self annotateMapLocations];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
