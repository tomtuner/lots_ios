//
//  LotsCommon.m
//  lots
//
//  Created by Thomas DeMeo on 3/27/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LotsCommon.h"

@implementation LotsCommon

/*
+ (CGMutablePathRef) createRoundedRectForRectWithBottomOnlyBottomRadius:(CGRect) rect withRadius:(CGFloat) radius {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect),
                        CGRectGetMaxX(rect), CGRectGetMaxY(rect), 0.0f);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect),
                        CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect),
                        CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect),
                        CGRectGetMaxX(rect), CGRectGetMinY(rect), 0.0f);
    CGPathCloseSubpath(path);
    
    return path;
}
*/

+ (CGMutablePathRef) createRoundedRectForRect:(CGRect) rect withRadius:(CGFloat) radius {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect),
                        CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect),
                        CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect),
                        CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect),
                        CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;
}

@end
