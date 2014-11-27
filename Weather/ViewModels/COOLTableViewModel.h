//
//  COOLTableViewModel.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Forecast;
@class Location;

@interface COOLTableViewModel : UIView

- (instancetype)initWithForecast:(Forecast *)forecast
                        location:(Location *)location
               isCurrentLocation:(BOOL)isCurrentLocation;

- (UIImage *)weatherIconImage;
- (NSAttributedString *)locationString;
- (NSAttributedString *)weatherDescString;
- (NSString *)chanceOfRainString;
- (NSString *)precipString;
- (NSString *)pressureString;
- (NSString *)windSpeedString;
- (NSString *)windDirectionString;

@end
