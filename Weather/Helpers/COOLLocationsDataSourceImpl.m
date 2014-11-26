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

- (void)resetContent
{
    self.locations = nil;
    [super resetContent];
}

@end
