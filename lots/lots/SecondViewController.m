//
//  SecondViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property(nonatomic, strong) UIImageView *titleView;

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Check-in", @"check-ing tab");
        self.tabBarItem.image = [UIImage imageNamed:@"flag"];
//        self.mapView = [[MKMapView alloc] init];
//        self.mapView.tag = 101;
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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(locationUpdated)
                                                     name:LSLocationManagerDidUpdateLocationNotification
                                                   object:nil];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self refreshLots];
    

}

- (void) locationUpdated
{
    [self refreshLots];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self.lotCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LSCollectionViewCell"];

    [self addRightSwipeGesture];
    [self.lotCollectionView registerClass:[LSCheckInCell class] forCellWithReuseIdentifier:@"LSCheckInCell"];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(dismissView)];
    self.navigationItem.title = @"Check In";
    self.navigationItem.leftBarButtonItem = cancelButton;

    /*
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
     */
    
//    [ThemeManager customizeLabelWithCustomFont:self.titleLabel];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[LocationManager sharedLocationManager] startUpdates];
}

-(void) addRightSwipeGesture
{
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selectLeftTab)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.lotCollectionView addGestureRecognizer:leftGesture];
}

-(void) dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) selectLeftTab
{
//    [self.tabBarController setSelectedIndex:self.tabBarController.selectedIndex - 1];
    
    // Get the views.
    UIView * fromView = self.tabBarController.selectedViewController.view;
    UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:self.tabBarController.selectedIndex-1] view];
    
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = self.tabBarController.selectedIndex-1 > self.tabBarController.selectedIndex;
    
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
                             self.tabBarController.selectedIndex = self.tabBarController.selectedIndex-1;
                         }
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected!");
    // TODO: Select Item
    ExploreLots *chosenLot = [lotArray objectAtIndex:indexPath.row];
    CheckInViewController *chkController = [[CheckInViewController alloc] initWithNibName:@"CheckInViewController" bundle:nil];
    chkController.lot = chosenLot;
    [self.navigationController pushViewController:chkController animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    NSLog(@"Deselected!");

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
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            if ([self.view.window viewWithTag:101]) {
                [self.mapView removeFromSuperview];
            }else {
                return;
            }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            break;
        case UIDeviceOrientationLandscapeLeft:
            rotation = M_PI_2;
            statusBarOrientation = UIInterfaceOrientationLandscapeRight;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            [self.mapView setFrame:CGRectMake(self.view.window.bounds.origin.x, self.view.bounds.origin.y, self.view.window.bounds.size.width, self.view.window.bounds.size.height)];
            if (![self.view.window viewWithTag:101]) {
                [self.view.window addSubview:self.mapView];
            }else {
                return;
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            rotation = -M_PI_2;
            statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            [self.mapView setFrame:CGRectMake(self.view.window.bounds.origin.x, self.view.window.bounds.origin.y, self.view.window.bounds.size.width, self.view.window.bounds.size.height)];
            if (![self.view.window viewWithTag:101]) {
                [self.view.window addSubview:self.mapView];
            }
            break;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.mapView setTransform:transform];
        [self.mapView setFrame:CGRectMake(self.view.window.bounds.origin.x, self.view.window.bounds.origin.y, self.view.window.bounds.size.width, self.view.window.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self plotLotPositions];
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
    // 3
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    // 4
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    CLLocationCoordinate2D coordinate;
    for (ExploreLots *tempLot in lotArray) {
        coordinate.latitude = tempLot.latitude;
        coordinate.longitude = tempLot.longitude;
        LotAnnotation *annotation = [[LotAnnotation alloc] initWithName:tempLot.name address:nil coordinate:coordinate] ;
        [self.mapView addAnnotation:annotation];
    }
//    [self.mapView setShowsUserLocation:NO];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.lotCollectionView.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.lotCollectionView.contentInset;
    tableContentInset.top = 0.0;
    self.lotCollectionView.contentInset = tableContentInset;
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
            self.lotCollectionView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.lotCollectionView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
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

- (void) refreshLots
{
    [ExploreLots globalExploreLotsWithBlock:^(NSArray *lots, NSError *error) {
        
        if (!error) {
            //            NSLog(@"In Lots");
            [lotArray removeAllObjects];
            for( NSObject *lot in lots ) {
                //                NSLog(@"Object description: %@", [lot description]);
                [lotArray addObject:lot];
            }
            [[self lotCollectionView] reloadData];
            
            // Save our new scans out to the archive file
            NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                          NSUserDomainMask, YES) objectAtIndex:0];
            NSString *archivePath = [documentsDir stringByAppendingPathComponent:LSAllLotsArchiveString];
            [NSKeyedArchiver archiveRootObject:lotArray toFile:archivePath];
        }
    }];
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.lotCollectionView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    _refreshLabel.text = self.textLoading;
    _refreshArrow.hidden = YES;
    [_refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh View of Parking Lots
    [self refreshLots];
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
    
    _refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first.png"]];
    _refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                     (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                     27, 44);
    
    _refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    _refreshSpinner.hidesWhenStopped = YES;
    
    [_refreshHeaderView addSubview:_refreshLabel];
    [_refreshHeaderView addSubview:_refreshArrow];
    [_refreshHeaderView addSubview:_refreshSpinner];
    [self.lotCollectionView addSubview:_refreshHeaderView];
}

#pragma mark – UICollectionViewDelegateFlowLayout
/*
// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExploreLots *lot =  self.lotArray[indexPath.row];
    // 2
    CGSize retval = lot.thumbnail.size.width > 0 ? lot.thumbnail.size : CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    return retval;
}
*/
// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(75, 20, 75, 20);
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [lotArray count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    /*UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"LSCheckInCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) ];
    ExploreLots *lot = [lotArray objectAtIndex:indexPath.row];
    titleLabel.text = lot.name;
    [cell addSubview:titleLabel];
    
//    UICollectionViewCell *cell = [cv dequeueReusableCellWithIdentifier:@"LSCollectionViewCell"];
//    if (cell == nil)
//	{
//        cell = [[UICollectionViewCell alloc] initWithStyle:UICollectionViewSty
//                                      reuseIdentifier:@"LSExploreCell"];
//        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    return cell;*/
    
    LSCheckInCell *customCell = (LSCheckInCell *)[cv dequeueReusableCellWithReuseIdentifier:@"LSCheckInCell" forIndexPath:indexPath];
//    if (customCell == nil) {
//        customCell = [[LSCheckInCell alloc] init];
//        NSArray *topLevel;
//        topLevel = [[NSBundle mainBundle] loadNibNamed:@"LSCheckInCell" owner:self options:nil];
//        for (id currentObject in topLevel) {
//            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
//                customCell = (LSCheckInCell *) currentObject;
//                break;
//            }
//        }
//    }
    
//    [customCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    customCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ExploreLots *exLots = [lotArray objectAtIndex:indexPath.row];
    //    NSLog(@"Lot Name: %@", exLots.name);
    customCell.nameLabel.text = exLots.name;
	
    return customCell;
}

@end
