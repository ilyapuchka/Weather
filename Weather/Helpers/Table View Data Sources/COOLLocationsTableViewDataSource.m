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

#import "COOLStoryboardIdentifiers.h"

@interface COOLLocationsTableViewDataSource() <MSCMoreOptionTableViewCellDelegate>

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) id<COOLUserSettingsRepository> settings;

@end

@implementation COOLLocationsTableViewDataSource

@synthesize output = _output;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COOLForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COOLForecastTableViewCellReuseId forIndexPath:indexPath];
    
    ForecastForLocation *item = self.items[indexPath.row];
    Forecast *forecast = item.forecast;
    Location *location = item.location;
    
    COOLForecastTableViewCellModel *viewModel = [[COOLForecastTableViewCellModel alloc] initWithDailyForecast:forecast forLocation:location isCurrentLocation:[location isEqual:self.currentUserLocation]];
    [viewModel setup:cell setting:self.settings];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.separatorInset = UIEdgeInsetsMake(0, 87, 0, 0);
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastForLocation *item = self.items[indexPath.row];
    Location *location = item.location;
    [self.output didSelectLocation:location];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ForecastForLocation *item = self.items[indexPath.row];
        Location *location = item.location;
        [self.editingDelegate didDeleteLocation:location];
        
        NSMutableArray *mItems = [self.items mutableCopy];
        [mItems removeObject:item];
        self.items = mItems;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
}

@end
