//
//  COOLTodayForecast.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecast.h"

@interface COOLTodayForecast()

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, copy, readwrite) NSString *cityName;
@property (nonatomic, copy, readwrite) NSString *weatherCondition;
@property (nonatomic, copy, readwrite) NSURL *weatherConditionIconURL;
@property (nonatomic, copy, readwrite) NSNumber *temperatureC;
@property (nonatomic, copy, readwrite) NSNumber *temperatureF;
@property (nonatomic, copy, readwrite) NSNumber *chanceOfRain;
@property (nonatomic, copy, readwrite) NSNumber *chanceOfSnow;
@property (nonatomic, copy, readwrite) NSNumber *chanceOfThunder;
@property (nonatomic, copy, readwrite) NSNumber *chanceOfSunshine;
@property (nonatomic, copy, readwrite) NSNumber *humidity;
@property (nonatomic, copy, readwrite) NSNumber *pressure;
@property (nonatomic, copy, readwrite) NSNumber *precip;
@property (nonatomic, copy, readwrite) NSString *windDirection;
@property (nonatomic, copy, readwrite) NSNumber *windSpeedKmph;
@property (nonatomic, copy, readwrite) NSNumber *windSpeedMiles;

@end

@implementation COOLTodayForecast

- (instancetype)init
{
    self = [super init];
    if (self) {
        _date = [NSDate date];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    COOLTodayForecast *copy = [[[self class] allocWithZone:zone] init];
    copy.date = _date;
    copy.cityName = _cityName;
    copy.weatherCondition = _weatherCondition;
    copy.weatherConditionIconURL = _weatherConditionIconURL;
    copy.temperatureC = _temperatureC;
    copy.temperatureF = _temperatureF;
    copy.chanceOfRain = _chanceOfRain;
    copy.chanceOfSnow = _chanceOfSnow;
    copy.chanceOfThunder = _chanceOfThunder;
    copy.chanceOfSunshine = _chanceOfSunshine;
    copy.humidity = _humidity;
    copy.pressure = _pressure;
    copy.precip = _precip;
    copy.windDirection = _windDirection;
    copy.windSpeedKmph = _windSpeedKmph;
    copy.windSpeedMiles = _windSpeedMiles;
    return copy;
}

@end
