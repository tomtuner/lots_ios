//
//  Theme.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Theme.h"
#import "RITTheme.h"

@implementation ThemeManager

+ (id <Theme>)sharedTheme
{
    static id <Theme> sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Create and return the theme:
        //        sharedTheme = [[SSDefaultTheme alloc] init];
        //        sharedTheme = [[SSTintedTheme alloc] init];
        sharedTheme = [[RITTheme alloc] init];
    });
    
    return sharedTheme;
}

+ (void)customizeAppAppearance
{
    id <Theme> theme = [self sharedTheme];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsLandscapePhone] forBarMetrics:UIBarMetricsLandscapePhone];
    [navigationBarAppearance setShadowImage:[theme topShadow]];
    
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    /*
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateHighlighted style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault] forState:UIControlStateHighlighted style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsLandscapePhone];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateHighlighted style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateHighlighted style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsLandscapePhone];
    
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault] forState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone];
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateHighlighted style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsLandscapePhone];
    */
//    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    /*
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];*/
    
    UISegmentedControl *segmentedAppearance = [UISegmentedControl appearance];
    [segmentedAppearance setBackgroundImage:[theme segmentedBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedAppearance setBackgroundImage:[theme segmentedBackgroundForState:UIControlStateSelected barMetrics:UIBarMetricsDefault] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segmentedAppearance setBackgroundImage:[theme segmentedBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [segmentedAppearance setBackgroundImage:[theme segmentedBackgroundForState:UIControlStateSelected barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateSelected barMetrics:UIBarMetricsLandscapePhone];
    
    [segmentedAppearance setDividerImage:[theme segmentedDividerForBarMetrics:UIBarMetricsDefault] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedAppearance setDividerImage:[theme segmentedDividerForBarMetrics:UIBarMetricsLandscapePhone] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[theme tabBarBackground]];
    [tabBarAppearance setSelectionIndicatorImage:[theme tabBarSelectionIndicator]];
//    [tabBarAppearance setShadowImage:[theme bottomShadow]];
    
    UIToolbar *toolbarAppearance = [UIToolbar appearance];
    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsDefault] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsLandscapePhone] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
//    [toolbarAppearance setShadowImage:[theme bottomShadow] forToolbarPosition:UIToolbarPositionAny];
    
    UISearchBar *searchBarAppearance = [UISearchBar appearance];
    [searchBarAppearance setBackgroundImage:[theme searchBackground]];
    [searchBarAppearance setSearchFieldBackgroundImage:[theme searchFieldImage] forState:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconSearch state:UIControlStateNormal] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconClear state:UIControlStateNormal] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconClear state:UIControlStateHighlighted] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    [searchBarAppearance setScopeBarBackgroundImage:[theme searchBackground]];
    [searchBarAppearance setScopeBarButtonBackgroundImage:[theme searchScopeButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [searchBarAppearance setScopeBarButtonBackgroundImage:[theme searchScopeButtonBackgroundForState:UIControlStateSelected] forState:UIControlStateSelected];
    [searchBarAppearance setScopeBarButtonDividerImage:[theme searchScopeButtonDivider] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    
    UIButton *buttonAppearance = [UIButton appearance];
//    [buttonAppearance setTitleColor:[theme mainColor] forState:UIControlStateNormal];
//    [buttonAppearance setTitleColor:[theme baseTintColor] forState:UIControlStateHighlighted];
    
    UISlider *sliderAppearance = [UISlider appearance];
    [sliderAppearance setThumbImage:[theme sliderThumbForState:UIControlStateNormal] forState:UIControlStateNormal];
    [sliderAppearance setThumbImage:[theme sliderThumbForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    [sliderAppearance setMinimumTrackImage:[theme sliderMinTrack] forState:UIControlStateNormal];
    [sliderAppearance setMaximumTrackImage:[theme sliderMaxTrack] forState:UIControlStateNormal];
    
    UIProgressView *progressAppearance = [UIProgressView appearance];
    [progressAppearance setTrackImage:[theme progressTrackImage]];
    [progressAppearance setProgressImage:[theme progressProgressImage]];
    
   /* UISwitch *switchAppearance = [UISwitch appearance];
    [switchAppearance setOnImage:[theme onSwitchImage]];
    [switchAppearance setOffImage:[theme offSwitchImage]];
    [switchAppearance setTintColor:[theme switchTintColor]];
    [switchAppearance setOnTintColor:[theme switchOnColor]];
    [switchAppearance setThumbTintColor:[theme switchThumbColor]];
    
    UIStepper *stepperAppearance = [UIStepper appearance];
    [stepperAppearance setBackgroundImage:[theme stepperBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [stepperAppearance setBackgroundImage:[theme stepperBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    [stepperAppearance setBackgroundImage:[theme stepperBackgroundForState:UIControlStateDisabled] forState:UIControlStateDisabled];
    [stepperAppearance setDividerImage:[theme stepperDividerForState:UIControlStateNormal] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    [stepperAppearance setDividerImage:[theme stepperDividerForState:UIControlStateHighlighted] forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateNormal];
    [stepperAppearance setDividerImage:[theme stepperDividerForState:UIControlStateHighlighted] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateHighlighted];
    [stepperAppearance setIncrementImage:[theme stepperIncrementImage] forState:UIControlStateNormal];
    [stepperAppearance setDecrementImage:[theme stepperDecrementImage] forState:UIControlStateNormal];
    */
    NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
    UIColor *mainColor = [theme mainColor];
//    UIColor *mainColor = nil;
    if (mainColor) {
        [titleTextAttributes setObject:mainColor forKey:UITextAttributeTextColor];
    }
    UIColor *shadowColor = [theme shadowColor];
//    UIColor *shadowColor = nil;
    if (shadowColor) {
        [titleTextAttributes setObject:shadowColor forKey:UITextAttributeTextShadowColor];
        CGSize shadowOffset = [theme shadowOffset];
        [titleTextAttributes setObject:[NSValue valueWithCGSize:shadowOffset] forKey:UITextAttributeTextShadowOffset];
    }
//    UIFont *font = [theme customFontWithSize:22.0f];
    UIFont *font = nil;
    if (font) {
        [titleTextAttributes setObject:font forKey:UITextAttributeFont];
    }

    [navigationBarAppearance setTitleTextAttributes:titleTextAttributes];
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
//    UIColor *bgColor = [theme backgroundColor];
    //    UIColor *mainColor = nil;
//    if (bgColor) {
//        [titleTextAttributes setObject:bgColor forKey:UITextAttributeTextColor];
//    }
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateDisabled];

//    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateHighlighted];
    [segmentedAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    [searchBarAppearance setScopeBarButtonTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    
//    UILabel *headerLabelAppearance = [UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil];
    UIColor *accentTintColor = [theme accentTintColor];
    if (accentTintColor) {
        [sliderAppearance setMaximumTrackTintColor:accentTintColor];
        [progressAppearance setTrackTintColor:accentTintColor];
        UIBarButtonItem *toolbarBarButtonItemAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil];
        [toolbarBarButtonItemAppearance setTintColor:accentTintColor];
        [tabBarAppearance setSelectedImageTintColor:accentTintColor];
    }
    UIColor *baseTintColor = [theme baseTintColor];
    if (baseTintColor) {
        [navigationBarAppearance setTintColor:baseTintColor];
//        [barButtonItemAppearance setTintColor:baseTintColor];
//        [buttonAppearance setTintColor:baseTintColor];
        [segmentedAppearance setTintColor:baseTintColor];
        [tabBarAppearance setTintColor:baseTintColor];
        [toolbarAppearance setTintColor:baseTintColor];
        [searchBarAppearance setTintColor:baseTintColor];
        [sliderAppearance setThumbTintColor:baseTintColor];
        [sliderAppearance setMinimumTrackTintColor:baseTintColor];
        [progressAppearance setProgressTintColor:baseTintColor];
//        [stepperAppearance setTintColor:baseTintColor];
//        [headerLabelAppearance setTextColor:baseTintColor];
    } else if (mainColor) {
//        [headerLabelAppearance setTextColor:mainColor];
    }
}

+ (void)customizeView:(UIView *)view
{
    id <Theme> theme = [self sharedTheme];
    UIColor *backgroundColor = [theme backgroundColor];
    if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
}

+ (void) customizeLabelWithCustomFont:(UILabel *)label
{
    id <Theme> theme = [self sharedTheme];
    UIFont *font = [theme customFontWithSize:24.0f];
    label.font = font;
}

+ (void) customizeButtonWithCustomFont:(UIButton *)button
{
    id <Theme> theme = [self sharedTheme];
    UIFont *font = [theme customFontWithSize:18.0f];
    button.titleLabel.font = font;
}

+ (void) customizeButtonWithGrayBackground:(UIButton *)button
{
//    UIImage *redButtonImage = [UIImage imageNamed:@"gray_button"];
    UIImage *redButtonImage = [[UIImage imageNamed:@"gray_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15) resizingMode:UIImageResizingModeTile];
    
    [button setBackgroundImage:redButtonImage forState:UIControlStateNormal];
}

+ (void)customizeTableView:(UITableView *)tableView
{
    id <Theme> theme = [self sharedTheme];
    UIImage *backgroundImage = [theme tableBackground];
    UIColor *backgroundColor = [theme backgroundColor];
    if (backgroundImage) {
        UIImageView *background = [[UIImageView alloc] initWithImage:backgroundImage];
        [tableView setBackgroundView:background];
    } else if (backgroundColor) {
        [tableView setBackgroundView:nil];
        [tableView setBackgroundColor:backgroundColor];
    }
}

/*+ (void)customizeTabBarItem:(UITabBarItem *)item forTab:(SSThemeTab)tab
{
    id <SSTheme> theme = [self sharedTheme];
    UIImage *image = [theme imageForTab:tab];
    if (image) {
        // If we have a regular image, set that
        [item setImage:image];
    } else {
        // Otherwise, set the finished images
        UIImage *selectedImage = [theme finishedImageForTab:tab selected:YES];
        UIImage *unselectedImage = [theme finishedImageForTab:tab selected:NO];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
    }
}
 */

@end
