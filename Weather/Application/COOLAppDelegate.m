//
//  COOLAppDelegate.m
//  Weather
//
//  Created by Ilya Puchka on 11/26/14
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAppDelegate.h"
#import "Typhoon.h"
#import "NetworkComponents.h"
#import "COOLWeatherAPI.h"

@implementation COOLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NetworkComponents *factory = (NetworkComponents *)[TyphoonBlockComponentFactory factoryWithAssembly:[NetworkComponents new]];
    
    id<COOLWeatherAPI> apiClient = [factory apiClient];
    [apiClient todayWeatherWithQuery:@"Moscow, Russia" success:^(COOLTodayForecastAPIResponse *response) {
        
    } failure:^(COOLAPIResponse *response) {
        
    }];
    
    [apiClient daylyWeatherWithQuery:@"Moscow, Russia" days:5 success:^(COOLDailyForecastAPIResponse *response) {
        
    } failure:^(COOLAPIResponse *response) {
        
    }];
    
    [apiClient searchCitiesWithQuery:@"Mosc" success:^(COOLSearchAPIResponse *response) {
        
    } failure:^(COOLAPIResponse *response) {
        
    }];
    
    return YES;
}

@end
