//
//  CheckInLot.m
//  lots
//
//  Created by Thomas DeMeo on 3/13/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "CheckInLot.h"

@implementation CheckInLot

+ (void)globalCheckInToLotWithLotID:(int) lotID withOccupancy:(int) occ withBlock:(void (^)(NSArray *lot, NSError *error))block {

    NSDictionary *paramDict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:occ],
                               [NSNumber numberWithInt:lotID]]
                                                          forKeys:@[@"fill", @"lot_id"]];
    
    AFLotsAPIClient *networkingClient = [AFLotsAPIClient sharedClient];
    [networkingClient postPath:nil
                   parameters:paramDict
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"Success");
                          NSLog(@"Response: %@", responseObject);
                          NSArray *lotsFromResponse = responseObject;
                          
                          if (block) {
                              block([NSArray arrayWithArray:lotsFromResponse], nil);
                          }
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Fail");
                          NSLog(@"%@", [error localizedDescription]);
                          if (block) {
                              block([NSArray array], error);
                          }
                      }];
}

@end
