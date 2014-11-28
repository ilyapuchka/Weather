//
//  COOLTableself.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayViewModel.h"
#import "Forecast.h"
#import "Weather.h"
#import "Hourly.h"
#import "WeatherDesc.h"
#import "Location.h"
#import "TimeZone.h"

#import "COOLTodayViewPresentation.h"
#import "COOLUserSettingsRepository.h"

@interface COOLTodayViewModel()

@property (nonatomic, copy) Forecast *forecast;
@property (nonatomic, copy) Location *location;
@property (nonatomic, assign) BOOL isCurrentLocation;
@property (nonatomic, strong) Hourly *currentHourly;

@end

@implementation COOLTodayViewModel

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
    static NSDictionary *dict;
    if (!dict) {
        dict = @{
                 @"sun": @"Sun_Big",
                 @"cloud": @"Cloudy_Big",
                 @"wind": @"Wind_Big",
                 @"thunder": @"Lightning_Big"
                 };
        
    }
    NSString *weatherDesc = [[(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value] lowercaseString];
    __block NSString *imageName = @"Cloudy_Big";
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([weatherDesc rangeOfString:key].location != NSNotFound) {
            imageName = obj;
            *stop = YES;
        }
    }];
    return [UIImage imageNamed:imageName];
}

- (NSAttributedString *)locationString
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    if (self.isCurrentLocation) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"Current"];
        [attrString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
        [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[self.location displayName]]];
    return [attrString copy];
}

- (NSAttributedString *)weatherDescStringWithUnit:(COOLTemperatureUnit)tempUnit
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    switch (tempUnit) {
        case COOLTemperatureFahrenheit:
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°F ", self.currentHourly.tempF]]];
            break;
            
        default:
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°C ", self.currentHourly.tempC]]];
            break;
    }
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"Line-blue-devider"];
    textAttachment.bounds = CGRectMake(0, 0, textAttachment.image.size.width, textAttachment.image.size.height);
    textAttachment.bounds = CGRectOffset(textAttachment.bounds, 0, -2);

    [attrString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];

    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value]]]];
    return [attrString copy];
}

- (NSString *)chanceOfRainString
{
    NSDictionary *chances = @{@"CR": @([self.currentHourly.chanceofrain integerValue]),
                              @"CS": @([self.currentHourly.chanceofsunshine integerValue]),
                              @"CL": @([self.currentHourly.chanceofthunder integerValue])};
    NSNumber *chance = [chances.allValues valueForKeyPath:@"@max.self"];
    return [NSString stringWithFormat:@"%@%%", chance];
}

- (UIImage *)chanceOfRainIcon
{
    NSDictionary *chances = @{@"CR": @([self.currentHourly.chanceofrain integerValue]),
                              @"CS": @([self.currentHourly.chanceofsunshine integerValue]),
                              @"CL": @([self.currentHourly.chanceofthunder integerValue])};
    NSNumber *chance = [chances.allValues valueForKeyPath:@"@max.self"];
    NSString *imageName = [[chances allKeysForObject:chance] lastObject];
    return [UIImage imageNamed:imageName];
}

- (NSString *)precipString
{
    return [NSString stringWithFormat:@"%@ mm", self.currentHourly.precipMM];
}

- (NSString *)pressureString
{
    return [NSString stringWithFormat:@"%@ hPa", self.currentHourly.pressure];
}

- (NSString *)windSpeedStringWithUnit:(COOLDistanceUnit)distanceUnit
{
    NSString *unitString;
    switch (distanceUnit) {
        case COOLDistanceMiles:
            unitString = @"m/h";
            break;
        default:
            unitString = @"km/h";
            break;
    }
    return [NSString stringWithFormat:@"%@ %@", self.currentHourly.windspeedKmph, unitString];
}

- (NSString *)windDirectionString
{
    return self.currentHourly.winddir16Point;
}

- (void)setup:(id<COOLTodayViewPresentation>)view setting:(id<COOLUserSettingsRepository>)settings
{
    view.weatherIconImageView.image = self.weatherIconImage;
    view.locationLabel.attributedText = self.locationString;
    view.weatherDescLabel.attributedText = [self weatherDescStringWithUnit:[settings defaultTemperatureUnit]];
    view.chanceOfRainLabel.text = self.chanceOfRainString;
    view.chanceOfRainIcon.image = self.chanceOfRainIcon;
    view.precipLabel.text = self.precipString;
    view.pressureLabel.text = self.pressureString;
    view.windSpeedLabel.text = [self windSpeedStringWithUnit:[settings defaultDistanceUnit]];
    view.windDirectionLabel.text = self.windDirectionString;
}

#pragma mark - Private

- (Hourly *)currentHourly
{
    if (!_currentHourly) {
        Weather *weather = [self.forecast.weather lastObject];
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSDate *date = [dateFormatter dateFromString:[(TimeZone *)self.forecast.timeZone.lastObject localtime]];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date];
        NSInteger hour = [components hour];
        NSString *hourString = [NSString stringWithFormat:@"%li00", (long)hour];
        NSInteger idx;
        for (idx = 0; idx < weather.hourly.count; idx++) {
            Hourly *hourly = weather.hourly[idx];
            NSComparisonResult result = [hourly.time compare:hourString options:NSNumericSearch];
            if (result == NSOrderedDescending) {
                break;
            }
        }
        _currentHourly = [weather.hourly objectAtIndex:MIN(MAX(0, idx - 1), weather.hourly.count - 1)];
    }
    return _currentHourly;
}

@end
