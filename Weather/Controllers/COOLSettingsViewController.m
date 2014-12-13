//
//  COOLSettingsViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLSettingsViewController.h"
#import "COOLUserSettingsRepository.h"

#import "UIColor+Weather.h"
#import "UIFont+Weather.h"
#import "UIApplication+Extensions.h"

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
        self.title = NSLocalizedString(@"Settings", nil);
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage imageNamed:@"Settings-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Settings-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor blueTextColor]];
        [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont semiboldFontOfSize:14]];
    }
    return self;
}

- (NSString *)distanceUnitString
{
    switch ([self.userSettingsRepository defaultDistanceUnit]) {
        case COOLDistanceMiles:
            return NSLocalizedStringFromTable(@"Miles", @"Settings", nil);
            break;
        default:
            return NSLocalizedStringFromTable(@"Kilometres", @"Settings", nil);
            break;
    }
}

- (NSString *)temperatureUnitString
{
    switch ([self.userSettingsRepository defaultTemperatureUnit]) {
        case COOLTemperatureFahrenheit:
            return NSLocalizedStringFromTable(@"Fahrenheit", @"Settings", nil);
            break;
        default:
            return NSLocalizedStringFromTable(@"Celsius", @"Settings", nil);
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case COOLSettingsDistance:
            cell.detailTextLabel.text = [self distanceUnitString];
            cell.textLabel.text = NSLocalizedStringFromTable(@"Units of distance", @"Settings", nil);
            break;
        case COOLSettingsTemperature:
            cell.detailTextLabel.text = [self temperatureUnitString];
            cell.textLabel.text = NSLocalizedStringFromTable(@"Units of temperature", @"Settings", nil);
            break;
    }
    cell.detailTextLabel.textColor = [UIColor blueTextColor];
    cell.detailTextLabel.font = [UIFont regularFontOfSize:17];
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

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@\nVersion %@", [UIApplication copyright], [UIApplication appFullVersion]];
}

@end
