//
//  OutStarView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OutStarView.h"
#import "CWStarRateView.h"
#import "UILabel+Custom.h"

@implementation OutStarView
{
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    CWStarRateView *_starView;
    UILabel *_scoreLabel;
}

+ (instancetype)shareOutStarView{
    OutStarView *ov = [[OutStarView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 60*y_6_SCALE)];

    return ov;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 160*x_6_SCALE, 22)
                                              text:@"小矮人"
                                              font:FONT_SIZE(15, x_6_SCALE)
                                         textColor:kTextGrayColor];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _nameLabel.bottom, 160*x_6_SCALE, 22)
                                              text:@"8:00-19:00"
                                              font:FONT_SIZE(13, x_6_SCALE)
                                         textColor:kTextGrayColor];
        _starView = [[CWStarRateView alloc]initWithFrame:CGRectMake(_nameLabel.right, 0, 100, 22) numberOfStars:5];
        _starView.centerY = self.boundsCenter.y;
        _starView.scorePercent = 0.8;
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(_starView.right, 2, 40*x_6_SCALE, 22)
                                               text:@"7分"
                                               font:FONT_SIZE(13, x_6_SCALE)
                                          textColor:kTextGrayColor];
        _scoreLabel.centerY = self.boundsCenter.y;
        
        [self addLineWithFrame:CGRectMake(0, 0, self.width, 1) lineColor:kLineGrayColor];
        [self addLineWithFrame:CGRectMake(0, self.height-1, self.width, 1) lineColor:kLineGrayColor];
        [self addSubview:_nameLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_starView];
        [self addSubview:_scoreLabel];
    }
    
    return self;
}

@end
