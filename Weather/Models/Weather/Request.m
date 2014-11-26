//
//  Request.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Request.h"


NSString *const kRequestQuery = @"query";
NSString *const kRequestType = @"type";


@interface Request ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Request

@synthesize query = _query;
@synthesize type = _type;


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
        self.query = [self objectOrNilForKey:kRequestQuery fromDictionary:dict];
        self.type = [self objectOrNilForKey:kRequestType fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.query forKey:kRequestQuery];
    [mutableDict setValue:self.type forKey:kRequestType];

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

    self.query = [aDecoder decodeObjectForKey:kRequestQuery];
    self.type = [aDecoder decodeObjectForKey:kRequestType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_query forKey:kRequestQuery];
    [aCoder encodeObject:_type forKey:kRequestType];
}

- (id)copyWithZone:(NSZone *)zone
{
    Request *copy = [[Request alloc] init];
    
    if (copy) {
        copy.query = [self.query copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
