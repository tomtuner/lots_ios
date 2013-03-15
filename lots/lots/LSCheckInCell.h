//
//  LSCheckInCell.h
//  lots
//
//  Created by Thomas DeMeo on 3/14/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LSCheckInCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIView *frontView;

@end
