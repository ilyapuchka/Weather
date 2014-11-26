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

#import "Location.h"

@interface COOLLocationsViewController() <UISearchBarDelegate, COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, weak) IBOutlet UITableView *locationsTableView;
@property (nonatomic, weak) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong) UIBarButtonItem *doneItem;

@property (nonatomic, copy) Location *selectedLocation;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) NSArray *searchResults;
@property (nonatomic, copy) NSArray *dailyForecasts;

@property (nonatomic, weak) id currentDataSource;

@end

@implementation COOLLocationsViewController

@synthesize output = _output;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doneItem = self.navigationItem.rightBarButtonItem;
    self.locationsDataSource.delegate = self;
    self.forecastDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
}

- (void)setCurrentLocation:(Location *)location
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
    self.navigationItem.titleView = nil;
    self.navigationItem.title = @"Locations";
    [self.navigationItem setRightBarButtonItem:self.doneItem animated:YES];
    [UIView animateWithDuration:0.25f animations:^{
        self.searchTableView.alpha = 0.0f;
        self.locationsTableView.alpha = 1.0f;
    }];
    
    self.currentDataSource = self.locationsTableView.dataSource;
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
}

- (void)showSearch
{
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [searchBar becomeFirstResponder];
    [UIView animateWithDuration:0.25f animations:^{
        self.searchTableView.alpha = 1.0f;
        self.locationsTableView.alpha = 0.0f;
    }];
    
    self.currentDataSource = self.searchTableView.dataSource;
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
    [self.locationsDataSource loadLocationsWithQuery:searchText];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        self.searchResults = [self.locationsDataSource locations];
        [self.searchTableView reloadData];
    }
    else if (dataSource == self.forecastDataSource) {
        self.dailyForecasts = [self.forecastDataSource forecasts];
        [self.locationsTableView reloadData];
    }
}

#pragma mark - COOLLocationsTableViewDataSourceOutput

- (void)didSelectLocation:(Location *)location
{
    if (self.currentDataSource == self.searchTableView.dataSource) {
        if (![[self.userLocationsRepository userLocations] containsObject:location]) {
            [self.userLocationsRepository addUserLocation:location];
        }
    }
    else {
        self.selectedLocation = location;
        [self dismiss];
    }
}

@end
