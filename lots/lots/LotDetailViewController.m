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
    self.title = self.lot.name;
    self.lotOccupancy = [NSString stringWithFormat:@"%@ %%", [NSNumber numberWithFloat:self.lot.averageOccupancy]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
}

- (UIBarButtonItem *)backBarButtonItem {
    // create button
    UIImage* image3 = [UIImage imageNamed:@"back_arrow"];
    CGRect frameimg = CGRectMake(20, 0, image3.size.width, image3.size.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
    [backButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // create button item -- possible because UIButton subclasses UIView!
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return backItem;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
