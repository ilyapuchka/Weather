//
//  COOLTodayDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLComposedDataSource.h"
#import <CoreLocation/CoreLocation.h>

@class ForecastForLocation;
@class Location;

@protocol COOLForecastDataSource;
@protocol COOLLocationsDataSource;

@interface COOLTodayDataSourceImpl : COOLComposedDataSource <COOLDataSourceDelegate>

@property (nonatomic, strong) id<COOLForecastDataSource> forecastDataSource;
@property (nonatomic, strong) id<COOLLocationsDataSource> locationsDataSource;

@property (nonatomic, copy) CLLocation *clLocation;
@property (nonatomic, copy) Location *location;

- (void)loadForecastForCLLocation:(CLLocation *)location;
- (void)loadForecastForLocation:(Location *)location;

- (ForecastForLocation *)forecastForLocation;

@end
