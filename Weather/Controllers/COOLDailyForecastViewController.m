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
#import "COOLNotifications.h"

#import "UIAlertView+Extensions.h"

@interface COOLDailyForecastViewController()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) Forecast *forecast;
@property (nonatomic, strong) IBOutlet id<COOLForecastTableViewDataSource> tableViewDataSource;

@end

@implementation COOLDailyForecastViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"Forecast", nil);
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage imageNamed:@"Forecast-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Forecast-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
    [self.tableViewDataSource setSettings:self.userSettingsRepository];
    
    self.tableView.tableFooterView = [UIView new];
    
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
    
    [super reloadData];
}

- (void)willUpdateUserLocation:(BOOL)willUpdateUserLocation
{
    if (willUpdateUserLocation) {
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

- (void)loadForecastForLocation:(Location *)location
{
    [self setTitleWithLocation:location];

    if (!location) {
        return;
    }
    
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.forecastDataSource loadDailyForecastWithQuery:location days:5];
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    [super dataSource:dataSource didLoadContentWithError:error];
    
    if (dataSource == self.forecastDataSource) {
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

#pragma mark - Private

- (BOOL)shouldClearTableViewForLocation:(Location *)location
{
    BOOL should = ((self.selectedLocation && ![self.selectedLocation isEqual:location]) ||
                   (!self.selectedLocation && location) ||
                   (!self.selectedLocation && !self.userLocation));
    return should;
}

- (void)defaultsChanged:(NSNotification *)note
{
    if (self.forecast) {
        [self reloadTableViewWithForecast:self.forecast];
    }
}

@end
