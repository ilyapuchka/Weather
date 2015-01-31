//
//  COOLDailyForecastTableViewDataSource.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDailyForecastTableViewDataSource.h"
#import "COOLForecastTableViewCell.h"
#import "COOLForecastTableViewCellModel.h"
#import "COOLUserSettingsRepository.h"

#import "COOLStoryboardIdentifiers.h"

@interface COOLDailyForecastTableViewDataSource()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) id<COOLUserSettingsRepository> settings;

@end

@implementation COOLDailyForecastTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COOLForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COOLForecastTableViewCellReuseId forIndexPath:indexPath];
    COOLForecastTableViewCellModel *viewModel = [[COOLForecastTableViewCellModel alloc] initWithWeather:self.items[indexPath.row] setting:self.settings];
    
    cell.weatherIconImageView.image = viewModel.weatherIconImage;
    cell.titleLabel.attributedText = viewModel.titleString;
    cell.subtitleLabel.text = viewModel.subtitleString;
    cell.temperatureLabel.text = viewModel.temperatureString;

    cell.separatorInset = UIEdgeInsetsMake(0, 87, 0, 0);
    return cell;
}

@end
