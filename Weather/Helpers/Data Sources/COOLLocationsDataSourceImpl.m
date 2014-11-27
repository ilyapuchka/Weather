//
//  COOLLocationsDataSourceImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsDataSourceImpl.h"
#import "COOLWeatherAPI.h"
#import "COOLSearchAPIResponse.h"

@interface COOLLocationsDataSourceImpl()

@property (nonatomic, strong) id<COOLWeatherAPI> apiClient;
@property (nonatomic, copy) NSArray *locations;

@end

@implementation COOLLocationsDataSourceImpl

@synthesize query = _query;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.onContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"Locations loaded");
        };
        self.onNoContentBlock = ^ void(COOLDataSource *me){
            NSLog(@"No locations");
        };
        self.onErrorBlock = ^ void(COOLDataSource *me){
            NSLog(@"Locations error");
        };
    }
    return self;
}

- (void)loadContent
{
    NSCParameterAssert(self.query);
    [self loadLocationsWithQuery:self.query];
}

- (NSURLSessionDataTask *)loadLocationsWithQuery:(NSString *)query
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient searchCitiesWithQuery:query success:^(COOLSearchAPIResponse *response) {
            self.locations = response.locations;
            [self completeLoadingWithTask:task response:response];
        } failure:^(COOLAPIResponse *response) {
            self.locations = nil;
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (NSURLSessionDataTask *)loadLocationsWithLatitude:(CGFloat)latitude longituted:(CGFloat)longitude
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient searchCitiesWithLatitude:latitude longitude:longitude success:^(COOLSearchAPIResponse *response) {
            self.locations = response.locations;
            [self completeLoadingWithTask:task response:response];
        } failure:^(COOLAPIResponse *response) {
            self.locations = nil;
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (void)resetContent
{
    self.locations = nil;
    [super resetContent];
}

- (NSString *)missingTransitionFromState:(NSString *)fromState toState:(NSString *)toState
{
    if ([toState isEqualToString:COOLStateUndefined]) {
        if (self.locations) {
            return COOLLoadingStateRefreshingContent;
        }
        else {
            return COOLLoadingStateLoadingContent;
        }
    }
    return toState;
}

@end
