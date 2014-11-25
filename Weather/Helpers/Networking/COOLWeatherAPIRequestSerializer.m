//
//  COOLWeatherAPIRequestSerializer.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLWeatherAPIRequestSerializer.h"
#import "AFHTTPRequestSerializer+COOLAPIRequestSerialization.h"

@implementation COOLWeatherAPIRequestSerializer

- (NSURLRequest *)requestBySerializingAPIRequest:(COOLAPIRequest *)request basePath:(NSURL *)basePath error:(NSError *__autoreleasing *)error
{
    NSMutableDictionary *basicParams = [@{
                                          @"key": @"a2da856bae9633016095f8a97a472",
                                          @"format": @"json"} mutableCopy];
    
    [basicParams addEntriesFromDictionary:request.parameters];
    request = [[[request class] alloc] initWithMethod:request.method path:request.path parameters:[basicParams copy]];
    return [super requestBySerializingAPIRequest:request basePath:basePath error:error];
}

@end
