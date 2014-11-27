//
//  COOLLocationsSearchResultsTableViewDataSource.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsSearchResultsTableViewDataSource.h"
#import "COOLUserLocationsRepository.h"

@interface COOLLocationsSearchResultsTableViewDataSource()

@property (nonatomic, copy) NSArray *items;

@end

@implementation COOLLocationsSearchResultsTableViewDataSource

@synthesize output = _output;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.output didSelectLocation:self.items[indexPath.row]];
}

@end
