//
//  COOLForecast.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COOLForecast : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) NSString *weatherCondition;
@property (nonatomic, copy, readonly) NSURL *weatherConditionIconURL;
@property (nonatomic, copy, readonly) NSNumber *temperatureC;
@property (nonatomic, copy, readonly) NSNumber *temperatureF;

@end
