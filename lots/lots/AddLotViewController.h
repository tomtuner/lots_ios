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

@class AddLotViewController;

@protocol LSCreateLotDelegate
@required
-(void)addLotMapController:(AddLotViewController *) controller lotAnnotation:(LotAnnotation *) annotation;

@end

@interface AddLotViewController : UIViewController

@property(nonatomic,assign)id delegate;

@property(nonatomic, strong) ExploreLots *lot;

@property (nonatomic, strong) CLLocation *initialLocation;

@end
