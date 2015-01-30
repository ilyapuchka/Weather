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

- (NSURLSessionDataTask *)searchCitiesWithQuery:(NSString *)query success:(COOLWeatherAPISearchSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLSearchAPIRequest *request = [[COOLSearchAPIRequest alloc] initWithQuery:query];
    return [self dataTaskWithAPIRequest:request success:success failure:failure];
}

- (NSURLSessionDataTask *)searchCitiesWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude success:(COOLWeatherAPISearchSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLSearchAPIRequest *request = [[COOLSearchAPIRequest alloc] initWithLatitude:latitude longitude:longitude];
    return [self dataTaskWithAPIRequest:request success:success failure:failure];
}

- (NSURLSessionDataTask *)daylyWeatherWithQuery:(NSString *)query days:(NSInteger)days success:(COOLWeatherAPIDailyForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    COOLDailyForecastAPIRequest *request = [[COOLDailyForecastAPIRequest alloc] initWithQuery:query days:days];
    return [self dataTaskWithAPIRequest:request success:success failure:failure];
}

@end
