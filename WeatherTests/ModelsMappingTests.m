//
//  ModelsMappingTests.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EKMapper.h"
#import "COOLForecast+Mapping.h"
#import "COOLTodayForecast+Mapping.h"

@interface ModelsMappingTests : XCTestCase

@end

@implementation ModelsMappingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testForecastMapping {
    // This is an example of a functional test case.
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"forecast" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    COOLForecast *forecast = [EKMapper objectFromExternalRepresentation:[json valueForKey:@"data"] withMapping:[COOLForecast mapping]];
    
    XCTAssertNotNil(forecast, @"Mapped forecast should not be nil");
}

- (void)testTodayForecastMapping {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"todayforecast" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    COOLTodayForecast *forecast = [EKMapper objectFromExternalRepresentation:[json valueForKey:@"data"] withMapping:[COOLTodayForecast mapping]];

    XCTAssertNotNil(forecast, @"Mapped forecast should not be nil");
    XCTAssertNotNil(forecast.currentCondition, @"Mapped forecast current condition should not be nil");
    XCTAssertNotNil(forecast.weather, @"Mapped forecast weather should not be nil");
}

@end
