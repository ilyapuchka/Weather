//
//  COOLWeatherAPIImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLWeatherAPIImpl.h"

@implementation COOLWeatherAPIImpl

- (void)searchCitiesWithQuery:(NSString *)query success:(COOLWeatherAPISearchSuccessBlock)succes failure:(COOLAPIClientFailureBlock)faulure
{
    
}

- (void)weatherWithQuery:(NSString *)query success:(COOLWeatherAPIForecastSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    
}

- (void)weatherWithBatchQuery:(NSArray *)queries success:(COOLWeatherAPIBatchForecastsSuccessBlock)success failure:(COOLAPIClientFailureBlock)failure
{
    
}

@end
