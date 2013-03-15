//
//  MapLotViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/15/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ExploreLots.h"
#import "CheckInViewController.h"

@interface MapLotViewController : UIViewController

@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) NSMutableArray *lotArray;

@end
