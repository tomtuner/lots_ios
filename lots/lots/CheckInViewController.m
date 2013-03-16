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

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
//    [ThemeManager customizeButtonWithGrayBackground:self.fullButton];
    [self setupButtons];
    self.mapView.layer.masksToBounds = NO;
    self.mapView.layer.cornerRadius = 3.0f;
    self.mapView.layer.shadowOpacity = 1.0f;
    self.mapView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mapView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.mapView.layer.shadowRadius = 5.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.mapView.bounds];
    self.mapView.layer.shadowPath = path.CGPath;
}

-(void) setupButtons
{
    [self disableCheckInButton];

    for (UIButton *tempButton in _buttonArray) {
        tempButton.selected = NO;
        //            [tempButton setTintColor:[UIColor greenColor]];
//        [tempButton setBackgroundColor:[UIColor greenColor]];
        [tempButton setBackgroundColor:[[ThemeManager sharedTheme] mainGrayColor]];
        tempButton.layer.masksToBounds = NO;
        tempButton.layer.cornerRadius = 3.0f;
        tempButton.layer.shadowOpacity = 1.0f;
        tempButton.layer.shadowColor = [UIColor blackColor].CGColor;
        tempButton.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        tempButton.layer.shadowRadius = 2.0f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:tempButton.bounds];
        tempButton.layer.shadowPath = path.CGPath;
        
        [tempButton.titleLabel setAlpha:1.0f];
        [tempButton setAlpha:0.2f];
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
//            [tempButton setBackgroundColor:[UIColor greenColor]];
            [tempButton setAlpha:0.2f];
            [tempButton.titleLabel setAlpha:1.0f];
        }else {
            tempButton.selected = YES;
//            [tempButton setBackgroundColor:[UIColor grayColor]];
            [tempButton setAlpha:1.0f];
            [tempButton.titleLabel setAlpha:1.0f];
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
            [self dismissViewWithAchievementCheck];
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


-(void) dismissViewWithAchievementCheck
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int count = [defaults integerForKey:@"checkInCount"];
    count++;
    [defaults setInteger:count forKey:@"checkInCount"];
    [defaults synchronize];
    
    if (count == 1 || count == 5 || count == 10) {
        [self dismissViewControllerAnimated:YES completion:^(void) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate showAchievementViewWithCount:count];
        }];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
