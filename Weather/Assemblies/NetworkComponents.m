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
#import "COOLJSONResponseSerializer.h"
#import "COOLWeatherAPIRequests.h"
#import "COOLWeatherAPIResponses.h"

#import "EKObjectMapping+Transfromers.h"
#import "COOLMapperImpl.h"
#import "COOLNetworkActivityLoggerImpl.h"

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
    return [TyphoonDefinition withClass:[COOLJSONResponseSerializer class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithResponsesRegisteredForRequests:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self responsesDefinition]];
        }];
        
        [definition injectProperty:@selector(removesKeysWithNullValues) with:@(YES)];
        [definition injectProperty:@selector(responseMapper)];
    }];
}

- (NSDictionary *)responsesDefinition
{
    return @{NSStringFromClass([COOLTodayForecastAPIRequest class]):
                 NSStringFromClass([COOLTodayForecastAPIResponse class]),
             NSStringFromClass([COOLDailyForecastAPIRequest class]):
                 NSStringFromClass([COOLDailyForecastAPIResponse class]),
             NSStringFromClass([COOLSearchAPIRequest class]):
                 NSStringFromClass([COOLSearchAPIResponse class])};
}

- (id<COOLMapper>)responseMapper
{
    [EKObjectMapping setDefaultMapperClass:[COOLMapperImpl class]];
    return [TyphoonDefinition withClass:[EKObjectMapping defaultMapperClass]];
}

- (COOLNetworkActivityLoggerImpl *)networkActivityLogger
{
    return [TyphoonDefinition withClass:[COOLNetworkActivityLoggerImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedLogger)];
        [definition injectProperty:@selector(level) with:TyphoonConfig(@"Network Activity Logging Level")];
    }];
}

@end
