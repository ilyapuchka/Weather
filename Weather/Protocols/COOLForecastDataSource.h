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
@class Location;

@protocol COOLForecastDataSource <NSObject>

@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

@property (nonatomic, copy) Location *query;
@property (nonatomic, assign) NSInteger days;

- (NSURLSessionDataTask *)loadDailyForecastWithQuery:(Location *)query days:(NSInteger)days;

- (Forecast *)dailyForecast;

@end