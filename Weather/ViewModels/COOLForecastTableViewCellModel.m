//
//  COOLForecastTableViewCellModel.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastTableViewCellModel.h"
#import "Location.h"
#import "Forecast.h"
#import "WeatherDesc.h"
#import "Hourly.h"
#import "Weather.h"
#import "AreaName.h"
#import "TimeZone.h"

#import "COOLForecastTableViewCellPresentation.h"
#import "COOLUserSettingsRepository.h"

#import "UIImage+Weather.h"
#import "NSDate+Extensions.h"

@interface COOLForecastTableViewCellModel()

@property (nonatomic, copy) Location *location;
@property (nonatomic, copy) Forecast *forecast;
@property (nonatomic, copy) Weather *weather;
@property (nonatomic, copy) Hourly *currentHourly;
@property (nonatomic, assign) BOOL isCurrentLocation;

@end

@implementation COOLForecastTableViewCellModel

- (instancetype)initWithWeather:(Weather *)weather
{
    self = [super init];
    if (self) {
        _weather = weather;
    }
    return self;
}

- (instancetype)initWithDailyForecast:(Forecast *)forecast forLocation:(Location *)location isCurrentLocation:(BOOL)isCurrentLocation
{
    self = [self init];
    if (self) {
        _forecast = forecast;
        _location = location;
        _isCurrentLocation = isCurrentLocation;
    }
    return self;
}

- (UIImage *)weatherIconImage
{
    NSString *weatherDesc = [[(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value] lowercaseString];
    return [UIImage weatherIconImage:weatherDesc];
}

- (NSAttributedString *)titleString
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    if (self.location) {
        [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[(AreaName *)self.location.areaName.lastObject value]]];
        if (self.isCurrentLocation) {
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = [UIImage imageNamed:@"Current"];
            [attrString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
        }
    }
    else {
        NSString *dayString = [NSDate weekDayFromDateString:self.weather.date dateFormat:@"yyyy-MM-dd"];
        [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:dayString]];
    }
    return [attrString copy];
}

- (NSString *)subtitleString
{
    return [(WeatherDesc *)self.currentHourly.localizedWeatherDesc.lastObject value]?:@"--";
}

- (NSString *)temperatureStringWithUnit:(COOLTemperatureUnit)tempUnit
{
    NSString *tempString;
    switch (tempUnit) {
        case COOLTemperatureFahrenheit:
            tempString = self.currentHourly.tempF;
            break;
        default:
            tempString = self.currentHourly.tempC;
            break;
    }
    return tempString?[NSString stringWithFormat:@"%@°", tempString]:@"--";
}

- (void)setup:(id<COOLForecastTableViewCellPresentation>)view setting:(id<COOLUserSettingsRepository>)settings
{
    view.weatherIconImageView.image = self.weatherIconImage;
    view.titleLabel.attributedText = self.titleString;
    view.subtitleLabel.text = self.subtitleString;
    view.temperatureLabel.text = [self temperatureStringWithUnit:[settings defaultTemperatureUnit]];
}

#pragma mark - Private

- (Weather *)weather
{
    if (!_weather) {
        return self.forecast.weather.lastObject;
    }
    return _weather;
}

- (Hourly *)currentHourly
{
    if (!_currentHourly) {
        if (!self.forecast) {
            _currentHourly = self.weather.hourly.lastObject;
        }
        else {
            _currentHourly = self.forecast.currentHourly;
        }
    }
    return _currentHourly;
}

@end
