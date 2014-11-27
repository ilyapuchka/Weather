//
//  TimeZone.m
//
//  Created by Ilya Puchka on 27.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "TimeZone.h"


NSString *const kTimeZoneUtcOffset = @"utcOffset";
NSString *const kTimeZoneLocaltime = @"localtime";


@interface TimeZone ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TimeZone

@synthesize utcOffset = _utcOffset;
@synthesize localtime = _localtime;


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
            self.utcOffset = [self objectOrNilForKey:kTimeZoneUtcOffset fromDictionary:dict];
            self.localtime = [self objectOrNilForKey:kTimeZoneLocaltime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.utcOffset forKey:kTimeZoneUtcOffset];
    [mutableDict setValue:self.localtime forKey:kTimeZoneLocaltime];

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

    self.utcOffset = [aDecoder decodeObjectForKey:kTimeZoneUtcOffset];
    self.localtime = [aDecoder decodeObjectForKey:kTimeZoneLocaltime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_utcOffset forKey:kTimeZoneUtcOffset];
    [aCoder encodeObject:_localtime forKey:kTimeZoneLocaltime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TimeZone *copy = [[TimeZone alloc] init];
    
    if (copy) {

        copy.utcOffset = [self.utcOffset copyWithZone:zone];
        copy.localtime = [self.localtime copyWithZone:zone];
    }
    
    return copy;
}


@end
