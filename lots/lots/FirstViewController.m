//
//  FirstViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property(nonatomic, strong) UIImageView *titleView;
@property(nonatomic, strong) UIBarButtonItem *checkInBarButton;

@end

@implementation FirstViewController

NSString *const LSAllLotsArchiveString = @"LSAllLotsArchieveString";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Explore", @"explore tab");
        self.tabBarItem.image = [UIImage imageNamed:@"magnifier"];

        @try {
    		NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                          NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"Scan Data Archive String: %@", LSAllLotsArchiveString);
			NSString *archivePath = [documentsDir stringByAppendingPathComponent:LSAllLotsArchiveString];
			lotArray = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
		}
		@catch (...)
		{
            NSLog(@"Exception unarchiving file.");
    	}
        
        if (!lotArray) {
			lotArray = [[NSMutableArray alloc] init];
        }
//        NSLog(@"Lot Array: %@", lotArray);
        [self setupStrings];
//        self.lotExploreTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//        self.lotExploreTable.separatorColor = [UIColor greenColor];
        self.mapController = [[MapLotViewController alloc] initWithNibName:@"MapLotViewController" bundle:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(locationUpdated)
                                                    name:LSLocationManagerDidUpdateLocationNotification
                                                  object:nil];
    }
    return self;
}

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupHUD];
    // Add Pull to refresh to Table View
    [self addPullToRefreshHeader];
    [self addLeftSwipeGesture];

    [self addCheckInButton];
    
    [self checkShouldShowFooterView];
    
    UIImage *navCenter = [UIImage imageNamed:@"navCenter"];
    _titleView = [[UIImageView alloc] initWithImage:navCenter];
    [self.navigationController.navigationBar.topItem setTitleView:_titleView];
    
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:0.9];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = 1;
    [_titleView.layer addAnimation:pulseAnimation forKey:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void) addCheckInButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"yellow_button_line"];
    UIImage *buttonImageSelected = [UIImage imageNamed:@"yellow_button_line_selected"];
    
    UIButton *checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkInButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [checkInButton setBackgroundImage:buttonImageSelected forState:UIControlStateHighlighted];

    checkInButton.frame = CGRectMake(buttonImage.size.width/2, buttonImage.size.height/2, buttonImage.size.width, buttonImage.size.height);
    
    [checkInButton addTarget:self action:@selector(checkInSelected)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    _checkInBarButton = [[UIBarButtonItem alloc]
                                         initWithCustomView:checkInButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    // Note: We use 5 above b/c that's how many pixels of padding iOS seems to add
    
    // Add the two buttons together on the left:
    self.navigationItem.rightBarButtonItems = [NSArray
                                               arrayWithObjects: negativeSpacer, _checkInBarButton, nil];
    
    
}

-(void) checkInSelected
{
    SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    [self presentViewController:navCont animated:YES completion:nil];
}

- (void)deviceDidRotate:(NSNotification *)notification
{
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    double rotation = 0;
    UIInterfaceOrientation statusBarOrientation;
    switch (currentOrientation) {
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationUnknown:
            return;
        case UIDeviceOrientationPortrait:
//            if ([self.view.window viewWithTag:100]) {
//                [self.mapView removeFromSuperview];
//            }else {
//                return;
//            }
            
//            [self presentViewController:self.mapController animated:NO completion:nil];
//            if (!self.presentedViewController) {
//                return;
//            }
            if ([self.presentedViewController isKindOfClass:[MapLotViewController class]]) {
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
            }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            break;
        case UIDeviceOrientationLandscapeLeft:
            rotation = M_PI_2;
            statusBarOrientation = UIInterfaceOrientationLandscapeRight;

////            [self.mapView setFrame:self.view.window.bounds];
//            if (![self.view.window viewWithTag:100]) {
//                [self.view.window addSubview:self.mapView];
//            }else {
//                return;
//            }
//            if (![self.presentedViewController isKindOfClass:[CheckInViewController class]]) {
            if (!self.presentedViewController) {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
                [self.navigationController setNavigationBarHidden:YES animated:NO];
                [self presentViewController:self.mapController animated:NO completion:nil];
            }

            break;
        case UIDeviceOrientationLandscapeRight:
            rotation = -M_PI_2;
            statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
//            [self.mapView setFrame:self.view.window.bounds];
//            if (![self.view.window viewWithTag:100]) {
//                [self.view.window addSubview:self.mapView];
//            }
//            if (![self.presentedViewController isKindOfClass:[CheckInViewController class]]) {
            if (!self.presentedViewController) {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
                [self.navigationController setNavigationBarHidden:YES animated:NO];
                [self presentViewController:self.mapController animated:NO completion:nil];
            }

            break;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        [self.mapView setTransform:transform];
//        [self.mapView setFrame:self.view.window.bounds];
    } completion:^(BOOL finished) {
//        [self plotLotPositions];
    }];
}

- (void)plotLotPositions {
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if (annotation != self.mapView.userLocation) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    NSLog(@"Lot info: %@", [[lotArray objectAtIndex:0] description]);

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[lotArray objectAtIndex:0] latitude];
    zoomLocation.longitude= [[lotArray objectAtIndex:0] longitude];
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    CLLocationCoordinate2D coordinate;
    for (ExploreLots *tempLot in lotArray) {
        coordinate.latitude = tempLot.latitude;
        coordinate.longitude = tempLot.longitude;
        LotAnnotation *annotation = [[LotAnnotation alloc] initWithName:tempLot.name address:nil coordinate:coordinate] ;
        [self.mapView addAnnotation:annotation];
    }
//    [self.mapView setShowsUserLocation:YES];
}

- (void) locationUpdated
{
    [self refreshLots];
    self.mapController.lotArray = lotArray;
}

- (void) refreshLots
{
    [ExploreLots globalExploreLotsWithBlock:^(NSArray *lots, NSError *error) {
       
        if (!error) {
            [lotArray removeAllObjects];
            for( NSObject *lot in lots ) {
//                NSLog(@"Object description: %@", [lot description]);
                [lotArray addObject:lot];
            }
            [[self lotExploreTable] reloadData];
            [self checkShouldShowFooterView];

            // Save our new scans out to the archive file
            NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                          NSUserDomainMask, YES) objectAtIndex:0];
            NSString *archivePath = [documentsDir stringByAppendingPathComponent:LSAllLotsArchiveString];
            [NSKeyedArchiver archiveRootObject:lotArray toFile:archivePath];
        }
        
        [self performSelector:@selector(closeHUDDisplay) withObject:nil afterDelay:2.0];
    }];
}

-(void) checkShouldShowFooterView
{
    if (lotArray.count == 0) {
        self.lotExploreTable.tableFooterView = self.lotFooterView;
        [_checkInBarButton setEnabled:NO];
//        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else {
        self.lotExploreTable.tableFooterView = nil;
        [_checkInBarButton setEnabled:YES];
    }
}

-(void) setupHUD
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    
    _HUD.labelText = @"Loading Parking Lots...";
    _HUD.square = YES;
    
    [_HUD show:YES];
}

-(void) addLeftSwipeGesture
{
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selectRightTab)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.lotExploreTable addGestureRecognizer:leftGesture];
}

-(void) selectRightTab
{
//    [self.tabBarController setSelectedIndex:self.tabBarController.selectedIndex + 1];
    
    // Get the views.
    UIView * fromView = self.tabBarController.selectedViewController.view;
    UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:self.tabBarController.selectedIndex+1] view];
    
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = self.tabBarController.selectedIndex+1 > self.tabBarController.selectedIndex;
    
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];
    
    // Position it off screen.
    toView.frame = CGRectMake((scrollRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
    
    [UIView animateWithDuration:0.3
                     animations: ^{
                         
                         // Animate the views on and off the screen. This will appear to slide.
                         fromView.frame =CGRectMake((scrollRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                         toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             self.tabBarController.selectedIndex = self.tabBarController.selectedIndex+1;
                         }
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeHUDDisplay {
    [_HUD show:NO];
    [_HUD removeFromSuperview];
    // Tell the tablview to stop loading
    [self stopLoading];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.lotExploreTable.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.lotExploreTable.contentInset;
    tableContentInset.top = 0.0;
    self.lotExploreTable.contentInset = tableContentInset;
    [_refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    _refreshLabel.text = self.textPull;
    _refreshArrow.hidden = NO;
    [_refreshSpinner stopAnimating];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.lotExploreTable.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.lotExploreTable.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            _refreshLabel.text = self.textRelease;
            [_refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            _refreshLabel.text = self.textPull;
            [_refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.lotExploreTable.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    _refreshLabel.text = self.textLoading;
    _refreshArrow.hidden = YES;
    [_refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh View of Parking Lots
//    [self refreshLots];
    [[LocationManager sharedLocationManager] startUpdates];
}

- (void)setupStrings{
    _textPull = @"Pull down to refresh...";
    _textRelease = @"Release to refresh...";
    _textLoading = @"Loading...";
}

- (void)addPullToRefreshHeader {
    _refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    _refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    _refreshLabel.backgroundColor = [UIColor clearColor];
    _refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    _refreshLabel.textAlignment = NSTextAlignmentCenter;
    
//    _refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_icon"]];
    _refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_icon_solid"]];
    
    _refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 35) / 2),
                                     _refreshArrow.frame.size.width, _refreshArrow.frame.size.height);
    
    _refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    _refreshSpinner.hidesWhenStopped = YES;
    
    [_refreshHeaderView addSubview:_refreshLabel];
    [_refreshHeaderView addSubview:_refreshArrow];
    [_refreshHeaderView addSubview:_refreshSpinner];
    [self.lotExploreTable addSubview:_refreshHeaderView];
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Array Count: %i", [lotArray count]);
	return [lotArray count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSExploreCell"];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"LSExploreCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	// Get the barcodeResult that has the data backing this cell
    //	NSMutableDictionary *scanSession = [scanHistory objectAtIndex:indexPath.section];
    //	ZXResult *barcode = [scanHistory objectAtIndex:indexPath.row];
    ExploreLots *exLots = [lotArray objectAtIndex:indexPath.row];
//    NSLog(@"Lot Name: %@", exLots.name);
    cell.textLabel.text = exLots.name;
    cell.detailTextLabel.text = [[NSNumber numberWithFloat:exLots.averageOccupancy] stringValue];
    [cell setBackgroundColor:[UIColor colorWithRed:0.8784313725 green:0.8784313725 blue:0.7764705882 alpha:1.0]];
	
    return cell;
}
*/

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    LotDetailViewController *detailViewController = [[LotDetailViewController alloc] initWithNibName:@"LotDetailViewController" withLot:[lotArray objectAtIndex:[indexPath row]]];

    [self.navigationController pushViewController:detailViewController animated:YES];
    
}
*/
/*
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    static UIView *footerView;
    
    // Don't do anything if the footerview is already set
    if (!footerView) {
        if (lotArray.count == 0) {
            if (footerView != nil) {
                self.lotExploreTable.tableFooterView = footerView;
            }else {
                
                NSString *footerText = @"No parking lots found, create one!";
                
                footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.lotExploreTable.frame.size.width, 44.0f)];
                
                float padding = 10.0f; // an arbitrary amount to center the label in the container
                
                footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                
                // create the label centered in the container, then set the appropriate autoresize mask
                UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, self.lotExploreTable.frame.size.width - 2.0f * padding, 44.0f)];
                [footerLabel setBackgroundColor:[UIColor clearColor]];
                [footerLabel setTextColor:[UIColor whiteColor]];
                [footerLabel setFont:[UIFont fontWithName:@"Palatino-Bold" size:16.0f]];
                
                footerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                footerLabel.textAlignment = NSTextAlignmentCenter;
                footerLabel.text = footerText;
                
                [footerView addSubview:footerLabel];
                self.lotExploreTable.tableFooterView = footerView;
            }
        }
    }
    return nil;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSExploreLotCell *customCell = (LSExploreLotCell *)[tableView dequeueReusableCellWithIdentifier:@"LSExploreCell"];
    if (customCell == nil) {
        customCell = [[LSExploreLotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LSExploreCell"];
        NSArray *topLevel;
        topLevel = [[NSBundle mainBundle] loadNibNamed:@"LSExploreLotCell" owner:self options:nil];
        for (id currentObject in topLevel) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                customCell = (LSExploreLotCell *) currentObject;
                break;
            }
        }
    }
    
    [customCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    customCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ExploreLots *exLots = [lotArray objectAtIndex:indexPath.row];
    //    NSLog(@"Lot Name: %@", exLots.name);
    customCell.lotName.text = exLots.name;
    if (exLots.estimatedOccupancy != 0) {
        customCell.lotOccupancy.text = [NSString stringWithFormat:@"%@%%",[[NSNumber numberWithFloat:exLots.estimatedOccupancy] stringValue]];
    }else {
        customCell.lotOccupancy.text = [NSString stringWithFormat:@"N/A"];
    }
    customCell.lotDistance.text = [NSString stringWithFormat:@"%.2f mi", (exLots.distance * 0.621371)];
//    cell.detailTextLabel.text = [[NSNumber numberWithFloat:exLots.averageOccupancy] stringValue];
//    [cell setBackgroundColor:[UIColor colorWithRed:0.8784313725 green:0.8784313725 blue:0.7764705882 alpha:1.0]];
	
    return customCell;
}

@end
