//
//  COOLForecastTableViewCellModel.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLUnits.h"

@class Forecast;
@class Weather;
@class Location;
@protocol COOLForecastTableViewCellPresentation;
@protocol COOLUserSettingsRepository;

@interface COOLForecastTableViewCellModel : NSObject

- (instancetype)initWithWeather:(Weather *)weather
                        setting:(id<COOLUserSettingsRepository>)settings;

- (instancetype)initWithDailyForecast:(Forecast *)forecast
                          forLocation:(Location *)location
                    isCurrentLocation:(BOOL)isCurrentLocation
                              setting:(id<COOLUserSettingsRepository>)settings;

- (UIImage *)weatherIconImage;
- (NSAttributedString *)titleString;
- (NSString *)subtitleString;
- (NSString *)temperatureString;

@end
