//
//  COOLUserLocationsUserDefaultsImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLUserLocationsUserDefaultsImpl.h"
#import "Location.h"

#import "INTULocationManager+Extensions.h"
#import "CLLocation+Extensions.h"

static NSString * const COOLUserLocationsKey = @"userLocations";
static NSString * const COOLSelectedLocationKey = @"selectedLocation";

@interface COOLUserLocationsUserDefaultsImpl()

@property (nonatomic, strong) NSMutableArray *userLocationsArray;

@property (nonatomic, strong) CLLocation *lastKnownUserLocation;

@end

@implementation COOLUserLocationsUserDefaultsImpl

- (void)addUserLocation:(Location *)location
{
    NSCParameterAssert(location);
    if (!location) {
        return;
    }
    
    [self.userLocationsArray addObject:location];
    [self saveUserLocations:self.userLocationsArray];
}

- (void)removeUserLocation:(Location *)location
{
    if (!location) {
        return;
    }
    
    [self.userLocationsArray removeObject:location];
    [self saveUserLocations:self.userLocationsArray];
}

- (void)saveUserLocations:(NSArray *)locations
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:locations];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:COOLUserLocationsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)userLocations
{
    return [self.userLocationsArray copy];
}

- (NSMutableArray *)userLocationsArray
{
    if (!_userLocationsArray) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:COOLUserLocationsKey];
        _userLocationsArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        _userLocationsArray = [_userLocationsArray?:@[] mutableCopy];
    }
    return _userLocationsArray;
}

- (Location *)selectedLocation
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:COOLSelectedLocationKey];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    else {
        return nil;
    }
}

- (void)setSelectedLocation:(Location *)location
{
    if (location) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:location];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:COOLSelectedLocationKey];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:COOLSelectedLocationKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)updateCurrentUserLocation:(BOOL)force withCompletion:(void (^)(NSInteger, CLLocation *, BOOL))completion
{
    if (force || [[INTULocationManager sharedInstance] needsUpdateCurrentLocation]) {
        return [self _currentUserLocationWithCompletion:completion];
    }
    else {
        if (completion) completion(INTULocationStatusSuccess, [[INTULocationManager sharedInstance] currentLocation], NO);
        return NO;
    }
}

- (BOOL)_currentUserLocationWithCompletion:(void (^)(NSInteger, CLLocation *, BOOL))completion
{
    __weak typeof(self) wself = self;
    static NSInteger locationRequestId;
    if (locationRequestId == 0) {
        locationRequestId = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            __weak typeof(self) sself = wself;
            if (status == INTULocationStatusSuccess) {
                if (!sself.lastKnownUserLocation ||
                    [currentLocation differsSignificantly:sself.lastKnownUserLocation]) {
                    sself.lastKnownUserLocation = currentLocation;
                    if (completion) completion(status, sself.lastKnownUserLocation, YES);
                }
                else {
                    if (completion) completion(status, sself.lastKnownUserLocation, NO);
                }
            }
            else {
                if (completion) completion(status, sself.lastKnownUserLocation, NO);
            }
            locationRequestId = 0;
        }];
        return YES;
    }
    return NO;
}

@end
