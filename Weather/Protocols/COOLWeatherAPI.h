//
//  COOLWeatherAPI.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COOLSearchAPIResponse;
@class COOLForecastResponse;
@class COOLBatchForecastsAPIResponse;

typedef void(^COOLWeatherAPISearchSuccessBlock)(COOLSearchAPIResponse *response);
typedef void(^COOLWeatherAPIForecastSuccessBlock)(COOLForecastResponse *response);
typedef void(^COOLWeatherAPIBatchForecastsSuccessBlock)(COOLBatchForecastsAPIResponse *response);


@protocol COOLWeatherAPI <NSObject>

- (void)searchCitiesWithQuery:(NSString *)query
                      success:(COOLWeatherAPISearchSuccessBlock)succes
                      failure:(COOLAPIClientFailureBlock)faulure;

- (void)weatherWithQuery:(NSString *)query
                 success:(COOLWeatherAPIForecastSuccessBlock)success
                 failure:(COOLAPIClientFailureBlock)failure;

- (void)weatherWithBatchQuery:(NSArray *)queries
                      success:(COOLWeatherAPIBatchForecastsSuccessBlock)success
                      failure:(COOLAPIClientFailureBlock)failure;

@end
