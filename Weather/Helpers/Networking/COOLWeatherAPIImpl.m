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

- (void)searchCitiesWithQuery:(NSString *)query success:(COOLWeatherAPISearchSuccessBlock)succes failure:(COOLAPIClientFailureBlock)failure
{
    COOLSearchAPIRequest *request = [[COOLSearchAPIRequest alloc] initWithQuery:query];
    [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)succes failure:failure];
}

- (void)todayWeatherWithQuery:(NSString *)query success:(COOLWeatherAPITodayForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLTodayForecastAPIRequest *request = [[COOLTodayForecastAPIRequest alloc] initWithQuery:query];
    [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)success failure:failure];
}

- (void)daylyWeatherWithQuery:(NSString *)query days:(NSInteger)days success:(COOLWeatherAPIDailyForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLDailyForecastAPIRequest *request = [[COOLDailyForecastAPIRequest alloc] initWithQuery:query days:days];
    [self dataTaskWithRequest:request success:(COOLAPIClientSuccessBlock)success failure:failure];
}

- (void)weatherWithBatchQuery:(NSArray *)queries success:(COOLWeatherAPIBatchForecastsSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
}

@end
