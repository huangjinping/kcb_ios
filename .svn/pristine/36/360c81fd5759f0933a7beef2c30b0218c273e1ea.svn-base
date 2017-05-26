
//
//  ReadSecondView.m
//  Merchant
//
//  Created by xinpenghe on 15/12/22.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "ReadSecondView.h"

@interface ReadSecondView()

@end

@implementation ReadSecondView
{
    NSTimer *_timer;
    NSInteger _sec;
    
    UILabel *_contentLabel;
    UITapGestureRecognizer *_tap;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 28)];
        _contentLabel.centerY = self.boundsCenter.y;
        _contentLabel.font = SYS_FONT_SIZE(15);
        _contentLabel.text = @"获取验证码(60s)";
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent)];
        [_contentLabel addGestureRecognizer:_tap];
                
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(readSec) userInfo:nil repeats:YES];
    }
    
    return self;
}

- (void)readSec{
    while (_sec) {
        _contentLabel.text = [NSString stringWithFormat:@"等待验证码(%lds)",(long)_sec];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _tap.enabled = NO;
        _sec --;
        
        return;
    }
    _sec = 60;
    _tap.enabled = YES;
    [_timer setFireDate:[NSDate distantFuture]];
    _contentLabel.text = @"获取验证码(60s)";
    _contentLabel.textColor = [UIColor blackColor];
    
}

#pragma mark - event method

- (void)clickEvent{
    if (_commplete) {
        _commplete();
    }
    [_timer setFireDate:[NSDate distantPast]];
}

@end
