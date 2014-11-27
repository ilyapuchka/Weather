//
//  COOLLocationsViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsViewController.h"
#import "COOLLocationsDataSource.h"
#import "COOLForecastComposedDataSource.h"
#import "COOLUserLocationsRepository.h"
#import "COOLTableViewDataSource.h"

#import "COOLLocationsTableViewDataSource.h"

#import "Location.h"
#import "Weather.h"
#import "Forecast.h"

@interface COOLLocationsViewController() <UISearchBarDelegate, COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *doneItem;

@property (nonatomic, copy) Location *selectedLocation;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) Location *currentUserLocation;

@property (nonatomic, weak) IBOutlet id<COOLTableViewDataSource, COOLLocationsTableViewDataSourceInput> locationsTableViewDataSource;
@property (nonatomic, weak) IBOutlet id<COOLTableViewDataSource> searchResultsTableViewDataSource;
@property (nonatomic, weak) id<COOLTableViewDataSource> currentDataSource;

@end

@implementation COOLLocationsViewController

@synthesize output = _output;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doneItem = self.navigationItem.rightBarButtonItem;
    self.locationsDataSource.delegate = self;
    self.forecastDataSource.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"COOLForecastTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"COOLForecastTableViewCell"];

    self.currentDataSource = self.locationsTableViewDataSource;
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
}

- (void)reloadData
{
    self.tableView.dataSource = self.currentDataSource;
    self.tableView.delegate = self.currentDataSource;
    
    [self.tableView reloadData];
}

- (void)setCurrentUserLocation:(Location *)location
{
    NSCParameterAssert(location);
    if (!location) {
        return;
    }
    self.locations = [@[location] arrayByAddingObjectsFromArray:[self.userLocationsRepository userLocations]];
}

- (IBAction)closeTapped:(id)sender
{
    [self dismiss];
}

- (void)dismiss
{
    if ([[self.userLocationsRepository userLocations] containsObject:self.selectedLocation]) {
        [self.output didSelectLocation:self.selectedLocation];
    }
    else {
        //it means we selected current user location, not the location added by user
        [self.output didSelectLocation:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showLocations
{
    [self.view endEditing:YES];
    self.navigationItem.titleView = nil;
    self.navigationItem.title = @"Locations";
    [self.navigationItem setRightBarButtonItem:self.doneItem animated:YES];
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
    self.currentDataSource = self.locationsTableViewDataSource;
    [self.tableView reloadData];
}

- (void)showSearch
{
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [searchBar becomeFirstResponder];
    self.currentDataSource = self.searchResultsTableViewDataSource;
    [self reloadData];
}

- (IBAction)addPlaceTapped:(id)sender
{
    [self showSearch];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self showLocations];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.locationsDataSource loadLocationsWithQuery:searchText];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    NSArray *items;
    if (dataSource == self.locationsDataSource) {
        items = [self.locationsDataSource locations];
        [self.locationsTableViewDataSource setCurrentUserLocation:self.currentUserLocation];
    }
    else if (dataSource == self.forecastDataSource) {
        NSMutableArray *mItems = [@[] mutableCopy];
        [[self.forecastDataSource forecasts] enumerateObjectsUsingBlock:^(Forecast *forecast, NSUInteger idx, BOOL *stop) {
            [mItems addObject:@[[forecast.weather lastObject], [self.forecastDataSource queries][idx]]];
        }];
        items = [mItems copy];
    }
    [self.currentDataSource setItems:items];
    [self.tableView reloadData];
}

#pragma mark - COOLLocationsTableViewDataSourceOutput

- (void)didSelectLocation:(Location *)location
{
    if (self.currentDataSource == self.searchResultsTableViewDataSource) {
        if (![[self.userLocationsRepository userLocations] containsObject:location]) {
            [self.userLocationsRepository addUserLocation:location];
            [self showLocations];
        }
    }
    else {
        self.selectedLocation = location;
        [self dismiss];
    }
}

@end
