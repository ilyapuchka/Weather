//
//  COOLWeatherAPIImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLWeatherAPIImpl.h"
#import "COOLWeatherAPIRequests.h"

@implementation COOLWeatherAPIImpl

- (NSURLSessionDataTask *)searchCitiesWithQuery:(NSString *)query success:(COOLWeatherAPISearchSuccessBlock)succes failure:(COOLAPIClientFailureBlock)failure
{
    COOLSearchAPIRequest *request = [[COOLSearchAPIRequest alloc] initWithQuery:query];
    return [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)succes failure:failure];
}

- (NSURLSessionDataTask *)todayWeatherWithQuery:(NSString *)query success:(COOLWeatherAPITodayForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLTodayForecastAPIRequest *request = [[COOLTodayForecastAPIRequest alloc] initWithQuery:query];
    return [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)success failure:failure];
}

- (NSURLSessionDataTask *)daylyWeatherWithQuery:(NSString *)query days:(NSInteger)days success:(COOLWeatherAPIDailyForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLDailyForecastAPIRequest *request = [[COOLDailyForecastAPIRequest alloc] initWithQuery:query days:days];
    return [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)success failure:failure];
}

- (NSURLSessionDataTask *)weatherWithBatchQuery:(NSArray *)queries success:(COOLWeatherAPIBatchForecastsSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    return nil;
}

@end
