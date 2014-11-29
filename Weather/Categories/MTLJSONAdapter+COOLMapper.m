//
//  MTLJSONAdapter+COOLMapper.m
//  Weather
//
//  Created by Ilya Puchka on 29.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "MTLJSONAdapter+COOLMapper.h"

@implementation MTLJSONAdapter (COOLMapper)

+ (id)objectFromExternalRepresentation:(id)externalRepresentation ofClass:(Class)mappedClass
{
    return [MTLJSONAdapter modelOfClass:mappedClass fromJSONDictionary:externalRepresentation error:NULL];
}

+ (NSArray *)arrayOfObjectsFromExternalRepresentation:(NSArray *)externalRepresentation ofClass:(Class)mappedClass
{
    return [MTLJSONAdapter modelsOfClass:mappedClass fromJSONArray:externalRepresentation error:NULL];
}

@end
