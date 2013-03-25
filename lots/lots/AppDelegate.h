//
//  AppDelegate.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "LocationManager.h"
#import "Theme.h"
#import "CheckInViewController.h"
#import "CreateLotViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

//@property (assign, nonatomic) BOOL shouldShowAchievement;

-(void) showAchievementViewWithCount:(int) count;
- (void) uncaughtExceptionHandler:(NSException *) exception;

@end
