//
//  INTULocationManager+Extensions.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "INTULocationManager.h"

@interface INTULocationManager (Extensions)

@property (nonatomic, strong) CLLocation *currentLocation;

- (BOOL)needsUpdateCurrentLocation;

@end
