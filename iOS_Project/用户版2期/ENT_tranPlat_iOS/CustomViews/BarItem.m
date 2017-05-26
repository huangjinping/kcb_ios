//
//  BarItem.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/31.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "BarItem.h"

@implementation BarItem
{
    UILabel *_icon;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UILabel alloc]init];
        _icon.backgroundColor = kTextOrangeColor;
        _icon.textColor = [UIColor whiteColor];
        _icon.textAlignment = NSTextAlignmentCenter;
        _icon.layer.masksToBounds = YES;
        _icon.hidden = YES;
        _icon.font = FONT_SIZE(12, x_6_SCALE);
        _icon.layer.cornerRadius = _icon.width/2;
        
        [self addSubview:_icon];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self bringSubviewToFront:_icon];
    _icon.origin = CGPointMake(self.width-x_6_SCALE*12, -y_6_SCALE*7);
}

- (void)setIconBadgeNumber:(NSInteger)IconBadgeNumber{
    _IconBadgeNumber = IconBadgeNumber;
    if (!IconBadgeNumber) {
        _icon.hidden = YES;
        _icon.size = CGSizeMake(x_6_SCALE*20, x_6_SCALE*20);
        _icon.layer.cornerRadius = _icon.width/2;
    }else if(IconBadgeNumber <= 99){
        _icon.text = [NSString stringWithFormat:@"%ld",(long)IconBadgeNumber];
        _icon.hidden = NO;
        _icon.size = CGSizeMake(x_6_SCALE*20, x_6_SCALE*20);
        _icon.layer.cornerRadius = _icon.width/2;
    }else{
        _icon.hidden = NO;
        _icon.text = @"99+";
        _icon.size = CGSizeMake(30*x_6_SCALE, 20*y_6_SCALE);
        _icon.layer.cornerRadius = 10;
    }
}

@end
