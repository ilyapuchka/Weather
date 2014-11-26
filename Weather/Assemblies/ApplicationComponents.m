//
//  ApplicationComponents.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "ApplicationComponents.h"
#import "COOLTodayViewController.h"
#import "NetworkComponents.h"

@implementation ApplicationComponents

- (UIViewController *)todayViewController
{
    return [TyphoonDefinition withClass:[COOLTodayViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(forecastDataSource) with:[self.networkComponents forecastDataSource]];
        [definition injectProperty:@selector(locationsDataSource) with:[self.networkComponents locationsDataSource]];
    }];
}

@end
