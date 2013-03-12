//
//  ExploreLots.h
//  lots
//
//  Created by Thomas DeMeo on 3/12/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationManager.h"
#import "AFLotsAPIClient.h"

@interface ExploreLots : NSObject

@property (readonly) NSUInteger lotID;
@property (readonly) float latitude;
@property (readonly) float longitude;
@property (readonly) NSString *name;
@property (readonly) float distance;
@property (readonly) NSDictionary *status;
@property (readonly) float averageOccupancy;
@property (readonly) NSArray *past;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)globalExploreLotsWithBlock:(void (^)(NSArray *posts, NSError *error))block;
@end