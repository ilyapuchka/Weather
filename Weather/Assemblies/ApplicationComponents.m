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
#import "COOLUserLocationsUserDefaultsImpl.h"

@implementation ApplicationComponents

- (UIViewController *)todayViewController
{
    return [TyphoonDefinition withClass:[COOLTodayViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
        [definition injectProperty:@selector(userLocationsRepository) with:[self userLocationsRepository]];
    }];
}

- (UIViewController *)dailyViewController
{
    return [TyphoonDefinition withClass:[COOLDailyForecastViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
        [definition injectProperty:@selector(userLocationsRepository) with:[self userLocationsRepository]];
    }];
}

- (UIViewController *)locationsViewController
{
    return [TyphoonDefinition withClass:[COOLLocationsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastComposedDataSource]];
        [definition injectProperty:@selector(userLocationsRepository) with:[self userLocationsRepository]];
    }];
}

- (id<COOLUserLocationsRepository>)userLocationsRepository
{
    return [TyphoonDefinition withClass:[COOLUserLocationsUserDefaultsImpl class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeWeakSingleton;
    }];
}

@end
