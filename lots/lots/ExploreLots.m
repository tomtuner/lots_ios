//
//  ExploreLots.m
//  lots
//
//  Created by Thomas DeMeo on 3/12/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "ExploreLots.h"

@implementation ExploreLots

-(id) initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)  {
        return nil;
    }
    
    _lotID = [[attributes valueForKeyPath:@"id"] integerValue];
    _latitude = [[attributes valueForKeyPath:@"latitude"] floatValue];
    _longitude = [[attributes valueForKeyPath:@"longitude"] floatValue];
    _name = [attributes valueForKeyPath:@"name"];
    _distance = [[attributes valueForKeyPath:@"distance"] floatValue];
    _status = [attributes valueForKeyPath:@"status"];
    _averageOccupancy = [[_status valueForKeyPath:@"avg_occ"] floatValue];
    _past = [_status valueForKeyPath:@"past"];
    
    return self;
}

+ (void)globalExploreLotsWithBlock:(void (^)(NSArray *lots, NSError *error))block {
    
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithFloat:[[LocationManager sharedLocationManager] latitude]],
                               [NSNumber numberWithFloat:[[LocationManager sharedLocationManager] longitude]]]
                                                          forKeys:@[@"latitude", @"longitude"]];
    
    AFLotsAPIClient *networkingClient = [AFLotsAPIClient sharedClient];
    [networkingClient getPath:nil
                   parameters:paramDict
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"Success");
                          NSLog(@"Response: %@", responseObject);
                          NSArray *lotsFromResponse = responseObject;
                          NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[lotsFromResponse count]];
                          for (NSDictionary *attributes in lotsFromResponse) {
                              ExploreLots *lots = [[ExploreLots alloc] initWithAttributes:attributes];
                              [mutablePosts addObject:lots];
                          }
                          
                          if (block) {
                              block([NSArray arrayWithArray:mutablePosts], nil);
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
