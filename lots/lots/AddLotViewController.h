//
//  AddLotViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/25/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LotAnnotation.h"
#import "ExploreLots.h"

@interface AddLotViewController : UIViewController

@property(nonatomic, strong) ExploreLots *lot;

@property (nonatomic, strong) CLLocation *initialLocation;

@end
