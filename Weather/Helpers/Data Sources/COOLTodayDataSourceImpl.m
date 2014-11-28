//
//  COOLTodayDataSource.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayDataSourceImpl.h"
#import "COOLForecastDataSource.h"
#import "COOLLocationsDataSource.h"

#import "Location.h"
#import "ForecastForLocation.h"
#import "Forecast.h"

@interface COOLTodayDataSourceImpl()

@property (nonatomic, copy) ForecastForLocation *forecastForLocation;

@end

@implementation COOLTodayDataSourceImpl

- (void)setForecastDataSource:(id<COOLForecastDataSource>)forecastDataSource
{
    [self.composition removeObject:_forecastDataSource];
    _forecastDataSource = forecastDataSource;
    _forecastDataSource.delegate = self;
    [self.composition addObject:_forecastDataSource];
}

- (void)setLocationsDataSource:(id<COOLLocationsDataSource>)locationsDataSource
{
    [self.composition removeObject:_locationsDataSource];
    _locationsDataSource = locationsDataSource;
    _locationsDataSource.delegate = self;
    [self.composition addObject:_locationsDataSource];
}

- (void)loadContent
{
    if (self.location) {
        [self loadForecastForLocation:self.location];
    }
    else {
        [self loadForecastForCLLocation:self.clLocation];
    }
}

- (void)loadForecastForCLLocation:(CLLocation *)location
{
    [self loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        CLLocationCoordinate2D coords = self.clLocation.coordinate;
        [self.locationsDataSource loadLocationsWithLatitude:coords.latitude
                                                 longituted:coords.longitude];
    }];
}

- (void)loadForecastForLocation:(Location *)location
{
    [self loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        [self.locationsDataSource loadLocationsWithQuery:[location displayName]];
    }];
}

- (void)resetContent
{
    self.forecastForLocation = nil;
    [super resetContent];
}

- (void)dataSource:(COOLDataSource *)dataSource didLoadContentWithError:(NSError *)error
{
    if ((id<COOLLocationsDataSource>)dataSource == self.locationsDataSource) {
        Location *location = [[self.locationsDataSource locations] firstObject];
        [self.forecastDataSource setQuery:location];
        [self.forecastDataSource loadDailyForecastWithQuery:location days:1];
    }
    else {
        
    }
    
    [super dataSource:dataSource didLoadContentWithError:error];
}

@end
