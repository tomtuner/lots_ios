//
//  CheckInLot.h
//  lots
//
//  Created by Thomas DeMeo on 3/13/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFLotsAPIClient.h"

@interface CheckInLot : NSObject

+ (void)globalCheckInToLotWithLotID:(int) lotID withOccupancy:(int) occ withBlock:(void (^)(NSArray *lot, NSError *error))block;


@end