//
//  LotDetailViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/13/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExploreLots.h"

@interface LotDetailViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel *lotName;
@property(nonatomic, strong) IBOutlet UILabel *lotOccupancy;

@property(nonatomic, strong) ExploreLots *lot;

- (id)initWithNibName:(NSString *)nibNameOrNil withLot:(ExploreLots *) special;

@end
