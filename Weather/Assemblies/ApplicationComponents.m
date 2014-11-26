//
//  ApplicationComponents.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "ApplicationComponents.h"
#import "COOLTodayViewController.h"
#import "COOLDailyForecastViewController.h"
#import "COOLLocationsViewController.h"
#import "NetworkComponents.h"

@implementation ApplicationComponents

- (UIViewController *)todayViewController
{
    return [TyphoonDefinition withClass:[COOLTodayViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
    }];
}

- (UIViewController *)dailyViewController
{
    return [TyphoonDefinition withClass:[COOLDailyForecastViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
    }];
}

- (UIViewController *)locationsViewController
{
    return [TyphoonDefinition withClass:[COOLLocationsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastComposedDataSource]];
    }];
}

@end
