//
//  
//    ___  _____   ______  __ _   _________ 
//   / _ \/ __/ | / / __ \/ /| | / / __/ _ \
//  / , _/ _/ | |/ / /_/ / /_| |/ / _// , _/
// /_/|_/___/ |___/\____/____/___/___/_/|_| 
//
//  Created by Bart Claessens. bart (at) revolver . be
//

#import <UIKit/UIKit.h>
#import "REVClusterMapView.h"
#import "CalloutMapAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface REVMapViewController : UIViewController <MKMapViewDelegate> {
    REVClusterMapView *_mapView;
    
    CalloutMapAnnotation *_calloutAnnotation;
	CalloutMapAnnotation *_previousdAnnotation;
    NSMutableArray *array;

}

-(void)setAnnotionsWithList:(NSArray *)list;
- (CGRect)frameForMappingView;

@property(copy, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UIButton *userHeadingBtn;

+ (MKCoordinateRegion) getRegionThatFitsLocations:(NSArray *)locations;
@end
