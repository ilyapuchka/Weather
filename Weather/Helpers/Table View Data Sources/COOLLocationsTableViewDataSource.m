//
//  COOLLocationsTableViewDataSource.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsTableViewDataSource.h"
#import "COOLForecastTableViewCell.h"
#import "COOLForecastTableViewCellModel.h"

#import "ForecastForLocation.h"
#import "Forecast.h"
#import "Weather.h"
#import "Location.h"

@interface COOLLocationsTableViewDataSource()

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) NSArray *items;

@end

@implementation COOLLocationsTableViewDataSource

@synthesize output = _output;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COOLForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([COOLForecastTableViewCell class]) forIndexPath:indexPath];
    
    ForecastForLocation *item = self.items[indexPath.row];
    Weather *weather = [item.forecast.weather lastObject];
    Location *location = item.location;
    
    COOLForecastTableViewCellModel *viewModel = [[COOLForecastTableViewCellModel alloc] initWithDailyWeather:weather forLocation:location isCurrentLocation:[location isEqual:self.currentUserLocation]];
    [cell setWithViewModel:viewModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastForLocation *item = self.items[indexPath.row];
    Location *location = item.location;
    [self.output didSelectLocation:location];
}

@end
