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

#import "Location.h"

@interface COOLForecastDataSourceImpl()

@property (nonatomic, strong) id<COOLWeatherAPI> apiClient;

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
    [self loadDailyForecastWithQuery:self.query days:self.days];
}

- (NSURLSessionDataTask *)loadDailyForecastWithQuery:(Location *)query days:(NSInteger)days
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient daylyWeatherWithQuery:[query displayName] days:days success:^(COOLDailyForecastAPIResponse *response) {
            [self completeLoadingWithTask:task response:response loadingProcess:loadingProcess];
        } failure:^(id<COOLAPIResponse> response) {
            [self completeLoadingWithTask:task response:response loadingProcess:loadingProcess];
        }];
    }];
    return task;
}

- (Forecast *)dailyForecast
{
    return self.response.forecast;
}

- (void)resetContent
{
    self.response = nil;
    [super resetContent];
}

- (NSString *)missingTransitionFromState:(NSString *)fromState toState:(NSString *)toState
{
    if ([toState isEqualToString:COOLStateUndefined]) {
        if (self.dailyForecast) {
            return COOLLoadingStateRefreshingContent;
        }
        else {
            return COOLLoadingStateLoadingContent;
        }
    }
    return toState;
}

@end
