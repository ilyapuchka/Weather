//
//  COOLForecastTableViewCell.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastTableViewCell.h"
#import "COOLForecastTableViewCellModel.h"

@interface COOLForecastTableViewCell()

@end

@implementation COOLForecastTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.subtitleLabel.preferredMaxLayoutWidth = self.contentView.bounds.size.width - 87 - 104;
    [super layoutSubviews];
}

@end
