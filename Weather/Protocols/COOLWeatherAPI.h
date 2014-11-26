//
//  COOLWeatherAPI.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLAPIClientBlocks.h"

@class COOLSearchAPIResponse;
@class COOLTodayForecastAPIResponse;
@class COOLBatchForecastsAPIResponse;
@class COOLDailyForecastAPIResponse;

typedef void(^COOLWeatherAPISearchSuccessBlock)(COOLSearchAPIResponse *response);
typedef void(^COOLWeatherAPITodayForecastSuccessBlock)(COOLTodayForecastAPIResponse *response);
typedef void(^COOLWeatherAPIDailyForecastSuccessBlock)(COOLDailyForecastAPIResponse *response);
typedef void(^COOLWeatherAPIBatchForecastsSuccessBlock)(COOLBatchForecastsAPIResponse *response);


@protocol COOLWeatherAPI <NSObject>

- (void)searchCitiesWithQuery:(NSString *)query
                      success:(COOLWeatherAPISearchSuccessBlock)succes
                      failure:(COOLAPIClientFailureBlock)failure;

- (void)todayWeatherWithQuery:(NSString *)query
                      success:(COOLWeatherAPITodayForecastSuccessBlock)success
                      failure:(COOLAPIClientFailureBlock)failure;

- (void)daylyWeatherWithQuery:(NSString *)query
                         days:(NSInteger)days
                      success:(COOLWeatherAPIDailyForecastSuccessBlock)success
                      failure:(COOLAPIClientFailureBlock)failure;

- (void)weatherWithBatchQuery:(NSArray *)queries
                      success:(COOLWeatherAPIBatchForecastsSuccessBlock)success
                      failure:(COOLAPIClientFailureBlock)failure;

@end
