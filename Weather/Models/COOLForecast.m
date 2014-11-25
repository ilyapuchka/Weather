//
//  COOLForecast.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecast.h"

@interface COOLForecastWeatherHourly()

@property (nonatomic, copy, readwrite) NSString *weatherCondition;
@property (nonatomic, copy, readwrite) NSString *temperatureC;
@property (nonatomic, copy, readwrite) NSString *temperatureF;

@end

@implementation COOLForecastWeatherHourly

- (id)copyWithZone:(NSZone *)zone
{
    COOLForecastWeatherHourly *copy = [[[self class] allocWithZone:zone] init];
    copy.weatherCondition = _weatherCondition;
    copy.temperatureC = _temperatureC;
    copy.temperatureF = _temperatureF;
    return copy;
}

@end

@interface COOLForecastWeather()

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, copy, readwrite) COOLForecastWeatherHourly *hourly;

@end

@implementation COOLForecastWeather

- (id)copyWithZone:(NSZone *)zone
{
    COOLForecastWeather *copy = [[[self class] allocWithZone:zone] init];
    copy.date = _date;
    copy.hourly = _hourly;
    return copy;
}

@end

@interface COOLForecast ()

@property (nonatomic, copy, readwrite) NSString *cityName;
@property (nonatomic, copy, readwrite) NSArray *weatherByDay;

@end

@implementation COOLForecast

- (id)copyWithZone:(NSZone *)zone
{
    COOLForecast *copy = [[[self class] allocWithZone:zone] init];
    copy.cityName = _cityName;
    copy.weatherByDay = _weatherByDay;
    return copy;
}

@end
