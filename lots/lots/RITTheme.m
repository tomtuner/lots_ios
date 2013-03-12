//
//  RITTheme.m
//  rit_bus
//
//  Created by Thomas DeMeo on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RITTheme.h"

@implementation RITTheme

- (UIColor *)mainColor
{
    return [UIColor whiteColor];
}

- (UIColor *)highlightColor
{
    return [UIColor colorWithWhite:0.9 alpha:1.0];
}

- (UIColor *)shadowColor
{
    return nil;
}

- (UIColor *)backgroundColor
{
    return [UIColor lightGrayColor];
}

- (UIColor *)baseTintColor
{
    return [self ritOrangeColor];
}

- (UIColor *)accentTintColor
{
    return nil;
}

- (UIColor *)ritOrangeColor {
    return [UIColor colorWithRed:(0.9529411765) green:(0.431372549) blue:(0.1294117647) alpha:1.0];
}

- (UIColor *)ritBrownColor {
    return nil;
}

- (UIColor *)ritBlackColor {
    return nil;
}

- (UIColor *) navigationTintColor {
    return [self ritOrangeColor];
}

- (UIColor *)switchThumbColor
{
    return [UIColor colorWithWhite:0.75 alpha:1.0];
}

- (UIColor *)switchOnColor
{
    return [UIColor colorWithWhite:0.25 alpha:1.0];
}

- (UIColor *)switchTintColor
{
    return [UIColor colorWithWhite:0.85 alpha:1.0];
}

- (CGSize)shadowOffset
{
    return CGSizeMake(1.0, 1.0);
}

- (UIImage *)topShadow
{
    return [UIImage imageNamed:@"topShadow"];
}

- (UIImage *)bottomShadow
{
    return [UIImage imageNamed:@"bottomShadow"];
}

- (UIImage *)navigationBackgroundForBarMetrics:(UIBarMetrics)metrics
{
    NSString *name = @"navigationBackground";
    if (metrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 8.0, 0.0, 8.0)];
    return image;
}

- (UIImage *)barButtonBackgroundForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics
{
    NSString *name = @"barButton";
    if (style == UIBarButtonItemStyleDone) {
        name = [name stringByAppendingString:@"Done"];
    }
    if (barMetrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
    return image;
}

- (UIImage *)backBackgroundForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics
{
    NSString *name = @"backButton";
    if (barMetrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 21.0, 0.0, 13.0)];
    return image;
}

- (UIImage *)toolbarBackgroundForBarMetrics:(UIBarMetrics)metrics
{
    NSString *name = @"toolbarBackground";
    if (metrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 8.0, 0.0, 8.0)];
    return image;
}

- (UIImage *)searchBackground
{
    return [UIImage imageNamed:@"searchBackground"];
}

- (UIImage *)searchFieldImage
{
    UIImage *image = [UIImage imageNamed:@"searchField"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 16.0, 0.0, 16.0)];
    return image;
}

- (UIImage *)searchScopeButtonBackgroundForState:(UIControlState)state
{
    NSString *name = @"searchScopeButton";
    if (state == UIControlStateSelected) {
        name = [name stringByAppendingString:@"Selected"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
    return image;
}

- (UIImage *)searchScopeButtonDivider
{
    return [UIImage imageNamed:@"searchScopeDivider"];
}

- (UIImage *)searchImageForIcon:(UISearchBarIcon)icon state:(UIControlState)state
{
    NSString *name;
    if (icon == UISearchBarIconSearch) {
        name = @"searchIconSearch";
    } else if (icon == UISearchBarIconClear) {
        name = @"searchIconClear";
        if (state == UIControlStateHighlighted) {
            name = [name stringByAppendingString:@"Highlighted"];
        }
    }
    return (name ? [UIImage imageNamed:name] : nil);
}

- (UIImage *)segmentedBackgroundForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
{
    NSString *name = @"segmentedBackground";
    if (barMetrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    if (state == UIControlStateSelected) {
        name = [name stringByAppendingString:@"Selected"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
    return image;
}

- (UIImage *)segmentedDividerForBarMetrics:(UIBarMetrics)barMetrics
{
    NSString *name = @"segmentedDivider";
    if (barMetrics == UIBarMetricsLandscapePhone) {
        name = [name stringByAppendingString:@"Landscape"];
    }
    return [UIImage imageNamed:name];
}

- (UIImage *)tableBackground
{
    UIImage *image = [UIImage imageNamed:@"tableBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}

- (UIImage *)onSwitchImage
{
    return [UIImage imageNamed:@"onSwitch"];
}

- (UIImage *)offSwitchImage
{
    return [UIImage imageNamed:@"offSwitch"];
}

- (UIImage *)sliderThumbForState:(UIControlState)state
{
    NSString *name = @"sliderThumb";
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    return [UIImage imageNamed:name];
}

- (UIImage *)sliderMinTrack
{
    UIImage *image = [UIImage imageNamed:@"sliderMinTrack"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    return image;
}

- (UIImage *)sliderMaxTrack
{
    UIImage *image = [UIImage imageNamed:@"sliderMaxTrack"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    return image;
}

- (UIImage *)speedSliderMinImage
{
    return [UIImage imageNamed:@"slowShip"];
}

- (UIImage *)speedSliderMaxImage
{
    return [UIImage imageNamed:@"fastShip"];
}

- (UIImage *)progressTrackImage
{
    UIImage *image = [UIImage imageNamed:@"progressTrack"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    return image;
}

- (UIImage *)progressProgressImage
{
    UIImage *image = [UIImage imageNamed:@"progressProgress"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    return image;
}

- (UIImage *)stepperBackgroundForState:(UIControlState)state
{
    NSString *name = @"stepperBackground";
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    } else if (state == UIControlStateDisabled) {
        name = [name stringByAppendingString:@"Disabled"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 13.0)];
    return image;
}

- (UIImage *)stepperDividerForState:(UIControlState)state
{
    NSString *name = @"stepperDivider";
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    }
    return [UIImage imageNamed:name];
}

- (UIImage *)stepperIncrementImage
{
    return [UIImage imageNamed:@"stepperIncrement"];
}

- (UIImage *)stepperDecrementImage
{
    return [UIImage imageNamed:@"stepperDecrement"];
}

- (UIImage *)buttonBackgroundForState:(UIControlState)state
{
    NSString *name = @"button";
    if (state == UIControlStateHighlighted) {
        name = [name stringByAppendingString:@"Highlighted"];
    } else if (state == UIControlStateDisabled) {
        name = [name stringByAppendingString:@"Disabled"];
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 16.0, 0.0, 16.0)];
    return image;
}

- (UIImage *)tabBarBackground
{
    return [UIImage imageNamed:@"tabBarBackground"];
}

- (UIImage *)tabBarSelectionIndicator
{
    return [UIImage imageNamed:@"tabBarSelectionIndicator"];
}

- (UIFont *) customFontWithSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Linear" size:fontSize];
}
/*- (UIImage *)imageForTab:(SSThemeTab)tab
{
    return nil;
}

- (UIImage *)finishedImageForTab:(SSThemeTab)tab selected:(BOOL)selected
{
    NSString *name = nil;
    if (tab == SSThemeTabDoor) {
        name = @"doorTab";
    } else if (tab == SSThemeTabPower) {
        name = @"powerTab";
    } else if (tab == SSThemeTabControls) {
        name = @"controlsTab";
    }
    if (selected) {
        name = [name stringByAppendingString:@"Selected"];
    }
    return (name ? [UIImage imageNamed:name] : nil);
}
*/
- (UIImage *)doorImageForState:(UIControlState)state
{
    NSString *name;
    if (state & UIControlStateDisabled) {
        name = @"doorDisabled";
    } else {
        if (state & UIControlStateSelected) {
            name = @"doorOpen";
        } else {
            name = @"doorClosed";
        }
        if (state & UIControlStateHighlighted) {
            name = [name stringByAppendingString:@"Highlighted"];
        }
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(16.0, 0.0, 15.0, 0.0)];
    return image;
}


@end
