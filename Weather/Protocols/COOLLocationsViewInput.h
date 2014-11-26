//
//  COOLLocationsViewControllerInput.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@protocol COOLLocationsViewInput <NSObject>

- (void)setCurrentLocation:(Location *)location;

@end
