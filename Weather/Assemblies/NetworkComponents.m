//
//  NetworkComponents.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "NetworkComponents.h"
#import "COOLWeatherAPIImpl.h"
#import "COOLWeatherAPIRequestSerializer.h"
#import "COOLHTTPResponseSerializer.h"
#import "COOLWeatherAPIRequests.h"
#import "COOLWeatherAPIResponses.h"

#import "EKObjectMapping+Transfromers.h"
#import "COOLMapperImpl.h"
#import "MTLJSONAdapter.h"
#import "COOLNetworkActivityLoggerImpl.h"

#import "COOLForecastDataSourceImpl.h"
#import "COOLLocationsDataSourceImpl.h"
#import "COOLForecastComposedDataSourceImpl.h"

#import "TyphoonConfigPostProcessor.h"
#import "TyphoonDefinition+Infrastructure.h"

@implementation NetworkComponents

- (id)config
{
    return [TyphoonDefinition configDefinitionWithName:@"Info.plist"];
}

- (id<COOLWeatherAPI>)apiClient
{
    return [TyphoonDefinition withClass:[COOLWeatherAPIImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(baseURL) with:[NSURL URLWithString:@"http://api.worldweatheronline.com/free/v2/"]];
        [definition injectProperty:@selector(requestSerializer)];
        [definition injectProperty:@selector(responseSerializer)];
        [definition injectProperty:@selector(networkActivityLogger)];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id<COOLAPIRequestSerialization>)requestSerializer
{
    return [TyphoonDefinition withClass:[COOLWeatherAPIRequestSerializer class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(serializer)];
    }];
}

- (id<COOLAPIResponseSerialization>)responseSerializer
{
    return [TyphoonDefinition withClass:[COOLHTTPResponseSerializer class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithResponsesRegisteredForRequests:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self responsesDefinition]];
        }];
    }];
}

- (NSDictionary *)responsesDefinition
{
    return @{NSStringFromClass([COOLDailyForecastAPIRequest class]):
                 NSStringFromClass([COOLDailyForecastAPIResponse class]),
             NSStringFromClass([COOLSearchAPIRequest class]):
                 NSStringFromClass([COOLLocationsSearchAPIResponse class])};
}

- (COOLNetworkActivityLoggerImpl *)networkActivityLogger
{
    return [TyphoonDefinition withClass:[COOLNetworkActivityLoggerImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedLogger)];
        [definition injectProperty:@selector(level) with:TyphoonConfig(@"Network Activity Logging Level")];
    }];
}

- (id<COOLForecastDataSource>)forecastDataSource
{
    return [TyphoonDefinition withClass:[COOLForecastDataSourceImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(apiClient) with:[self apiClient]];
    }];
}

- (id<COOLLocationsDataSource>)locationsDataSource
{
    return [TyphoonDefinition withClass:[COOLLocationsDataSourceImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(apiClient) with:[self apiClient]];
    }];
}

- (id<COOLForecastComposedDataSource>)forecastComposedDataSource
{
    return [TyphoonDefinition withClass:[COOLForecastComposedDataSourceImpl class] configuration:^(TyphoonDefinition *definition) {
    }];
}

@end
