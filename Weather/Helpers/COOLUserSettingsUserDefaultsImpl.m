//
//  COOLUserSettingsUserDefaultsImpl.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLUserSettingsUserDefaultsImpl.h"
#import "COOLNotifications.h"

static NSString * const COOLDefaultTemperatureUnitKey = @"temperatureUnit";
static NSString * const COOLDefaultDistanceUnitKey = @"distanceUnit";

@implementation COOLUserSettingsUserDefaultsImpl

+ (void)load
{
    NSDictionary *defaults = @{
                               COOLDefaultTemperatureUnitKey: @(COOLTemperatureCelcius),
                               COOLDefaultDistanceUnitKey: @(COOLDistanceKilometres)
                               };
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

- (COOLDistanceUnit)defaultDistanceUnit
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:COOLDefaultDistanceUnitKey] integerValue];
}

- (void)setDefaultDistanceUnit:(COOLDistanceUnit)unit
{
    if (unit != [self defaultDistanceUnit]) {
        if (unit > COOLDistanceMiles) {
            unit = COOLDistanceKilometres;
        }
        [[NSUserDefaults standardUserDefaults] setObject:@(unit) forKey:COOLDefaultDistanceUnitKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:COOLUserSettingsChangedNotification object:self];
    }
}

- (COOLTemperatureUnit)defaultTemperatureUnit
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:COOLDefaultTemperatureUnitKey] integerValue];
}

- (void)setDefaultTemperatureUnit:(COOLTemperatureUnit)unit
{
    if (unit != [self defaultTemperatureUnit]) {
        if (unit > COOLTemperatureFahrenheit) {
            unit = COOLTemperatureCelcius;
        }
        [[NSUserDefaults standardUserDefaults] setObject:@(unit) forKey:COOLDefaultTemperatureUnitKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:COOLUserSettingsChangedNotification object:self];
    }
}

@end
