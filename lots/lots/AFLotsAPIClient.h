//
//  AFLotsAPIClient.h
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"

@interface AFLotsAPIClient : AFHTTPClient

+ (AFLotsAPIClient *)sharedClient;

@end
