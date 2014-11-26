//
//  COOLDailyForecastViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDailyForecastViewController.h"
#import "COOLForecastDataSource.h"
#import "COOLLocationsDataSource.h"
#import "INTULocationManager.h"
#import "Location.h"
#import "AreaName.h"

@interface COOLDailyForecastViewController() <COOLDataSourceDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Location *location;

@end

@implementation COOLDailyForecastViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.location) {
        [self getLocationForCurrentLocation];
    }
    else {
        [self loadForecastForLocation:self.location];
    }
}

- (void)setLocation:(Location *)location
{
    _location = location;
    self.navigationItem.title = [(AreaName *)location.areaName.lastObject value];
}

- (void)getLocationForCurrentLocation
{
    __weak typeof(self) wself = self;
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        __weak typeof(self) sself = wself;
        if (status == INTULocationStatusSuccess) {
            [sself.locationsDataSource loadLocationsWithLatitude:currentLocation.coordinate.latitude longituted:currentLocation.coordinate.longitude];
        }
    }];
}

- (void)loadForecastForLocation:(Location *)location
{
    NSString *query = [location displayName];
    [self.forecastDataSource loadForecastWithQuery:query days:5];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        self.location = [[(id<COOLLocationsDataSource>)dataSource locations] firstObject];
        [self loadForecastForLocation:self.location];
    }
    else if (dataSource == self.forecastDataSource) {
        [self.tableView reloadData];
    }
}

@end
