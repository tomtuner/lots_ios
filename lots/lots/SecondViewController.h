//
//  SecondViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ExploreLots.h"
#import "FirstViewController.h"
#import "CheckInViewController.h"

@interface SecondViewController : UIViewController {
    BOOL isDragging;
    BOOL isLoading;
    NSMutableArray *lotArray;
}

@property(nonatomic, strong) IBOutlet UICollectionView *lotCollectionView;

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

// Table View properties for pull to refresh
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

// Table View Methods for pull to refresh
- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;

@end
