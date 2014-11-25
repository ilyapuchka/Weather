//
//  COOLBatchForecastsAPIResponse.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponse.h"
#import "COOLForecast.h"

@interface COOLBatchForecastsAPIResponse : COOLAPIResponse

- (NSArray *)forecasts;

@end
