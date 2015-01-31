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

#import "UIImage+Weather.h"

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
    NSString *weatherDesc = [[(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value] lowercaseString];
    return [UIImage weatherIconImage:weatherDesc];
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
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ ", self.currentHourly.tempF, NSLocalizedStringFromTable(@"Fahrenheit", @"Units", nil)]]];
            break;
            
        default:
            [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ ", self.currentHourly.tempC, NSLocalizedStringFromTable(@"Celsius", @"Units", nil)]]];
            break;
    }
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"Line-blue-devider"];
    textAttachment.bounds = CGRectMake(0, 0, textAttachment.image.size.width, textAttachment.image.size.height);
    textAttachment.bounds = CGRectOffset(textAttachment.bounds, 0, -4);

    [attrString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];

    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [(WeatherDesc *)self.currentHourly.localizedWeatherDesc.lastObject value]]]];
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
    return [NSString stringWithFormat:@"%@ %@", self.currentHourly.precipMM, NSLocalizedStringFromTable(@"Millimeters", @"Units", nil)];
}

- (NSString *)pressureString
{
    return [NSString stringWithFormat:@"%@ %@", self.currentHourly.pressure, NSLocalizedStringFromTable(@"Pressure", @"Units", nil)];
}

- (NSString *)windSpeedStringWithUnit:(COOLDistanceUnit)distanceUnit
{
    NSString *unitString;
    switch (distanceUnit) {
        case COOLDistanceMiles:
            unitString = NSLocalizedStringFromTable(@"Speed in miles", @"Units", nil);
            break;
        default:
            unitString = NSLocalizedStringFromTable(@"Speed in kilometres", @"Units", nil);
            break;
    }
    return [NSString stringWithFormat:@"%@ %@", self.currentHourly.windspeedKmph, unitString];
}

- (NSString *)windDirectionString
{
    return NSLocalizedStringFromTable(self.currentHourly.winddir16Point, @"Units", nil);
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
        _currentHourly = self.forecast.currentHourly;
    }
    return _currentHourly;
}

@end
