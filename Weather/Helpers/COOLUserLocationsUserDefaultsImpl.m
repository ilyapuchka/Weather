//
//  COOLUserLocationsUserDefaultsImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLUserLocationsUserDefaultsImpl.h"
#import "Location.h"

static NSString *const COOLUserLocationsKey = @"userLocations";

@interface COOLUserLocationsUserDefaultsImpl()

@property (nonatomic, strong) NSMutableArray *userLocationsArray;

@end

@implementation COOLUserLocationsUserDefaultsImpl

- (void)addUserLocation:(Location *)location
{
    NSCParameterAssert(location);
    if (!location) {
        return;
    }
    
    [self.userLocationsArray addObject:location];
}

- (void)removeUserLocation:(Location *)location
{
    if (!location) {
        return;
    }
    
    [self.userLocationsArray removeObject:location];
}

- (void)saveUserLocations:(NSArray *)locations
{
    [[NSUserDefaults standardUserDefaults] setObject:locations forKey:COOLUserLocationsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)userLocations
{
    return [self.userLocationsArray copy];
}

- (NSMutableArray *)userLocationsArray
{
    if (!_userLocationsArray) {
        _userLocationsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:COOLUserLocationsKey] mutableCopy];
    }
    return _userLocationsArray;
}

@end
