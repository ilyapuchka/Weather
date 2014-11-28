//
//  NSDate+Extensions.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

+ (NSDateFormatter *)sharedDateFormatter
{
    static NSDateFormatter *dateForamtter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateForamtter = [[NSDateFormatter alloc] init];
    });
    return dateForamtter;
}

+ (NSString *)weekDayFromDateString:(NSString *)date dateFormat:(NSString *)dateFormat
{
    __block NSString *result;
    __block NSDate *aDate;
    [self format:^(NSDateFormatter *dateFormatter) {
        aDate = [dateFormatter dateFromString:date];
    } withFormat:dateFormat];
    
    [self format:^(NSDateFormatter *dateFormatter) {
        result = [[dateFormatter stringFromDate:aDate] capitalizedString];
    } withFormat:@"EEEE"];
    return result;
}

+ (void)format:(void(^)(NSDateFormatter *))block withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [self sharedDateFormatter];
    NSString *prevDateFormat = dateFormatter.dateFormat;
    dateFormatter.dateFormat = format;
    if (block) block(dateFormatter);
    dateFormatter.dateFormat = prevDateFormat;
}

@end
