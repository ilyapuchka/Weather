//
//  WeatherDesc.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "WeatherDesc.h"


NSString *const kWeatherDescValue = @"value";


@interface WeatherDesc ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherDesc

@synthesize value = _value;


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
            self.value = [self objectOrNilForKey:kWeatherDescValue fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.value forKey:kWeatherDescValue];

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

    self.value = [aDecoder decodeObjectForKey:kWeatherDescValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_value forKey:kWeatherDescValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherDesc *copy = [[WeatherDesc alloc] init];
    
    if (copy) {

        copy.value = [self.value copyWithZone:zone];
    }
    
    return copy;
}


@end
