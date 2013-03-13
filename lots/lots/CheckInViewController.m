//
//  CheckInViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/12/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()

@property(nonatomic, strong) NSArray *buttonArray;

@end

@implementation CheckInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _buttonArray = @[self.fullButton, self.halfButton, self.quarterFullButton, self.emptyButton, self.eightyFiveFullButton];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.lot.latitude;
    zoomLocation.longitude= self.lot.longitude;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.2*METERS_PER_MILE, 0.2*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    [self plotLotPosition];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _buttonArray = @[self.fullButton, self.halfButton, self.quarterFullButton, self.emptyButton, self.eightyFiveFullButton];

    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(dismissView)];
    self.navigationItem.title = self.lot.name;
    [self.navBar pushNavigationItem:self.navigationItem animated:NO];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    [self setupButtons];
}

-(void) setupButtons
{
    [self disableCheckInButton];

    for (UIButton *tempButton in _buttonArray) {
        tempButton.selected = NO;
        //            [tempButton setTintColor:[UIColor greenColor]];
        [tempButton setBackgroundColor:[UIColor greenColor]];
    }
}

-(IBAction)lotOccupancySelected:(id)sender
{
    [self enableCheckInButton];
    UIButton *selected = (UIButton *)sender;
    for (UIButton *tempButton in _buttonArray) {
        if (selected.tag != tempButton.tag) {
            tempButton.selected = NO;
//            [tempButton setTintColor:[UIColor greenColor]];
            [tempButton setBackgroundColor:[UIColor greenColor]];
        }else {
            tempButton.selected = YES;
            [tempButton setBackgroundColor:[UIColor grayColor]];
//            [tempButton setTintColor:[UIColor grayColor]];
        }
    }
}

-(IBAction)checkInSelected
{
    UIButton *currentButton;
    for (UIButton *tempButton in _buttonArray) {
        if (tempButton.isSelected) {
            currentButton = tempButton;
            break;
        }
    }
    NSLog(@"Current Button Tag: %i", currentButton.tag);
    int occupancySelected = currentButton.tag;
    
    [CheckInLot globalCheckInToLotWithLotID:self.lot.lotID withOccupancy:occupancySelected withBlock:^(NSArray *lot, NSError *error) {
        if (!error) {
            [self dismissView];
        }
    }];
}

-(void) enableCheckInButton
{
    [self.checkInButton setAlpha:1.0];
    [self.checkInButton setEnabled:YES];
}
     
-(void) disableCheckInButton
{
    [self.checkInButton setAlpha:0.4];
    [self.checkInButton setEnabled:NO];
}

-(void) dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plotLotPosition {
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.lot.latitude;
    coordinate.longitude = self.lot.longitude;
    LotAnnotation *annotation = [[LotAnnotation alloc] initWithName:self.lot.name address:nil coordinate:coordinate] ;
    [_mapView addAnnotation:annotation];
    
}

@end
