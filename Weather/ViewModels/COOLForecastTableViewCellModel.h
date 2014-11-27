//
//  COOLForecastTableViewCellModel.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Weather;
@class Location;

@interface COOLForecastTableViewCellModel : NSObject

- (instancetype)initWithDailyWeather:(Weather *)forecast;

- (instancetype)initWithDailyWeather:(Weather *)forecast
                         forLocation:(Location *)location
                   isCurrentLocation:(BOOL)isCurrentLocation;

- (UIImage *)weatherIconImage;
- (NSAttributedString *)titleString;
- (NSString *)subtitleString;
- (NSString *)temperatureString;

@end
