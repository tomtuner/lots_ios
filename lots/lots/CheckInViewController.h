//
//  CheckInViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/12/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ExploreLots.h"
#import "LotAnnotation.h"
#import "CheckInLot.h"

#define METERS_PER_MILE 1609.344

@interface CheckInViewController : UIViewController

@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) IBOutlet UINavigationBar *navBar;
@property(nonatomic, strong) ExploreLots *lot;

@property(nonatomic, strong) IBOutlet UIButton *checkInButton;
@property(nonatomic, strong) IBOutlet UIButton *fullButton;
@property(nonatomic, strong) IBOutlet UIButton *emptyButton;
@property(nonatomic, strong) IBOutlet UIButton *halfButton;
@property(nonatomic, strong) IBOutlet UIButton *quarterFullButton;
@property(nonatomic, strong) IBOutlet UIButton *eightyFiveFullButton;

@end
