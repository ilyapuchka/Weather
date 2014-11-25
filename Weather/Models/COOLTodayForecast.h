//
//  COOLTodayForecast.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COOLCurrentCondition : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *windDirection;
@property (nonatomic, copy, readonly) NSString *windSpeedKmph;
@property (nonatomic, copy, readonly) NSString *windSpeedMiles;
@property (nonatomic, copy, readonly) NSString *temperatureC;
@property (nonatomic, copy, readonly) NSString *temperatureF;
@property (nonatomic, copy, readonly) NSString *pressure;
@property (nonatomic, copy, readonly) NSString *precip;
@property (nonatomic, copy, readonly) NSString *humidity;
@property (nonatomic, copy, readonly) NSString *weatherCondition;

@end

@interface COOLTodayForecastWeatherHourly : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *chanceOfRain;
@property (nonatomic, copy, readonly) NSString *chanceOfSnow;
@property (nonatomic, copy, readonly) NSString *chanceOfThunder;
@property (nonatomic, copy, readonly) NSString *chanceOfSunshine;

@end

@interface COOLTodayForecastWeather : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) COOLTodayForecastWeatherHourly *hourly;

@end

@interface COOLTodayForecast : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) COOLCurrentCondition *currentCondition;
@property (nonatomic, copy, readonly) COOLTodayForecastWeather *weather;

@end
