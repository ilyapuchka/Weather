//
//  COOLForecastComposedDataSourceImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastComposedDataSourceImpl.h"
#import "COOLForecastDataSource.h"
#import "ForecastForLocation.h"
#import "Forecast.h"
#import "Location.h"
#import "Typhoon.h"
#import "NetworkComponents.h"

@interface COOLForecastComposedDataSourceImpl()

@property (nonatomic, copy) NSArray *forecasts;

@end

@implementation COOLForecastComposedDataSourceImpl

@synthesize queries = _queries;
@synthesize days = _days;

- (instancetype)initWithDataSources:(NSArray *)dataSources
{
    self = [super initWithDataSources:dataSources];
    if (self) {
        self.onContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"Forecasts for selected places loaded");
        };
        self.onNoContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"No forecasts for selected places");
        };
        self.onErrorBlock = ^ void(COOLDataSource *me){
            NSLog(@"Forecasts for selected places error");
        };
    }
    return self;
}

- (void)setQueries:(NSArray *)queries
{
    _queries = [queries copy];
    self.dataSources = nil;
}

- (COOLComposition *)dataSources
{
    if (!_dataSources) {
        NSMutableArray *array = [@[] mutableCopy];
        NetworkComponents *factory = [TyphoonBlockComponentFactory factoryWithAssembly:[NetworkComponents new]];
        for (Location *location in self.queries) {
            id<COOLForecastDataSource> dataSource = [factory forecastDataSource];
            dataSource.query = location;
            dataSource.delegate = self;
            [array addObject:dataSource];
        }
        _dataSources = [[COOLComposition alloc] initWithArray:array];
    }
    return _dataSources;
}

- (NSArray *)forecasts
{
    if (!_forecasts && self.queries) {
        NSMutableArray *array = [@[] mutableCopy];
        for (Location *location in self.queries) {
            ForecastForLocation *forecastForLocation = [[ForecastForLocation alloc] initWithForecast:nil location:location];
            [array addObject:forecastForLocation];
        }
        _forecasts = [array copy];
    }
    return _forecasts;
}

- (void)loadContent
{
    [self loadDailyForecastsWithQueries:self.queries days:self.days];
}

- (void)loadDailyForecastsWithQueries:(NSArray *)queries days:(NSInteger)days
{
    [self resetContent];
    
    self.queries = queries;
    NSAssert([queries count] == [self.dataSources count], @"Queries array should be the same size as datasources array");
    
    [self loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        for (NSInteger idx = 0; idx < [self.dataSources count]; idx++) {
            id<COOLForecastDataSource> dataSource = self.dataSources[idx];
            [dataSource loadDailyForecastWithQuery:dataSource.query days:1];
        }
    }];
}

- (void)resetContent
{
    self.forecasts = nil;
    [super resetContent];
}

- (NSString *)missingTransitionFromState:(NSString *)fromState toState:(NSString *)toState
{
    if ([toState isEqualToString:COOLStateUndefined]) {
        if (self.forecasts) {
            return COOLLoadingStateRefreshingContent;
        }
        else {
            return COOLLoadingStateLoadingContent;
        }
    }
    return toState;
}

- (void)dataSource:(COOLDataSource<COOLForecastDataSource> *)dataSource didLoadContentWithError:(NSError *)error
{
    [self updateDataSourceForecast:dataSource];
    [super dataSource:dataSource didLoadContentWithError:error];
}

- (void)updateDataSourceForecast:(id<COOLForecastDataSource>)dataSource
{
    if ([dataSource dailyForecast]) {
        NSMutableArray *array = [self.forecasts?:@[] mutableCopy];
        ForecastForLocation *forecastForLocation = [[ForecastForLocation alloc] initWithForecast:[dataSource dailyForecast] location:[dataSource query]];
        NSInteger idx = [self.dataSources indexOfObject:dataSource];
        array[idx] = forecastForLocation;
        self.forecasts = array;
    }
}

@end
