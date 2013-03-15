//
//  LSCheckInCell.m
//  lots
//
//  Created by Thomas DeMeo on 3/14/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "LSCheckInCell.h"

@implementation LSCheckInCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"LSCheckInCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        self.layer.masksToBounds = NO;
        self.frontView.layer.cornerRadius = 3.0f;
        self.layer.cornerRadius = 3.0f;
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
        self.layer.shadowRadius = 5.0f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = path.CGPath;
    }
    
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
