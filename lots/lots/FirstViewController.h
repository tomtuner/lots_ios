//
//  FirstViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "AFLotsAPIClient.h"
#import "LocationManager.h"
#import "Notifications.h"
#import "ExploreLots.h"
#import "MBProgressHUD.h"
#import "LotAnnotation.h"
#import "CheckInViewController.h"
#import "LSExploreLotCell.h"
#import "LotDetailViewController.h"
#import "MapLotViewController.h"
#define REFRESH_HEADER_HEIGHT 52.0f

FOUNDATION_EXPORT NSString *const LSAllLotsArchiveString;

@interface FirstViewController : UIViewController {
    BOOL isDragging;
    BOOL isLoading;
    NSMutableArray *lotArray;
}


@property(nonatomic, strong) IBOutlet UITableView *lotExploreTable;

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) MBProgressHUD *HUD;

@property(nonatomic, strong) MapLotViewController *mapController;

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
- (void) closeHUDDisplay;

@end
