//
//  COOLTodayForecast.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecast.h"

@interface COOLCurrentCondition()

@property (nonatomic, copy, readwrite) NSString *windDirection;
@property (nonatomic, copy, readwrite) NSString *windSpeedKmph;
@property (nonatomic, copy, readwrite) NSString *windSpeedMiles;
@property (nonatomic, copy, readwrite) NSString *temperatureC;
@property (nonatomic, copy, readwrite) NSString *temperatureF;
@property (nonatomic, copy, readwrite) NSString *pressure;
@property (nonatomic, copy, readwrite) NSString *precip;
@property (nonatomic, copy, readwrite) NSString *humidity;
@property (nonatomic, copy, readwrite) NSString *weatherCondition;

@end

@implementation COOLCurrentCondition

- (id)copyWithZone:(NSZone *)zone
{
    COOLCurrentCondition *copy = [[[self class] allocWithZone:zone] init];
    copy.windDirection = _windDirection;
    copy.windSpeedMiles = _windSpeedMiles;
    copy.windSpeedKmph = _windSpeedKmph;
    copy.temperatureC = _temperatureC;
    copy.temperatureF = _temperatureF;
    copy.pressure = _pressure;
    copy.precip = _precip;
    copy.humidity = _humidity;
    copy.weatherCondition = _weatherCondition;
    return copy;
}

@end

#pragma mark -

@interface COOLTodayForecastWeatherHourly()

@property (nonatomic, copy, readwrite) NSString *chanceOfRain;
@property (nonatomic, copy, readwrite) NSString *chanceOfSnow;
@property (nonatomic, copy, readwrite) NSString *chanceOfThunder;
@property (nonatomic, copy, readwrite) NSString *chanceOfSunshine;

@end

@implementation COOLTodayForecastWeatherHourly

- (id)copyWithZone:(NSZone *)zone
{
    COOLTodayForecastWeatherHourly *copy = [[[self class] allocWithZone:zone] init];
    copy.chanceOfRain = _chanceOfRain;
    copy.chanceOfSnow = _chanceOfSnow;
    copy.chanceOfThunder = _chanceOfThunder;
    copy.chanceOfSunshine = _chanceOfSunshine;
    return copy;
}

@end

#pragma mark -

@interface COOLTodayForecastWeather()

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, copy, readwrite) COOLTodayForecastWeatherHourly *hourly;

@end

@implementation COOLTodayForecastWeather

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
    COOLTodayForecastWeather *copy = [[[self class] allocWithZone:zone] init];
    copy.date = _date;
    copy.hourly = _hourly;
    return copy;
}

@end

#pragma mark -

@interface COOLTodayForecast()

@property (nonatomic, copy, readwrite) NSString *cityName;
@property (nonatomic, copy, readwrite) COOLCurrentCondition *currentCondition;
@property (nonatomic, copy, readwrite) COOLTodayForecastWeather *weather;

@end

@implementation COOLTodayForecast

- (id)copyWithZone:(NSZone *)zone
{
    COOLTodayForecast *copy = [[[self class] allocWithZone:zone] init];
    copy.cityName = _cityName;
    copy.weather = _weather;
    copy.currentCondition = _currentCondition;
    return copy;
}

@end
