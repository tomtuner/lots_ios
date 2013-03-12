//
//  FirstViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Explore", @"explore tab");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        if (!self.lotArray) {
			self.lotArray = [[NSMutableArray alloc] init];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(locationUpdated)
                                                    name:LSLocationManagerDidUpdateLocationNotification
                                                  object:nil];
    }
    return self;
}

- (void) locationUpdated
{
    [self refreshLots];
}

- (void) refreshLots
{
    /*
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithFloat:[[LocationManager sharedLocationManager] latitude]],
                               [NSNumber numberWithFloat:[[LocationManager sharedLocationManager] longitude]]]
                                                          forKeys:@[@"latitude", @"longitude"]];
    
    AFLotsAPIClient *networkingClient = [AFLotsAPIClient sharedClient];
    [networkingClient getPath:nil
                   parameters:paramDict
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"Success");
                          NSLog(@"Response: %@", responseObject);
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Fail");
                          NSLog(@"%@", [error localizedDescription]);
                      }];*/
    [ExploreLots globalExploreLotsWithBlock:^(NSArray *lots, NSError *error) {
       
        if (lots) {
            self.lotArray = lots;
            [[self lotExploreTable] reloadData];
        }
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
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
    NSLog(@"Array Count: %i", [self.lotArray count]);
	return [self.lotArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSExploreCell"];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"LSExploreCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	// Get the barcodeResult that has the data backing this cell
    //	NSMutableDictionary *scanSession = [scanHistory objectAtIndex:indexPath.section];
//	ZXResult *barcode = [scanHistory objectAtIndex:indexPath.row];
    ExploreLots *exLots = [self.lotArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = exLots.name;
	
    return cell;
}

@end
