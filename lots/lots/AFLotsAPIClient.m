//
//  AFLotsAPIClient.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "AFLotsAPIClient.h"
#import "AFJSONRequestOperation.h"

//static NSString * const kAFLotsAPIBaseURLString = @"http://www.occupylots.com/lots/index.php/lots/";

@implementation AFLotsAPIClient

+ (AFLotsAPIClient *)sharedClient {
    static AFLotsAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFLotsAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFLotsAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
