//
//  SecondViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExploreLots.h"
#import "FirstViewController.h"
#import "CheckInViewController.h"

@interface SecondViewController : UIViewController

@property(nonatomic, strong) IBOutlet UICollectionView *lotCollectionView;
@property(nonatomic, strong) NSMutableArray *lotArray;

@end
