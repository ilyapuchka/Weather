//
//  COOLLocationsSelectionOutput.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@protocol COOLLocationsSelectionOutput <NSObject>

- (void)didSelectLocation:(Location *)location;

@end

@protocol COOLLocationsSelection <NSObject>

@property (nonatomic, weak) id<COOLLocationsSelectionOutput> output;

@end
