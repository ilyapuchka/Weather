//
//  ForecastForLocation.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "ForecastForLocation.h"
#import "Forecast.h"
#import "Location.h"

@interface ForecastForLocation()

@property (nonatomic, copy, readwrite) Forecast *forecast;
@property (nonatomic, copy, readwrite) Location *location;

@end

@implementation ForecastForLocation

- (instancetype)initWithForecast:(Forecast *)forecast location:(Location *)location
{
    self = [super init];
    if (self) {
        _forecast = [forecast copy];
        _location = [location copy];
    }
    return self;
}

@end
