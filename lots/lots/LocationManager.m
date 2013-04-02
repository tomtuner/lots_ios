//
//  LocationManager.m
//  iPhoneBeta
//
//  Created by Thomas DeMeo on 1/29/12.
//  Copyright 2012 Garnish Inc. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *globalLocationManager = nil;
static BOOL initialized = NO;

@implementation LocationManager

+ (LocationManager *) sharedLocationManager {
    if (!globalLocationManager) {
        globalLocationManager = [[LocationManager allocWithZone:nil] init];
    }
    
    return globalLocationManager;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (globalLocationManager == nil) {
            globalLocationManager = [super allocWithZone:zone];
        }
    }
    return globalLocationManager;
}

- (id) copyWithZone:(NSZone *)zone {
    return self;
}

//- (id) retain {
//    return self;
//}
//
//- (unsigned) retainCount {
//    return UINT_MAX; // Makes sure the object cannot be released
//}
//
//- (void) release {
//    
//}
//
//- (id) autorelease {
//    return self;
//}

- (void) reset {
    locationDefined = NO;
    latitude = 0.f;
    longitude = 0.f;
}

- (id)init
{
    if (initialized) {
        return globalLocationManager;
    }
    self = [super init];
    if (!self) {
        if (globalLocationManager) {
            globalLocationManager = nil;
        }
        return nil;
    }
    
    locationManager = nil;
    initialized = YES;
    locationDenied = NO;
    [self reset];
    
    return self;
}

- (void) stopUpdates {
    if (locationManager) {
        [locationManager stopUpdatingLocation];
    }
//    [self reset];
}

- (void) startUpdates {
    if (![self locationServicesEnabled]) {
        [self stopUpdates];
        NSLog(@"Location Services not enabled!");
        return;
    }
    
    if (locationManager) {
        [locationManager stopUpdatingLocation];
    }else {
        NSLog(@"Initializing CLLocation");
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 100;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    [self reset];

    #if TARGET_IPHONE_SIMULATOR
        NSLog(@"Running in simulator, simulate Latitude: %f Longitude: %f", SIMULATE_LATITUDE, SIMULATE_LONGITUDE);
        latitude = SIMULATE_LATITUDE;
        longitude = SIMULATE_LONGITUDE;
        [[NSNotificationCenter defaultCenter] postNotificationName:LSLocationManagerDidUpdateLocationNotification object: nil];

    #else
        [locationManager startUpdatingLocation];
    #endif
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    locationDenied = NO;
    if (![self locationServicesEnabled]) {
        [self stopUpdates];
        return;
    }
    
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    NSLog(@"Location Determined Latitude: %f Longitude: %f", latitude, longitude);
    locationDefined = YES;
    
    if (!([[NSUserDefaults standardUserDefaults] boolForKey:@"Development"])) {
        [Flurry setLatitude:latitude longitude:longitude horizontalAccuracy:newLocation.horizontalAccuracy verticalAccuracy:newLocation.verticalAccuracy];
    }
    
    // Notification that location has finished updating
    [[NSNotificationCenter defaultCenter] postNotificationName:LSLocationManagerDidUpdateLocationNotification object: nil];
    [self stopUpdates];
}

- (BOOL) locationDenied {
    return locationDenied;
}

- (BOOL) locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self reset];
    
    if ([error domain] == kCLErrorDomain) {
        switch ([error code]) {
            case kCLErrorDenied:
                locationDenied = YES;
                [self stopUpdates];
                break;
            case kCLErrorLocationUnknown:
                break;
            default:
                break;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateLocationNotification" object: nil];
}

- (BOOL) locationDefined {
    return locationDefined;
}

- (float) latitude {
    return latitude;
}

- (float) longitude {
    return longitude;
}

@end
