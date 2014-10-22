//
//  
//    ___  _____   ______  __ _   _________ 
//   / _ \/ __/ | / / __ \/ /| | / / __/ _ \
//  / , _/ _/ | |/ / /_/ / /_| |/ / _// , _/
// /_/|_/___/ |___/\____/____/___/___/_/|_| 
//
//  Created by Bart Claessens. bart (at) revolver . be
//

#import "REVMapViewController.h"
#import "REVClusterMap.h"
#import "REVClusterAnnotationView.h"
#import "BasicMapAnnotation.h"
#import "CallOutAnnotationVifew.h"
#import "JingDianMapCell.h"
#import "MapDataModel.h"

#define BASE_RADIUS .5 // = 1 mile
#define MINIMUM_LATITUDE_DELTA 0.20
#define BLOCKS 4

#define MINIMUM_ZOOM_LEVEL 100000
#define PADDING                 10
#define METERS_PER_MILE 8000

@implementation REVMapViewController
@synthesize array,userHeadingBtn;

- (void)dealloc
{
    [_mapView release], _mapView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    //CGRect viewBounds = [[UIScreen mainScreen] applicationFrame];
    CGRect mapViewFrame = [self frameForMappingView];

    _mapView = [[REVClusterMapView alloc] initWithFrame:mapViewFrame];
    _mapView.delegate = self;
   // _mapView.showsUserLocation = TRUE;
    [self.view addSubview:_mapView];
    
    
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 0.0500;
    coordinate.longitude = 37.6500;
    _mapView.region = [[self class] getRegionThatFitsLocations:array];// MKCoordinateRegionMakeWithDistance(coordinate, 8000, 8000);//
    //MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:_mapView];
    //self.navigationItem.leftBarButtonItem = buttonItem;
    [self setAnnotionsWithList:array];


    MKCoordinateRegion mapRegion;
    mapRegion.center = _mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [_mapView setRegion:mapRegion animated: YES];
    
    
    //User Heading Button states images
    UIImage *buttonImage = [UIImage imageNamed:@"greyButtonHighlight.png"];
    UIImage *buttonImageHighlight = [UIImage imageNamed:@"greyButton.png"];
    UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
    
    //Configure the button
    userHeadingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userHeadingBtn addTarget:self action:@selector(startShowingUserHeading:) forControlEvents:UIControlEventTouchUpInside];
    //Add state images
    [userHeadingBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [userHeadingBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [userHeadingBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [userHeadingBtn setImage:buttonArrow forState:UIControlStateNormal];
    
    //Position and Shadow
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    userHeadingBtn.frame = CGRectMake(5,screenBounds.size.height-145,39,30);
    userHeadingBtn.frame = CGRectMake(screenBounds.size.width - 35,330,39,30);
    userHeadingBtn.layer.cornerRadius = 8.0f;
    userHeadingBtn.layer.masksToBounds = NO;
    userHeadingBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    userHeadingBtn.layer.shadowOpacity = 0.8;
    userHeadingBtn.layer.shadowRadius = 1;
    userHeadingBtn.layer.shadowOffset = CGSizeMake(0, 1.0f);
    
    [_mapView addSubview:userHeadingBtn];

}

+ (MKCoordinateRegion) getRegionThatFitsLocations:(NSArray *)locations {
    // initialize to minimums, maximums
    CLLocationDegrees minLatitude = 90;
    CLLocationDegrees maxLatitude = -90;
    CLLocationDegrees minLongitude = 180;
    CLLocationDegrees maxLongitude = -180;
    
    // establish the min and max latitude and longitude
    // of all the locations in the array
    for (MapDataModel *location in locations) {
        CLLocationDegrees latitude=[location.latitude doubleValue];
        CLLocationDegrees longitude=[location.longitude doubleValue];
        //rev
        

        if (latitude < minLatitude) {
            minLatitude = latitude;
        }
        if (latitude > maxLatitude) {
            maxLatitude = latitude;
        }
        if (longitude < minLongitude) {
            minLongitude = longitude;
        }
        if (longitude > maxLongitude) {
            maxLongitude = longitude;
        }
    }
    
    MKCoordinateSpan span;
    CLLocationCoordinate2D center;
    if ([locations count] > 1) {
        // for more than one location, the span is the diff between
        // min and max latitude and longitude
        span =  MKCoordinateSpanMake(maxLatitude - minLatitude, maxLongitude - minLongitude);
        // and the center is the min + the span (width) / 2
        center.latitude = minLatitude + span.latitudeDelta / 2;
        center.longitude = minLongitude + span.longitudeDelta / 2;
    } else {
        // for a single location make a fixed size span (pretty close in zoom)
        span =  MKCoordinateSpanMake(0.01, 0.01);
        // and the center equal to the coords of the single point
        // which will be the coords of the min (or max) coords
        center.latitude = minLatitude;
        center.longitude = minLongitude;
    }
    
    // create a region from the center and span
    return MKCoordinateRegionMake(center, span);
}


- (CGRect)frameForMappingView {
    CGRect frame = self.view.bounds;// [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}

-(void)setAnnotionsWithList:(NSMutableArray *)list
{
    //int i=0;
    NSMutableArray *pins = [NSMutableArray array];
    
    for (MapDataModel *dic in list) {
        
        CLLocationDegrees latitude= [[dic valueForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude= [[dic valueForKey:@"longitude"] doubleValue];
        //rev
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        
                
        MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location,METERS_PER_MILE ,METERS_PER_MILE );
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:YES];
        
        BasicMapAnnotation *  annotation=[[BasicMapAnnotation alloc] initWithLatitude:latitude andLongitude:longitude];
        
        [pins addObject:annotation];

        
    }
    [_mapView   addAnnotations:pins];
    
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark -
#pragma mark Map view delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation class] == MKUserLocation.class) {
		//userLocation = annotation;
		return nil;
	}

    REVClusterPin *pin = (REVClusterPin *)annotation;
    
    MKAnnotationView *annView;

    if( [pin nodeCount] > 0 ){
        pin.title = @"___";
        
        annView = (REVClusterAnnotationView*)
        [mapView dequeueReusableAnnotationViewWithIdentifier:@"cluster"];
        
        if( !annView )
            annView = (REVClusterAnnotationView*)
            [[[REVClusterAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:@"cluster"] autorelease];
        
        annView.image = [UIImage imageNamed:@"cluster.png"];
        
        [(REVClusterAnnotationView*)annView setClusterText: [NSString stringWithFormat:@"%i",[pin nodeCount]]];
        
        annView.canShowCallout = NO;
        return annView;

    } else {
        
        if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
            
            CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
            if (!annotationView) {
                annotationView = [[[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"] autorelease];
                JingDianMapCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"JingDianMapCell" owner:self options:nil] objectAtIndex:0];
                [annotationView.contentView addSubview:cell];

                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                [rightButton addTarget:self
                                action:@selector(showDetails:)
                      forControlEvents:UIControlEventTouchUpInside];
                annotationView.rightCalloutAccessoryView = rightButton;
                [annotationView addSubview:rightButton];

            }
            return annotationView;
        } else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
            
            MKAnnotationView *annotationView =[_mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
            if (!annotationView) {
                annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation
                                                               reuseIdentifier:@"CustomAnnotation"] autorelease];
                annotationView.canShowCallout = NO;
                annotationView.image = [UIImage imageNamed:@"pin.png"];
            }
            
            return annotationView;
        }
    }
    return nil;
    
    
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"REVMapViewController mapView didSelectAnnotationView:");
    if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (_calloutAnnotation) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
        _calloutAnnotation = [[[CalloutMapAnnotation alloc]
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude] autorelease];
        [mapView addAnnotation:_calloutAnnotation];
        
        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
	}
    else{
       // if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
       //     [delegate customMKMapViewDidSelectedWithInfo:@"点击至之后你要在这干点啥"];
       // }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_calloutAnnotation&& ![view isKindOfClass:[CallOutAnnotationVifew class]]) {
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutAnnotation];
            _calloutAnnotation = nil;
        }
    }
}



-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"inside the stupid method");
}

- (void)showDetails:(id)sender
{
    // the detail view does not want a toolbar so hide it
//    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    //enquire.passedDataItem = [self.dataController objectInListAtIndex:indexPath.section];
    
    //[self.view addSubview:enquire.view];
    
}

/*
-(void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
}
*/

#pragma mark User Heading
- (IBAction) startShowingUserHeading:(id)sender{
    
    if(_mapView.userTrackingMode == 0){
       [_mapView setUserTrackingMode: MKUserTrackingModeFollow animated: YES];
        
        //Turn on the position arrow
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationBlue.png"];
        [userHeadingBtn setImage:buttonArrow forState:UIControlStateNormal];
        
    }
    else if(_mapView.userTrackingMode == 1){
        [_mapView setUserTrackingMode: MKUserTrackingModeFollowWithHeading animated: YES];
        
        //Change it to heading angle
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationHeadingBlue"];
        [userHeadingBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    else if(_mapView.userTrackingMode == 2){
       [_mapView setUserTrackingMode: MKUserTrackingModeNone animated: YES];
        
        //Put it back again
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
        [userHeadingBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    
    
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    if(_mapView.userTrackingMode == 0){
       [_mapView setUserTrackingMode: MKUserTrackingModeNone animated: YES];
        
        //Put it back again
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
        [userHeadingBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = _mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [_mapView setRegion:mapRegion animated: YES];
}
/*
 case 0: { // Zoom In
 //NSLog(@"Zoom - IN");
 MKCoordinateRegion region;
 //Set Zoom level using Span
 MKCoordinateSpan span;
 region.center=mapView.region.center;
 
 span.latitudeDelta=mapView.region.span.latitudeDelta /2.0002;
 span.longitudeDelta=mapView.region.span.longitudeDelta /2.0002;
 region.span=span;
 [mapView setRegion:region animated:TRUE];
 }
 break;
 
 // Zoom Out
 case 2: {
 //NSLog(@"Zoom - OUT");
 MKCoordinateRegion region;
 //Set Zoom level using Span
 MKCoordinateSpan span;
 region.center=mapView.region.center;
 span.latitudeDelta=mapView.region.span.latitudeDelta *2;
 span.longitudeDelta=mapView.region.span.longitudeDelta *2;
 region.span=span;
 [mapView setRegion:region animated:TRUE];
 }
*/
@end
