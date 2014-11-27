//
//  COOLLocationSearchCellModel.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLLocationSearchCellModel.h"

#import "Location.h"
#import "AreaName.h"
#import "Region.h"

@interface COOLLocationSearchCellModel()

@property (nonatomic, copy) Location *location;

@end

@implementation COOLLocationSearchCellModel

- (instancetype)initWithLocation:(Location *)location
{
    self = [super init];
    if (self) {
        _location = location;
    }
    return self;
}

- (NSAttributedString *)titleString
{
    NSMutableAttributedString *attr = [NSMutableAttributedString new];
    AreaName *areaName = self.location.areaName.lastObject;
    Region *region = self.location.region.lastObject;
    NSString *areaNameString = [areaName value];
    if ([region value].length > 0) {
        areaNameString = [areaNameString stringByAppendingString:@", "];
    }
    [attr appendAttributedString:[[NSAttributedString alloc] initWithString:areaNameString attributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Semibold" size:16.0f]}]];
    [attr appendAttributedString:[[NSAttributedString alloc] initWithString:region.value attributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Light" size:16.0f]}]];
    return [attr copy];
}

@end
