//
//  BaseClass.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Forecast : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *request;
@property (nonatomic, strong) NSArray *weather;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
