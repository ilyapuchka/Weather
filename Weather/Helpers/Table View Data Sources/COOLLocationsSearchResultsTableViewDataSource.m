//
//  COOLLocationsSearchResultsTableViewDataSource.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsSearchResultsTableViewDataSource.h"
#import "COOLUserLocationsRepository.h"

#import "Location.h"

#import "COOLStoryboardIdentifiers.h"

@interface COOLLocationsSearchResultsTableViewDataSource()

@property (nonatomic, copy) NSArray *items;

@end

@implementation COOLLocationsSearchResultsTableViewDataSource

@synthesize output = _output;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COOLSearchResultsTableViewCellReuseId forIndexPath:indexPath];
    Location *location = self.items[indexPath.row];
    cell.textLabel.text = [location displayName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.output didSelectLocation:self.items[indexPath.row]];
}

@end
