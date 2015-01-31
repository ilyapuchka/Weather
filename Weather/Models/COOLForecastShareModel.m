//
//  COOLForecastShareModel.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastShareModel.h"

#import "Forecast.h"
#import "Weather.h"
#import "Location.h"
#import "WeatherDesc.h"
#import "Hourly.h"

#import "COOLUserSettingsRepository.h"

@interface COOLForecastShareModel()

@property (nonatomic, copy) NSString *shareText;

@end

@implementation COOLForecastShareModel

- (instancetype)initWithForecast:(Forecast *)forecast location:(Location *)location settings:(id<COOLUserSettingsRepository>)settings
{
    self = [super init];
    if (self) {
        NSMutableArray *comps = [@[] mutableCopy];
        void(^block)(NSString *) = ^ void(NSString *str){
            if (str.length > 0) [comps addObject:str];
        };
        block([self locationString:location]);
        block([self date:forecast]);
        block([self temperatureString:forecast setting:settings]);
        block([self weatherDesc:forecast]);
        self.shareText = [comps componentsJoinedByString:@", "];
    }
    return self;
}

- (NSString *)locationString:(Location *)location
{
    NSString *locationString = [location displayName];
    return locationString;
}

- (NSString *)date:(Forecast *)forecast
{
    NSString *date = [(Weather *)forecast.weather.lastObject date];
    return date;
}

- (NSString *)weatherDesc:(Forecast *)forecast
{
    NSString *weatherDesc = [(WeatherDesc *)forecast.currentHourly.localizedWeatherDesc.lastObject value];
    return weatherDesc;
}

- (NSString *)temperatureString:(Forecast *)forecast setting:(id<COOLUserSettingsRepository>)settings
{
    NSString *tempString;
    switch ([settings defaultTemperatureUnit]) {
        case COOLTemperatureFahrenheit:
            tempString = [NSString stringWithFormat:@"%@ %@", forecast.currentHourly.tempF, NSLocalizedStringFromTable(@"Fahrenheit", @"Units", nil)];
            break;
            
        default:
            tempString = [NSString stringWithFormat:@"%@ %@", forecast.currentHourly.tempC, NSLocalizedStringFromTable(@"Celsius", @"Units", nil)];
            break;
    }
    return tempString;
}

@end
