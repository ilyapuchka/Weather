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
#import "COOLSettingsViewController.h"

#import "NetworkComponents.h"
#import "COOLUserLocationsUserDefaultsImpl.h"
#import "COOLUserSettingsUserDefaultsImpl.h"

@implementation ApplicationComponents

- (id)sharedViewControllerComponentsDefinition
{
    return [TyphoonDefinition withClass:[UIViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
        [definition injectProperty:@selector(userLocationsRepository) with:[self userLocationsRepository]];
        [definition injectProperty:@selector(userSettingsRepository) with:[self userSettingsRepository]];
    }];
}

- (UIViewController *)todayViewController
{
    return [TyphoonDefinition withClass:[COOLTodayViewController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self sharedViewControllerComponentsDefinition];
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
    }];
}

- (UIViewController *)dailyViewController
{
    return [TyphoonDefinition withClass:[COOLDailyForecastViewController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self sharedViewControllerComponentsDefinition];
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
    }];
}

- (UIViewController *)locationsViewController
{
    return [TyphoonDefinition withClass:[COOLLocationsViewController class] configuration:^(TyphoonDefinition *definition) {
        definition.parent = [self sharedViewControllerComponentsDefinition];
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastComposedDataSource]];
    }];
}

- (UIViewController *)settingsViewController
{
    return [TyphoonDefinition withClass:[COOLSettingsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(userSettingsRepository) with:[self userSettingsRepository]];
    }];
}

- (id<COOLUserLocationsRepository>)userLocationsRepository
{
    return [TyphoonDefinition withClass:[COOLUserLocationsUserDefaultsImpl class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeWeakSingleton;
    }];
}

- (id<COOLUserSettingsRepository>)userSettingsRepository
{
    return [TyphoonDefinition withClass:[COOLUserSettingsUserDefaultsImpl class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeWeakSingleton;
    }];
}

@end
