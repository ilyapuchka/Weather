//
//  TimeZone.h
//
//  Created by Ilya Puchka on 27.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TimeZone : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *utcOffset;
@property (nonatomic, strong) NSString *localtime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
