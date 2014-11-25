//
//  COOLMapperImpl.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLMapperImpl.h"

@implementation COOLMapperImpl

+ (id)objectFromExternalRepresentation:(NSDictionary *)externalRepresentation withMapping:(EKObjectMapping *)mapping
{
    if (mapping) {
        if (externalRepresentation != nil) {
            if ([externalRepresentation isKindOfClass:[NSArray class]]) {
                return [super arrayOfObjectsFromExternalRepresentation:(NSArray *)externalRepresentation
                                                           withMapping:mapping];
            }
            else if ([externalRepresentation isKindOfClass:[NSDictionary class]]) {
                return [super objectFromExternalRepresentation:externalRepresentation
                                                   withMapping:mapping];
            }
        }
    }
    return nil;
}

+ (NSArray *)arrayOfObjectsFromExternalRepresentation:(NSArray *)externalRepresentation withMapping:(EKObjectMapping *)mapping
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *representation in externalRepresentation) {
        id parsedObject = [self objectFromExternalRepresentation:representation withMapping:mapping];
        if (parsedObject) [array addObject:parsedObject];
    }
    return [NSArray arrayWithArray:array];
}

@end
