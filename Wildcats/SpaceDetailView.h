//
//  SpaceDetailView.h
//  Wildcats
//
//  Created by Piet Brauer on 06.04.11.
//  Copyright 2011 nerdish by nature. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
    NSString *mTitle;
    NSString *mSubTitle;
    
}
@property (nonatomic, strong) NSString *mTitle;
@property (nonatomic, strong) NSString *mSubTitle;

@end

@interface SpaceDetailView : UIViewController {
    IBOutlet MKMapView *mapView;
    AddressAnnotation *addAnnotation;
    NSString *address;
}

- (void)showAddress;

-(CLLocationCoordinate2D) addressLocation;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) AddressAnnotation *addAnnotation;
@property (nonatomic, strong) NSString *address;


@end
