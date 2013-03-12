//
//  FirstViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFLotsAPIClient.h"
#import "LocationManager.h"
#import "Notifications.h"
#import "ExploreLots.h"

@interface FirstViewController : UIViewController


@property(nonatomic, strong) IBOutlet UITableView *lotExploreTable;
@property(nonatomic, strong) NSArray *lotArray;

@end
