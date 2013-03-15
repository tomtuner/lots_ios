//
//  LotMapViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/15/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LotMapViewController.h"

@interface LotMapViewController ()

@end

@implementation LotMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        self.lotArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self plotLotPositions];
}

- (void)plotLotPositions {
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    NSLog(@"Lot info: %@", [[self.lotArray objectAtIndex:0] description]);
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[self.lotArray objectAtIndex:0] latitude];
    zoomLocation.longitude= [[self.lotArray objectAtIndex:0] longitude];
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    CLLocationCoordinate2D coordinate;
    for (ExploreLots *tempLot in self.lotArray) {
        coordinate.latitude = tempLot.latitude;
        coordinate.longitude = tempLot.longitude;
        LotAnnotation *annotation = [[LotAnnotation alloc] initWithName:tempLot.name address:nil coordinate:coordinate] ;
        [self.mapView addAnnotation:annotation];
    }
    [self.view addSubview:self.mapView];
    //    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
