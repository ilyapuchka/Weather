//
//  COOLForecastDataSourceImpl.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIClientDataSource.h"
#import "COOLForecastDataSource.h"
#import "COOLDailyForecastAPIResponse.h"

@interface COOLForecastDataSourceImpl : COOLAPIClientDataSource <COOLForecastDataSource>

@property (nonatomic, strong) COOLDailyForecastAPIResponse *response;

@end
