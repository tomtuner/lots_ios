//
//  WildcardGestureRecognizer.h
//  lots
//
//  Created by Thomas DeMeo on 3/25/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchesEventBlock)(NSSet * touches, UIEvent * event);

@interface WildcardGestureRecognizer : UIGestureRecognizer {
    TouchesEventBlock touchesBeganCallback;
}
@property(copy) TouchesEventBlock touchesBeganCallback;

@end
