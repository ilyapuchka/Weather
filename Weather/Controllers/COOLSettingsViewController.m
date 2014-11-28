//
//  COOLSettingsViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLSettingsViewController.h"
#import "COOLUserSettingsRepository.h"

typedef NS_ENUM(NSInteger, COOLSettings){
    COOLSettingsDistance,
    COOLSettingsTemperature
};

@interface COOLSettingsViewController()

@end

@implementation COOLSettingsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[[UIImage imageNamed:@"Settings-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Settings-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (NSString *)distanceUnitString
{
    switch ([self.userSettingsRepository defaultDistanceUnit]) {
        case COOLDistanceMiles:
            return @"Miles";
            break;
        default:
            return @"Kilometres";
            break;
    }
}

- (NSString *)temperatureUnitString
{
    switch ([self.userSettingsRepository defaultTemperatureUnit]) {
        case COOLTemperatureFahrenheit:
            return @"Fahrenheit";
            break;
        default:
            return @"Celsius";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case COOLSettingsDistance:
            cell.detailTextLabel.text = [self distanceUnitString];
            break;
        case COOLSettingsTemperature:
            cell.detailTextLabel.text = [self temperatureUnitString];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case COOLSettingsDistance:
            [self.userSettingsRepository setDefaultDistanceUnit:[self.userSettingsRepository defaultDistanceUnit] + 1];
            break;
        case COOLSettingsTemperature:
            [self.userSettingsRepository setDefaultTemperatureUnit:[self.userSettingsRepository defaultTemperatureUnit] + 1];
            break;
    }
    [tableView reloadData];
}

@end
