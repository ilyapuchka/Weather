//
//  COOLForecastComposedDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLDataSourceDelegate.h"

@protocol COOLForecastComposedDataSource <NSObject>

@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

@property (nonatomic, copy) NSArray *queries;
@property (nonatomic, assign) NSInteger days;

- (void)loadDailyForecastsWithQueries:(NSArray *)queries days:(NSInteger)days;

- (NSDictionary *)queriesToForecasts;

@end
