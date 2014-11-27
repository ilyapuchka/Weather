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

@end
