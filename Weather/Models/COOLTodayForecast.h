//
//  COOLTodayForecast.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COOLTodayForecast : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) NSString *weatherCondition;
@property (nonatomic, copy, readonly) NSURL *weatherConditionIconURL;
@property (nonatomic, copy, readonly) NSNumber *temperatureC;
@property (nonatomic, copy, readonly) NSNumber *temperatureF;
@property (nonatomic, copy, readonly) NSNumber *chanceOfRain;
@property (nonatomic, copy, readonly) NSNumber *chanceOfSnow;
@property (nonatomic, copy, readonly) NSNumber *chanceOfThunder;
@property (nonatomic, copy, readonly) NSNumber *chanceOfSunshine;
@property (nonatomic, copy, readonly) NSNumber *humidity;
@property (nonatomic, copy, readonly) NSNumber *pressure;
@property (nonatomic, copy, readonly) NSNumber *precip;
@property (nonatomic, copy, readonly) NSString *windDirection;
@property (nonatomic, copy, readonly) NSNumber *windSpeedKmph;
@property (nonatomic, copy, readonly) NSNumber *windSpeedMiles;

@end
