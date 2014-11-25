//
//  COOLForecast.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecast.h"

@interface COOLForecast ()

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, copy, readwrite) NSString *cityName;
@property (nonatomic, copy, readwrite) NSString *weatherCondition;
@property (nonatomic, copy, readwrite) NSURL *weatherConditionIconURL;
@property (nonatomic, copy, readwrite) NSNumber *temperatureC;
@property (nonatomic, copy, readwrite) NSNumber *temperatureF;

@end

@implementation COOLForecast

- (id)copyWithZone:(NSZone *)zone
{
    COOLForecast *copy = [[[self class] allocWithZone:zone] init];
    copy.date = _date;
    copy.cityName = _cityName;
    copy.weatherCondition = _weatherCondition;
    copy.weatherConditionIconURL = _weatherConditionIconURL;
    copy.temperatureC = _temperatureC;
    copy.temperatureF = _temperatureF;
    return copy;
}

@end
