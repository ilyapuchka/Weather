//
//  COOLForecastsDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLDataSourceDelegate.h"

@class Forecast;

@protocol COOLForecastDataSource <NSObject>

@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

@property (nonatomic, copy) NSString *query;
@property (nonatomic, assign) NSInteger days;

- (NSURLSessionDataTask *)loadTodayForecastWithQuery:(NSString *)query;
- (NSURLSessionDataTask *)loadForecastWithQuery:(NSString *)query days:(NSInteger)days;

- (Forecast *)dailyForecast;
- (Forecast *)todayForecast;

@end
