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

#import "COOLUserLocationsRepository.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"
#import "COOLTableViewDataSource.h"

#import "COOLStoryboardIdentifiers.h"

#import "UIAlertView+Extensions.h"

@interface COOLDailyForecastViewController() <COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) Location *selectedLocation;
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"COOLForecastTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:COOLForecastTableViewCellReuseId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Location *location = [self.userLocationsRepository selectedLocation];
    if ([self shouldClearTableViewForLocation:location]) {
        self.forecast = nil;
        [self reloadTableViewWithForecast:self.forecast];
    }
    self.selectedLocation = location;
    [self reloadData];
}

- (void)reloadData
{
    [self setTitleWithLocation:self.selectedLocation?:self.userLocation];

    if (self.selectedLocation) {
        [self loadForecastForLocation:self.selectedLocation];
    }
    
    BOOL updatingLocation = [self.userLocationsRepository updateCurrentUserLocation:NO withCompletion:^(INTULocationStatus status, CLLocation *location, BOOL changed) {
        if (status != INTULocationStatusSuccess) {
            [UIAlertView showLocationErrorWithStatus:status force:NO];
            self.selectedLocation = [[self.userLocationsRepository userLocations] firstObject];
            [self.userLocationsRepository setSelectedLocation:self.selectedLocation];
            [self setTitleWithLocation:self.selectedLocation];
            [self loadForecastForLocation:self.selectedLocation];
        }
        else if (changed || !self.userLocation) {
            [self loadLocationsForLocation:location];
        }
    }];
    
    if (updatingLocation) {
        if (!self.selectedLocation) {
            self.forecast = nil;
            [self reloadTableViewWithForecast:self.forecast];
        }
    }
    else {
        if (!self.selectedLocation && self.userLocation) {
            [self loadForecastForLocation:self.userLocation];
        }
    }
}

- (void)setTitleWithLocation:(Location *)location
{
    self.navigationItem.title = [(AreaName *)location.areaName.lastObject value];
}

- (void)reloadTableViewWithForecast:(Forecast *)forecast
{
    [self.tableViewDataSource setItems:self.forecast.weather];
    [self.tableView reloadData];
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
            }
            if (!self.selectedLocation) {
                [self setTitleWithLocation:self.userLocation];
                [self loadForecastForLocation:self.userLocation];
            }
        }
    }
    else if (dataSource == self.forecastDataSource) {
        Forecast *forecast = [self.forecastDataSource dailyForecast];
        if (!error && forecast) {
            self.forecast = forecast;
            [self reloadTableViewWithForecast:self.forecast];
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

- (void)didSelectLocation:(Location *)location
{
    if ([self shouldClearTableViewForLocation:location]) {
        self.forecast = nil;
        [self reloadTableViewWithForecast:self.forecast];
    }
    
    self.selectedLocation = location;
    [self setTitleWithLocation:self.selectedLocation];
}

- (BOOL)shouldClearTableViewForLocation:(Location *)location
{
    BOOL should = ((self.selectedLocation && ![self.selectedLocation isEqual:location]) ||
                   (!self.selectedLocation && location) ||
                   (!self.selectedLocation && !self.userLocation));
    return should;
}

@end
