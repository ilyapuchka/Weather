//
//  EKObjectMapping+Transfromers.m
//  CoolEvents
//
//  Created by Ilya Puchka on 23.11.14.
//  Copyright (c) 2014 CoolConnections. All rights reserved.
//

#import "EKObjectMapping+Transfromers.h"
#import "EKMapper.h"

@implementation EKObjectMapping (Transfromers)

- (void)mapKey:(NSString *)key toField:(NSString *)field withTransformerClass:(Class)transformerClass
{
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:NSStringFromClass(transformerClass)];
    [self mapKey:key toField:field withTransformer:transformer];
}

- (void)mapKey:(NSString *)key toField:(NSString *)field withTransformer:(NSValueTransformer *)transformer
{
    if ([[transformer class] allowsReverseTransformation]) {
        [self mapKeyPath:key toProperty:field withValueBlock:^id(NSString *key, id value) {
            return [transformer transformedValue:value];
        } reverseBlock:^id(id value) {
            return [transformer reverseTransformedValue:value];
        }];
    }
    else {
        [self mapKeyPath:key toProperty:field withValueBlock:^id(NSString *key, id value) {
            return [transformer transformedValue:value];
        }];
    }
}

- (void)mapKey:(NSString *)key withTransformerClass:(Class)transformerClass
{
    [self mapKey:key toField:key withTransformerClass:transformerClass];
}

- (void)mapKey:(NSString *)key withTransformer:(NSValueTransformer *)transformer
{
    [self mapKey:key toField:key withTransformer:transformer];
}

static Class _defaultMapper;

+ (void)setDefaultMapperClass:(Class)mapperClass
{
    _defaultMapper = mapperClass;
}

+ (Class)defaultMapperClass
{
    return _defaultMapper?:[EKMapper class];
}

- (id)copyWithZone:(NSZone *)zone
{
    EKObjectMapping *copy = [EKObjectMapping mappingForClass:[self objectClass] withRootPath:[self rootPath] withBlock:^(EKObjectMapping *newMapping) {
        [newMapping mapPropertiesFromMappingObject:self];
    }];
    return copy;
}

- (void)hasManyMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key forField:(NSString *)field
{
    [self mapKeyPath:key toProperty:field withValueBlock:^id(NSString *key, id value) {
        return [[EKObjectMapping defaultMapperClass] arrayOfObjectsFromExternalRepresentation:value withMapping:[mappedClass mapping]];
    }];
}

- (void)hasManyMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key
{
    [self hasManyMappingForClass:mappedClass forKey:key forField:key];
}

- (void)hasOneMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key forField:(NSString *)field
{
    [self mapKeyPath:key toProperty:field withValueBlock:^id(NSString *key, id value) {
        return [[EKObjectMapping defaultMapperClass] objectFromExternalRepresentation:value withMapping:[mappedClass mapping]];
    }];
}

- (void)hasOneMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key
{
    [self hasOneMappingForClass:mappedClass forKey:key forField:key];
}

@end
