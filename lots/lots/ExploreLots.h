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

#define kExploreLotName @"LSExploreLotName"
#define kExploreLotID @"LSExploreLotID"
#define kExploreLotLatitude @"LSExploreLotLatitude"
#define kExploreLotLongitude @"LSExploreLotLongitude"
#define kExploreLotDistance @"LSexploreLostDistance"
#define kExploreLotStatus @"LSExploreLotStatus"
#define kExploreLotAverageOccupancy @"LSExploreLotAverageOccupancy"
#define kExploreLotEstimatedOccupancy @"LSExploreLotEstimatedOccupancy"
#define kExploreLotPast @"LSExploreLotPast"

@interface ExploreLots : NSObject <NSCoding>

@property (nonatomic, assign) int lotID;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) NSDictionary *status;
@property (nonatomic, assign) float averageOccupancy;
@property (nonatomic, assign) float estimatedOccupancy;
@property (nonatomic, strong) NSMutableArray *past;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)globalExploreLotsWithBlock:(void (^)(NSArray *lots, NSError *error))block;
@end