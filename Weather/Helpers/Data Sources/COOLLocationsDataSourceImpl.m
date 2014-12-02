//
//  COOLLocationsDataSourceImpl.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsDataSourceImpl.h"
#import "COOLWeatherAPI.h"
#import "COOLLocationsSearchAPIResponse.h"

@interface COOLLocationsDataSourceImpl()

@property (nonatomic, strong) id<COOLWeatherAPI> apiClient;

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
        task = [self.apiClient searchCitiesWithQuery:query success:^(COOLLocationsSearchAPIResponse *response) {
            [self completeLoadingWithTask:task response:response];
        } failure:^(id<COOLAPIResponse> response) {
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (NSURLSessionDataTask *)loadLocationsWithLatitude:(CGFloat)latitude longituted:(CGFloat)longitude
{
    __block NSURLSessionDataTask *task;
    [super loadContentWithBlock:^(COOLLoadingProcess *loadingProcess) {
        task = [self.apiClient searchCitiesWithLatitude:latitude longitude:longitude success:^(COOLLocationsSearchAPIResponse *response) {
            [self completeLoadingWithTask:task response:response];
        } failure:^(COOLAPIResponse *response) {
            [self completeLoadingWithTask:task response:response];
        }];
    }];
    return task;
}

- (NSArray *)locations
{
    return self.response.locations;
}

- (void)resetContent
{
    self.response = nil;
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
