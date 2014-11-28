//
//  INTULocationManager+Extensions.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "INTULocationManager+Extensions.h"

@implementation INTULocationManager (Extensions)

@dynamic currentLocation;

- (BOOL)needsUpdateCurrentLocation
{
    return (!self.currentLocation ||
            [self.currentLocation.timestamp timeIntervalSinceDate:[NSDate date]] > 10 * 60);
}

@end
