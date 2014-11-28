//
//  COOLLocationSearchCellModel.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationSearchCellModel.h"
#import "COOLocationSearchCellPresentation.h"

#import "Location.h"
#import "AreaName.h"
#import "Region.h"

#import "UIFont+Weather.h"

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
    [attr appendAttributedString:[[NSAttributedString alloc] initWithString:areaNameString attributes:@{NSFontAttributeName: [UIFont semiboldFontOfSize:16.0f]}]];
    [attr appendAttributedString:[[NSAttributedString alloc] initWithString:region.value attributes:@{NSFontAttributeName: [UIFont lightFontOfSize:16.0f]}]];
    return [attr copy];
}

- (void)setup:(id<COOLocationSearchCellPresentation>)view
{
    view.textLabel.attributedText = self.titleString;
}

@end
