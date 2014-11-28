//
//  CLLocation+Extensions.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Extensions)

- (BOOL)differsSignificantly:(CLLocation *)location;
- (BOOL)needsUpdate;

@end
