//
//  COOLForecast.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COOLForecastWeatherHourly : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *weatherCondition;
@property (nonatomic, copy, readonly) NSString *temperatureC;
@property (nonatomic, copy, readonly) NSString *temperatureF;

@end

@interface COOLForecastWeather : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) COOLForecastWeatherHourly *hourly;

@end

@interface COOLForecast : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) NSArray *weatherByDay;

@end
