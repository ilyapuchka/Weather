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

#import "COOLForecastTableViewCell.h"

@interface COOLForecastTableViewCellModel()

@property (nonatomic, copy) Location *location;
@property (nonatomic, copy) Weather *dailyForecast;
@property (nonatomic, assign) BOOL isCurrentLocation;

@end

@implementation COOLForecastTableViewCellModel

- (instancetype)initWithDailyWeather:(Weather *)forecast
{
    self = [super init];
    if (self) {
        _dailyForecast = forecast;
    }
    return self;
}

- (instancetype)initWithDailyWeather:(Weather *)forecast forLocation:(Location *)location isCurrentLocation:(BOOL)isCurrentLocation
{
    self = [self initWithDailyWeather:forecast];
    if (self) {
        _location = location;
        _isCurrentLocation = isCurrentLocation;
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
        if ([weatherDesc containsString:key]) {
            imageName = obj;
            *stop = YES;
        }
    }];
    return [UIImage imageNamed:imageName];
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
        NSDate *date;
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
        }
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        date = [dateFormatter dateFromString:self.dailyForecast.date];
        dateFormatter.dateFormat = @"EEEE";
        NSString * dayString = [[dateFormatter stringFromDate:date] capitalizedString];
        [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:dayString]];
    }
    return [attrString copy];
}

- (NSString *)subtitleString
{
    return [(WeatherDesc *)self.currentHourly.weatherDesc.lastObject value];
}

- (NSString *)temperatureString
{
#warning TODO: settings
    return [NSString stringWithFormat:@"%@°", self.currentHourly.tempC];
}

- (Hourly *)currentHourly
{
    return self.dailyForecast.hourly.lastObject;
}

- (void)setup:(id<COOLForecastTableViewCellPresentation>)view
{
    view.weatherIconImageView.image = self.weatherIconImage;
    view.titleLabel.attributedText = self.titleString;
    view.subtitleLabel.text = self.subtitleString;
    view.temperatureLabel.text = self.temperatureString;
}


@end
