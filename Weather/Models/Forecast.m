//
//  BaseClass.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Forecast.h"
#import "Request.h"
#import "Weather.h"


NSString *const kBaseClassRequest = @"request";
NSString *const kBaseClassWeather = @"weather";


@interface Forecast ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Forecast

@synthesize request = _request;
@synthesize weather = _weather;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedRequest = [dict objectForKey:kBaseClassRequest];
        NSMutableArray *parsedRequest = [NSMutableArray array];
        if ([receivedRequest isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRequest) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRequest addObject:[Request modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedRequest isKindOfClass:[NSDictionary class]]) {
           [parsedRequest addObject:[Request modelObjectWithDictionary:(NSDictionary *)receivedRequest]];
        }

        self.request = [NSArray arrayWithArray:parsedRequest];
        NSObject *receivedWeather = [dict objectForKey:kBaseClassWeather];
        NSMutableArray *parsedWeather = [NSMutableArray array];
        if ([receivedWeather isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedWeather) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedWeather addObject:[Weather modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedWeather isKindOfClass:[NSDictionary class]]) {
           [parsedWeather addObject:[Weather modelObjectWithDictionary:(NSDictionary *)receivedWeather]];
        }

        self.weather = [NSArray arrayWithArray:parsedWeather];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRequest = [NSMutableArray array];
    for (NSObject *subArrayObject in self.request)
    {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRequest addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRequest addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRequest] forKey:kBaseClassRequest];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kBaseClassWeather];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.request = [aDecoder decodeObjectForKey:kBaseClassRequest];
    self.weather = [aDecoder decodeObjectForKey:kBaseClassWeather];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_request forKey:kBaseClassRequest];
    [aCoder encodeObject:_weather forKey:kBaseClassWeather];
}

- (id)copyWithZone:(NSZone *)zone
{
    Forecast *copy = [[Forecast alloc] init];
    
    if (copy) {
        copy.request = [self.request copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
    }
    
    return copy;
}


@end
