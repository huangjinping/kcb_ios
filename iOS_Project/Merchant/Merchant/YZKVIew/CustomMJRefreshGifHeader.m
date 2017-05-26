//
//  CustomMJRefreshGifHeader.m
//  Merchant
//
//  Created by Wendy on 16/3/18.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "CustomMJRefreshGifHeader.h"
@interface CustomMJRefreshGifHeader()
@property (weak, nonatomic) UIImageView *gifView;
@end
@implementation CustomMJRefreshGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.image = [UIImage imageNamed:@"loading_"];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

#pragma mark - 实现父类的方法

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    self.gifView.alpha = .8f;
    self.gifView.contentMode = UIViewContentModeCenter;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = .4f;
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:-M_PI*2];
        animation.repeatCount = CGFLOAT_MAX;
        
        [self.gifView.layer addAnimation:animation forKey:nil];
    }
}
@end
