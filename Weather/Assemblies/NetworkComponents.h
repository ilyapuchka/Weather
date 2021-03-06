//
//  NetworkComponents.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "TyphoonAssembly.h"
#import "COOLForecastDataSourceFactory.h"

@protocol COOLWeatherAPI;
@protocol COOLForecastDataSource;
@protocol COOLLocationsDataSource;
@protocol COOLForecastComposedDataSource;

@interface NetworkComponents : TyphoonAssembly <COOLForecastDataSourceFactory>

- (id<COOLWeatherAPI>)apiClient;
- (id<COOLForecastDataSource>)forecastDataSource;
- (id<COOLForecastComposedDataSource>)forecastComposedDataSource;
- (id<COOLLocationsDataSource>)locationsDataSource;

@end
