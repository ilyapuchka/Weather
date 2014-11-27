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
#import "Forecast.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"
#import "COOLTableViewDataSource.h"

#import "COOLStoryboardIdentifiers.h"

@interface COOLDailyForecastViewController() <COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) Location *location;
@property (nonatomic, copy) Location *userLocation;
@property (nonatomic, copy) Forecast *forecast;
@property (nonatomic, strong) IBOutlet id<COOLTableViewDataSource> tableViewDataSource;

@end

@implementation COOLDailyForecastViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Forecast" image:[[UIImage imageNamed:@"Forecast-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Forecast-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"COOLForecastTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"COOLForecastTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    if (!self.location) {
        [self getLocationForCurrentLocation];
    }
    else {
        [self loadForecastForLocation:self.location];
    }
}

- (void)setTitleWithLocation:(Location *)location
{
    self.navigationItem.title = [(AreaName *)location.areaName.lastObject value];
}

- (void)getLocationForCurrentLocation
{
    __weak typeof(self) wself = self;
    static NSInteger locationRequestId;
    if (locationRequestId == 0) {
        locationRequestId = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            __weak typeof(self) sself = wself;
            if (status == INTULocationStatusSuccess) {
                [sself loadLocationsForLocation:currentLocation];
            }
            locationRequestId = 0;
        }];
    }
}

- (void)loadLocationsForLocation:(CLLocation *)location
{
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.locationsDataSource loadLocationsWithLatitude:location.coordinate.latitude
                                                    longituted:location.coordinate.longitude];
}

- (void)loadForecastForLocation:(Location *)location
{
    if (!location) {
        return;
    }
    
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.forecastDataSource loadDailyForecastWithQuery:location days:5];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        Location *location = [[self.locationsDataSource locations] firstObject];
        if (!error && location) {
            if (![self.userLocation isEqual:location]) {
                self.userLocation = location;
                [self setTitleWithLocation:self.userLocation];
            }
            [self loadForecastForLocation:self.userLocation];
        }
    }
    else if (dataSource == self.forecastDataSource) {
        Forecast *forecast = [self.forecastDataSource dailyForecast];
        if (!error && forecast) {
            self.forecast = forecast;
            [self.tableViewDataSource setItems:self.forecast.weather];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:COOLShowLocations]) {
        id vc = [(UINavigationController *)segue.destinationViewController topViewController];
        if (self.userLocation) {
            [(id<COOLLocationsViewInput>)vc setCurrentUserLocation:self.userLocation];
        }
        [(id<COOLLocationsSelection>)vc setOutput:self];
    }
}

#pragma mark - COOLLocationsSelectionOutput

- (void)didSelectLocation:(Location *)location
{
    self.location = location;
    if (location) {
        [self setTitleWithLocation:self.location];
    }
    [self reloadData];
}

@end
