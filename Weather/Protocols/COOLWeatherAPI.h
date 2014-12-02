//
//  COOLWeatherAPI.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLAPIClientBlocks.h"
#import "COOLWeatherAPIResponses.h"

typedef void(^COOLWeatherAPISearchSuccessBlock)(COOLLocationsSearchAPIResponse *response);
typedef void(^COOLWeatherAPIDailyForecastSuccessBlock)(COOLDailyForecastAPIResponse *response);

@protocol COOLWeatherAPI <NSObject>

- (NSURLSessionDataTask *)searchCitiesWithQuery:(NSString *)query
                                        success:(COOLWeatherAPISearchSuccessBlock)succes
                                        failure:(COOLAPIClientFailureBlock)failure;

- (NSURLSessionDataTask *)searchCitiesWithLatitude:(CGFloat)latitude
                                         longitude:(CGFloat)longitude
                                           success:(COOLWeatherAPISearchSuccessBlock)succes
                                           failure:(COOLAPIClientFailureBlock)failure;

- (NSURLSessionDataTask *)daylyWeatherWithQuery:(NSString *)query
                                           days:(NSInteger)days
                                        success:(COOLWeatherAPIDailyForecastSuccessBlock)success
                                        failure:(COOLAPIClientFailureBlock)failure;

@end
