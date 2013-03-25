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

@property (nonatomic, strong) CLLocation* initialLocation;

@end

@implementation CreateLotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Add New Lot", @"create tab");
        self.tabBarItem.image = [UIImage imageNamed:@"flag"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        UIBarButtonItem *sAddButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addClicked)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *navCenter = [UIImage imageNamed:@"navCenter"];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:navCenter];
    [self.navigationController.navigationBar.topItem setTitleView:titleView];
    
    /*
    WildcardGestureRecognizer *mapClick = [[WildcardGestureRecognizer alloc] init];
    //        mapClick.delegate = self;
    //        mapClick.numberOfTapsRequired = 1;
    //        mapClick.numberOfTouchesRequired = 1;
    mapClick.touchesBeganCallback = ^(NSSet *touches, UIEvent *event) {
        //            self.lockedOnUserLocation = NO;
        NSLog(@"Touch?");
    };*/
    
    UITapGestureRecognizer *mapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewSelected:)];
    
    [self.mapView addGestureRecognizer:mapClick];
    
    [self.mapView.layer setCornerRadius:5.0f];
    [self.mapView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.mapView.layer setBorderWidth:1.0f];
    [self.mapView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.mapView.layer setShadowOpacity:0.8];
    [self.mapView.layer setShadowRadius:3.0];
    [self.mapView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

-(void) addClicked
{
    NSLog(@"Add Clicked");
}
/*
-(void) touchesBegan :(NSSet *) touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog(@"%@",[[[[touch view] subviews] objectAtIndex:0] description]);
    if ([[touch view] isKindOfClass:[MKMapView class]])
    {
        //rest of my code
        NSLog(@"map Map MAP");
    }
    
    [super touchesBegan:touches withEvent:event ];
}
*/
/*
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
 */
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
        return @"Add A Parking Lot";
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
