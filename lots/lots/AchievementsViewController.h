//
//  AchievementsViewController.h
//  lots
//
//  Created by Thomas DeMeo on 3/15/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementsViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIImageView *achImageView;
@property(nonatomic, strong) IBOutlet UILabel *countTitle;
@property(nonatomic, strong) IBOutlet UILabel *countDescription;
@property(nonatomic, assign) int count;

@end
