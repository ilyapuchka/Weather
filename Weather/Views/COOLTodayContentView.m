//
//  COOLTodayView.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayContentView.h"

@interface COOLTodayContentView()

@end

@implementation COOLTodayContentView

- (void)awakeFromNib
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.weatherDescLabel.preferredMaxLayoutWidth =
    self.locationLabel.preferredMaxLayoutWidth = self.bounds.size.width - 30 * 2;
    
    if (self.contentSize.height < self.bounds.size.height) {
        CGFloat top = (self.bounds.size.height - self.contentSize.height) / 2;
        self.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    }
}

@end
