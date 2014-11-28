//
//  COOLTodayView.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayView.h"

@interface COOLTodayView()

@end

@implementation COOLTodayView

- (void)awakeFromNib
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.weatherDescLabel.preferredMaxLayoutWidth =
    self.locationLabel.preferredMaxLayoutWidth = self.bounds.size.width - 30 * 2;
    
    if (self.contentView.contentSize.height < self.contentView.bounds.size.height) {
        CGFloat top = (self.contentView.bounds.size.height - self.contentView.contentSize.height) / 2;
        self.contentView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    }
}

@end
