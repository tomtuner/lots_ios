//
//  LotFooterView.m
//  lots
//
//  Created by Thomas DeMeo on 3/27/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LotFooterView.h"

@implementation LotFooterView

@synthesize brightness, saturation, hue;

-(id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        hue = 0.08056;
        saturation = 0.27;
        brightness = 0.32;
    }
    return self;
}

-(void) drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //    CGColorRef outerTop = GarnishNavBarColor.CGColor;
    CGColorRef outerTop = [UIColor colorWithHue:hue saturation:saturation
                                     brightness:brightness alpha:1.0].CGColor;
        
    CGRect outerRect = CGRectInset(self.bounds, 0.0f,0.0f);
    CGMutablePathRef outerPath = [LotsCommon createRoundedRectForRect:outerRect withRadius: 7.0f];
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, outerTop);
    //    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);

}

@end
