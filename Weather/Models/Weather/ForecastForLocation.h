//
//  ForecastForLocation.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@class Forecast;
@class Location;

@interface ForecastForLocation : MTLModel

- (instancetype)initWithForecast:(Forecast *)forecast location:(Location *)location;

@property (nonatomic, copy, readonly) Forecast *forecast;
@property (nonatomic, copy, readonly) Location *location;

@end
