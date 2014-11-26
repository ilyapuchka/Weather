//
//  EKObjectMapping+Transfromers.h
//  CoolEvents
//
//  Created by Ilya Puchka on 23.11.14.
//  Copyright (c) 2014 CoolConnections. All rights reserved.
//

#import "EKObjectMapping.h"
#import "COOLMapping.h"

@interface EKObjectMapping (Transfromers) <NSCopying>

//transformers
- (void)mapKey:(NSString *)key toField:(NSString *)field withTransformerClass:(Class)transformerClass;
- (void)mapKey:(NSString *)key toField:(NSString *)field withTransformer:(NSValueTransformer *)transformer;

- (void)mapKey:(NSString *)key withTransformerClass:(Class)transformerClass;
- (void)mapKey:(NSString *)key withTransformer:(NSValueTransformer *)transformer;

//break circular definitions
- (void)hasManyMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key forField:(NSString *)field;
- (void)hasManyMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key;

- (void)hasOneMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key forField:(NSString *)field;
- (void)hasOneMappingForClass:(Class<COOLMapping>)mappedClass forKey:(NSString *)key;

//setup class to use for mapping
+ (void)setDefaultMapperClass:(Class)mapperClass;
+ (Class)defaultMapperClass;

@end
