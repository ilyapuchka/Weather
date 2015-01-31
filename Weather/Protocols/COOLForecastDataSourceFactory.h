//
//  COOLForecastDataSourceFactory.h
//  Weather
//
//  Created by Ilya Puchka on 31.01.15.
//  Copyright (c) 2015 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COOLForecastDataSource;

@protocol COOLForecastDataSourceFactory <NSObject>

- (id<COOLForecastDataSource>)forecastDataSource;

@end
