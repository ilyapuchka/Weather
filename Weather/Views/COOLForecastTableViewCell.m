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

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation COOLForecastTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setConfigurationBlock:^(UIButton *deleteButton, UIButton *moreOptionButton, CGFloat *deleteButtonWitdh, CGFloat *moreOptionButtonWidth) {
        *deleteButtonWitdh = 87;
        *moreOptionButtonWidth = 0;
        deleteButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:136.0f/255.0f blue:71.0f/255.0f alpha:1.0f];
        [deleteButton setTitle:nil forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"DeleteIcon"] forState:UIControlStateNormal];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.subtitleLabel.preferredMaxLayoutWidth = self.contentView.bounds.size.width - 87 - 104;
    [super layoutSubviews];
}

@end
