//
//  AddLotViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/25/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "AddLotViewController.h"

@interface AddLotViewController ()

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

@end

@implementation AddLotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Locate on Map", @"locate on map");

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *mapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.mapView addGestureRecognizer:mapClick];
    NSLog(@"Lot Name: %@", self.lot.name);
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(addLotMapController:lotAnnotation:)])
        {
            LotAnnotation *tempAnnotation;
            for (id<MKAnnotation> annotation in self.mapView.annotations) {
                if ([annotation isKindOfClass:[LotAnnotation class]]) {
                    tempAnnotation = annotation;
                    break;
                }
            }
            if (tempAnnotation) {
                [self.delegate addLotMapController:self lotAnnotation:tempAnnotation];
            }
        }
    }
    [super viewWillDisappear:animated];
}

-(void) zoomToInitialLocation
{    
    MKCoordinateRegion region;
    region.center = self.initialLocation.coordinate;
    region.span = MKCoordinateSpanMake(0.003, 0.003);
    
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.initialLocation) {
        [self zoomToInitialLocation];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ( !self.initialLocation)
    {
        self.initialLocation = userLocation.location;
        
        MKCoordinateRegion region;
        region.center = mapView.userLocation.coordinate;
        region.span = MKCoordinateSpanMake(0.003, 0.003);
        
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:YES];
    }
}

- (void)handleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        return;
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if (annotation != self.mapView.userLocation) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    LotAnnotation *annotation = [[LotAnnotation alloc] initWithName:self.lot.name address:nil coordinate:touchMapCoordinate];
    
    [self.mapView addAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    LotAnnotation *tempAnnotation;
    for (MKAnnotationView *annotationView in views) {
        if ([annotationView.annotation isKindOfClass:[LotAnnotation class]]) {
            tempAnnotation = annotationView.annotation;
            break;
        }
    }
    if (tempAnnotation) {
        [self.mapView selectAnnotation:tempAnnotation animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
