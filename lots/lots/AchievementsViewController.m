//
//  AchievementsViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/15/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "AchievementsViewController.h"

@interface AchievementsViewController ()

@end

@implementation AchievementsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switch (self.count) {
        case 1:
            self.countTitle.text = @"Numero Uno";
            self.countDescription.text = @"1 for 1, keep up the good work.";
            break;
        case 5:
            self.countTitle.text = @"High Five";
            self.countDescription.text = @"5 check-ins so far. Boss.";
            break;
        case 10:
            self.countTitle.text = @"Ten-ure";
            self.countDescription.text = @"10 check-ins strong, it's getting to your head.";
            break;
            
        default:
            break;
    }
    NSString *imageName = [NSString stringWithFormat:@"ach_%i", self.count];
    self.achImageView.image = [UIImage imageNamed:imageName];
}

-(IBAction)dismissView
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
