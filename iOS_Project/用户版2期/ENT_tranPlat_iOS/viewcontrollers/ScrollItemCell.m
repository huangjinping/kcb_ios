//
//  ScrollItemCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "ScrollItemCell.h"

@implementation ScrollItemCell
{
    UIImageView *_icon;
    UILabel *_numberLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _icon = [[UIImageView alloc]init];
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"123";
        _numberLabel.textColor = [UIColor redColor];
    
//        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_numberLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    _numberLabel.bounds = self.contentView.bounds;
//    _icon.height = self.contentView.height*24/43;
//    _numberLabel.height = self.contentView.height*19/43;
//    _icon.center = self.contentView.boundsCenter;
//    _numberLabel.center = self.contentView.boundsCenter;
}

- (void)setRes:(BOOL)res{
    _res = res;
    if (res) {
        _numberLabel.textColor = COLOR_NAV;
    }else{
        _numberLabel.textColor = kTextGrayColor;
    }
}

@end
