//
//  LotDetailViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/13/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LotDetailViewController.h"

@interface LotDetailViewController ()

@end

@implementation LotDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil withLot:(ExploreLots *) lot {
    
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.lot = lot;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lotName.text = self.lot.name;
    self.lotOccupancy = [NSString stringWithFormat:@"%@ %%", [NSNumber numberWithFloat:self.lot.averageOccupancy]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
