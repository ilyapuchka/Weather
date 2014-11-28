//
//  BaseClass.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Forecast.h"
#import "Weather.h"
#import "TimeZone.h"
#import "Hourly.h"

@interface Forecast ()

@property (nonatomic, copy, readwrite) NSArray *weather;
@property (nonatomic, copy, readwrite) NSArray *timeZone;

@end

@implementation Forecast

- (Hourly *)currentHourly
{
    Weather *weather = self.weather.lastObject;
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSDate *date = [dateFormatter dateFromString:[(TimeZone *)self.timeZone.lastObject localtime]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date];
    NSInteger hour = [components hour];
    NSString *hourString = [NSString stringWithFormat:@"%li00", (long)hour];
    NSInteger idx;
    for (idx = 0; idx < weather.hourly.count; idx++) {
        Hourly *hourly = weather.hourly[idx];
        NSComparisonResult result = [hourly.time compare:hourString options:NSNumericSearch];
        if (result == NSOrderedDescending) {
            break;
        }
    }
    return [weather.hourly objectAtIndex:MIN(MAX(0, idx - 1), weather.hourly.count - 1)];
}


@end
