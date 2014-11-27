//
//  COOLUserLocationsRepository.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@protocol COOLUserLocationsRepository <NSObject>

- (NSArray *)userLocations;
- (void)removeUserLocation:(Location *)location;
- (void)addUserLocation:(Location *)location;

- (Location *)selectedLocation;
- (void)setSelectedLocation:(Location *)location;

@end
