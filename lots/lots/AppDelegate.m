//
//  AppDelegate.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self setupInitialTabBarController];
    self.window.rootViewController = self.tabBarController;
    
    [ThemeManager customizeAppAppearance];
    [[LocationManager sharedLocationManager] startUpdates];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void) setupInitialTabBarController
{
    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    UINavigationController *navCont1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
//    [navCont1 setNavigationBarHidden:YES];
    UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UINavigationController *navCont2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navCont1, navCont2];
}

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Shook Phone!!!!");
        NSArray *closestLots;
        @try {
    		NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                          NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"Scan Data Archive String: %@", LSAllLotsArchiveString);
			NSString *archivePath = [documentsDir stringByAppendingPathComponent:LSAllLotsArchiveString];
			closestLots = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
		}
		@catch (...)
		{
            NSLog(@"Exception unarchiving file.");
    	}
        CheckInViewController *checkIn = [[CheckInViewController alloc] initWithNibName:@"CheckInViewController" bundle:nil];
        checkIn.lot = [closestLots objectAtIndex:0];
        if (!self.tabBarController.presentedViewController) {
            [self.tabBarController presentViewController:checkIn animated:YES completion:nil];
        }
    }
}

-(void) showAchievementViewWithCount:(int) count
{
    AchievementsViewController *achVC = [[AchievementsViewController alloc] initWithNibName:@"AchievementsViewController" bundle:nil];
    achVC.count = count;
    self.tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    achVC.view.alpha = 0.2;
    [self.tabBarController presentViewController:achVC animated:NO completion:nil];
    [UIView animateWithDuration:0.5
                     animations:^{achVC.view.alpha  = 1.0;}];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
