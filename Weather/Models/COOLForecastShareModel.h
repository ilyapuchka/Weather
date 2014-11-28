//
//  COOLForecastShareModel.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Forecast;
@class Location;
@protocol COOLUserSettingsRepository;

@interface COOLForecastShareModel : NSObject

- (instancetype)initWithForecast:(Forecast *)forecast
                        location:(Location *)location
                        settings:(id<COOLUserSettingsRepository>)settings;

- (NSString *)shareText;

@end
