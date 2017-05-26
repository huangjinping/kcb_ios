
//
//  ItemViewCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/23.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "ItemViewCell.h"

@implementation ItemViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UIImageView alloc]init];
        _icon.layer.masksToBounds = YES;
        _l = [[UILabel alloc]init];
        _l.font = FONT_SIZE(12, x_6_SCALE);
        _l.textColor = [UIColor grayColor];
        _l.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_l];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (![_l.text isLegal]) {
        _icon.frame = self.bounds;
        _icon.layer.cornerRadius = _icon.width/2;
    }else{
        _icon.frame = CGRectMake(0, 0, self.width/5*4, self.height/5*4);
        _icon.centerX = self.boundsCenter.x;
        _icon.layer.cornerRadius = _icon.width/2;
        _l.frame = CGRectMake(0, _icon.bottom, self.width, self.height/5);
    }
}

@end
