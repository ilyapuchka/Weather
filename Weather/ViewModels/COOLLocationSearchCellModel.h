//
//  COOLLocationSearchCellModel.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;
@protocol COOLocationSearchCellPresentation;

@interface COOLLocationSearchCellModel : NSObject

- (instancetype)initWithLocation:(Location *)location;

- (NSAttributedString *)titleString;

@end
