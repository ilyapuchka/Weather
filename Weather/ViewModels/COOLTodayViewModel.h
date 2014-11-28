//
//  COOLTableViewModel.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLUnits.h"

@class Forecast;
@class Location;
@protocol COOLTodayViewPresentation;
@protocol COOLUserSettingsRepository;

@interface COOLTodayViewModel : NSObject

- (instancetype)initWithForecast:(Forecast *)forecast
                        location:(Location *)location
               isCurrentLocation:(BOOL)isCurrentLocation;

- (Forecast *)forecast;
- (Location *)location;

- (UIImage *)weatherIconImage;
- (NSAttributedString *)locationString;
- (NSAttributedString *)weatherDescStringWithUnit:(COOLTemperatureUnit)tempUnit;
- (NSString *)chanceOfRainString;
- (UIImage *)chanceOfRainIcon;
- (NSString *)precipString;
- (NSString *)pressureString;
- (NSString *)windSpeedStringWithUnit:(COOLDistanceUnit)distanceUnit;
- (NSString *)windDirectionString;

- (void)setup:(id<COOLTodayViewPresentation>)view
      setting:(id<COOLUserSettingsRepository>)settings;

@end
