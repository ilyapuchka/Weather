//
//  COOLForecastDataSourceImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastDataSourceImpl.h"
#import "COOLWeatherAPI.h"
#import "COOLDailyForecastAPIResponse.h"
#import "COOLTodayForecastAPIResponse.h"

@interface COOLForecastDataSourceImpl()

@property (nonatomic, strong) id<COOLWeatherAPI> apiClient;
@property (nonatomic, copy) Forecast *dailyForecast;
@property (nonatomic, copy) Forecast *todayForecast;

@end

@implementation COOLForecastDataSourceImpl

@synthesize query = _query;
@synthesize days = _days;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.onContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"Forecast loaded");
        };
        self.onNoContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"No forecast");
        };
        self.onErrorBlock = ^ void(COOLDataSource *me){
            NSLog(@"Forecast error");
        };
    }
    return self;
}

- (void)loadContent
{
    NSCParameterAssert(self.query);
    NSParameterAssert(self.days);
    [self loadForecastWithQuery:self.query days:self.days];
}

- (NSURLSessionDataTask *)loadForecastWithQuery:(NSString *)query days:(NSInteger)days
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient daylyWeatherWithQuery:query days:days success:^(COOLDailyForecastAPIResponse *response) {
            self.dailyForecast = response.forecast;
            [self completeLoadingWithTask:task response:response];
        } failure:^(COOLAPIResponse *response) {
            self.dailyForecast = nil;
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (NSURLSessionDataTask *)loadTodayForecastWithQuery:(NSString *)query
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient todayWeatherWithQuery:query success:^(COOLTodayForecastAPIResponse *response) {
            self.todayForecast = response.todayForecast;
            [self completeLoadingWithTask:task response:response];
        } failure:^(COOLAPIResponse *response) {
            self.todayForecast = nil;
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (void)resetContent
{
    self.dailyForecast = nil;
    self.todayForecast = nil;
    [super resetContent];
}

@end
