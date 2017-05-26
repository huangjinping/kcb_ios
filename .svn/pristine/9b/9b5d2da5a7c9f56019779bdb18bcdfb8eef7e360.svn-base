//
//  OutMessView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OutMessView.h"
#import "UILabel+Custom.h"

@implementation OutMessView
{
    UILabel *_nameLabel;
    UIImageView *_iconView;
}
+ (OutMessView *)shareOutMessView{
    OutMessView *ov = [[OutMessView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 32*y_6_SCALE)];
    
    return ov;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200*x_6_SCALE, 22)
                                              text:@"小矮人"
                                              font:FONT_SIZE(15, x_6_SCALE)
                                         textColor:kTextGrayColor];
        _nameLabel.centerY = self.boundsCenter.y;
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-5*x_6_SCALE, 0, 32*y_6_SCALE, 32*y_6_SCALE)];
        
        [self addLineWithFrame:CGRectMake(0, 0, self.width, 1) lineColor:kLineGrayColor];
        [self addLineWithFrame:CGRectMake(0, self.height-1, self.width, 1) lineColor:kLineGrayColor];
        [self addSubview:_nameLabel];
        [self addSubview:_iconView];
    }
    
    return self;
}

@end
