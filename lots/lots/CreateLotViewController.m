//
//  CreateLotViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/25/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "CreateLotViewController.h"

@interface CreateLotViewController ()

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UITextField *nameField;

@property (nonatomic, strong) CLLocation *initialLocation;

@property (nonatomic, strong) UIImageView *titleView;

@end

@implementation CreateLotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Create", @"create tab");
        self.tabBarItem.image = [UIImage imageNamed:@"flag"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addClicked)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *navCenter = [UIImage imageNamed:@"navCenter"];
    _titleView = [[UIImageView alloc] initWithImage:navCenter];
    [self.navigationItem setTitleView:_titleView];

    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:0.9];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = 1;
    [_titleView.layer addAnimation:pulseAnimation forKey:nil];
    
    UITapGestureRecognizer *mapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewSelected:)];
    [self.mapView addGestureRecognizer:mapClick];
    
    [self.mapView.layer setCornerRadius:5.0f];
    [self.mapView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.mapView.layer setBorderWidth:1.0f];
//    [self.mapView.layer setShadowColor:[UIColor blackColor].CGColor];
//    [self.mapView.layer setShadowOpacity:0.8];
//    [self.mapView.layer setShadowRadius:3.0];
//    [self.mapView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    UIView *mapOverlayView = [[UIView alloc] initWithFrame:CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width, 44)];
    // set the radius
    CGFloat radius = 5.0;
    // set the mask frame, and increase the height by the
    // corner radius to hide bottom corners
    CGRect maskFrame = mapOverlayView.bounds;
    maskFrame.size.height += radius;
    // create the mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.cornerRadius = radius;
    maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    maskLayer.frame = maskFrame;
    
    // set the mask
    mapOverlayView.layer.mask = maskLayer;
    [mapOverlayView setBackgroundColor:[UIColor blackColor]];
    [mapOverlayView setAlpha:0.8f];
    
    
    
    UILabel *mapOverlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.mapView.frame.size.width - 20, 44)];
    [mapOverlayLabel setBackgroundColor:[UIColor clearColor]];
    [mapOverlayLabel setTextColor:[UIColor whiteColor]];
    [mapOverlayLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    mapOverlayLabel.text = @"Tap the map to locate the lot";
    [mapOverlayView addSubview:mapOverlayLabel];
    
    [self.view addSubview:mapOverlayView];
}

-(void) addClicked
{
    NSLog(@"Add Clicked");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Did Update to Location");
    if ( !self.initialLocation )
    {
        self.initialLocation = userLocation.location;
        
        MKCoordinateRegion region;
        region.center = mapView.userLocation.coordinate;
        region.span = MKCoordinateSpanMake(0.003, 0.003);
        
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:YES];
    }
}

-(void) dismissKeyboard
{
    [self.nameField resignFirstResponder];
}

- (void) mapViewSelected:(UIGestureRecognizer *) gestureRecognizer
{
    NSLog(@"Map Selected");
    ExploreLots *lot = [[ExploreLots alloc] init];
    lot.name = self.nameField.text;
    AddLotViewController *lotController = [[AddLotViewController alloc] initWithNibName:@"AddLotViewController" bundle:nil];
    lotController.lot = lot;
    lotController.initialLocation = self.mapView.userLocation.location;
    NSLog(@"%@", self.mapView.userLocation.location);
    [self.navigationController pushViewController:lotController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"Array Count: %i", [lotArray count]);
//	return [lotArray count];
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Add a Parking Lot";
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {        
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if( cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (indexPath.row == 0) {
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
        self.nameField.placeholder = @"Lot Name";
        self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.nameField setClearButtonMode:UITextFieldViewModeWhileEditing];
        cell.accessoryView = self.nameField ;
    }

    self.nameField.delegate = self;
    
    [tableView addSubview:self.nameField];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;  
}

@end
