//
//  COOLTableViewModel.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTableViewModel.h"
#import "Forecast.h"
#import "Weather.h"
#import "Hourly.h"
#import "WeatherDesc.h"
#import "Location.h"

@interface COOLTableViewModel()

@property (nonatomic, copy) Forecast *forecast;
@property (nonatomic, copy) Location *location;
@property (nonatomic, assign) BOOL isCurrentLocation;
@property (nonatomic, strong) Hourly *currentHourly;

@end

@implementation COOLTableViewModel

- (instancetype)initWithForecast:(Forecast *)forecast location:(Location *)location isCurrentLocation:(BOOL)isCurrentLocation
{
    self = [super init];
    if (self) {
        self.forecast = forecast;
        self.location = location;
        self.isCurrentLocation = isCurrentLocation;
    }
    return self;
}

- (UIImage *)weatherIconImage
{
    return [UIImage imageNamed:@"Sun_Big"];
}

- (NSAttributedString *)locationString
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[self.location displayName]]];
    return [attrString copy];
}

- (NSAttributedString *)weatherDescString
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°C ", self.currentHourly.tempC]]];
    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value]]]];
    return [attrString copy];
}

- (NSString *)chanceOfRainString
{
#warning TODO: select max chance of rain, snow, etc
    return [NSString stringWithFormat:@"%@%%", self.currentHourly.chanceofrain];
}

- (NSString *)precipString
{
    return [NSString stringWithFormat:@"%@ mm", self.currentHourly.precipMM];
}

- (NSString *)pressureString
{
    return [NSString stringWithFormat:@"%@ hPa", self.currentHourly.pressure];
}

- (NSString *)windSpeedString
{
#warning TODO: settings
    NSString *unit = @"km/h";
    return [NSString stringWithFormat:@"%@ %@", self.currentHourly.windspeedKmph, unit];
}

- (NSString *)windDirectionString
{
    return self.currentHourly.winddir16Point;
}

#pragma mark - Private

- (Hourly *)currentHourly
{
    if (!_currentHourly) {
        Weather *weather = [self.forecast.weather lastObject];
        NSDate *date = [NSDate date];
#warning TODO: find hourly for current time
        _currentHourly = [weather.hourly lastObject];
    }
    return _currentHourly;
}


@end
