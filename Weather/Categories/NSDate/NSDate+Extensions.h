//
//  NSDate+Extensions.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

+ (NSString *)weekDayFromDateString:(NSString *)date dateFormat:(NSString *)dateFormat;

@end
