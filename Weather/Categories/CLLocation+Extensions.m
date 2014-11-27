//
//  CLLocation+Extensions.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "CLLocation+Extensions.h"

@implementation CLLocation (Extensions)

- (BOOL)differsSignificantly:(CLLocation *)location
{
    return [self distanceFromLocation:location] > 1000;
}

- (BOOL)needsUpdate
{
    return self.timestamp == 0 || [[NSDate date] timeIntervalSinceDate:self.timestamp] > 10 * 60 * 0;
}

@end
