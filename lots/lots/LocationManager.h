//
//  LocationManager.h
//  iPhoneBeta
//
//  Created by Thomas DeMeo on 1/29/12.
//  Copyright 2012 Garnish Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Notifications.h"

static float SIMULATE_LATITUDE  = 43.00;
static float SIMULATE_LONGITUDE = -77.50;

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager * locationManager;
    BOOL locationDefined;
    float latitude;
    float longitude;
    
    BOOL locationDenied;
}

+ (LocationManager *) sharedLocationManager;

- (void) startUpdates;
- (void) stopUpdates;
- (BOOL) locationDefined;
- (BOOL) locationDenied;
- (float) latitude;
- (float) longitude;

- (BOOL) locationServicesEnabled;

@end
