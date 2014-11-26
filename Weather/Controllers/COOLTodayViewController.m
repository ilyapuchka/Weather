//
//  COOLTodayViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayViewController.h"
#import "COOLForecastDataSource.h"
#import "COOLLocationsDataSource.h"
#import "INTULocationManager.h"
#import "Location.h"

@interface COOLTodayViewController() <COOLDataSourceDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation COOLTodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) wself = self;
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        __weak typeof(self) sself = wself;
        if (status == INTULocationStatusSuccess) {
            [sself.locationsDataSource loadLocationsWithLatitude:currentLocation.coordinate.latitude longituted:currentLocation.coordinate.longitude];
        }
    }];
}

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        Location *location = [[(id<COOLLocationsDataSource>)dataSource locations] firstObject];
        NSString *query = [location displayName];
        [self.forecastDataSource loadTodayForecastWithQuery:query];
    }
    else if (dataSource == self.forecastDataSource) {
        [self.tableView reloadData];
    }
}

@end
