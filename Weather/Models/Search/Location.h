//
//  BaseClass.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Location : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *region;
@property (nonatomic, strong) NSArray *country;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *population;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSArray *areaName;

- (NSString *)displayName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
