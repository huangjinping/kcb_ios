//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshLegendHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshLegendHeader.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"

@interface CustomIndicatory : UIView

@property (nonatomic, strong) UIImage *img;

- (void)startAnimating;
- (void)stopAnimating;

@end
static NSString *rotationAnimation = @"rotationAnimation";
static CGFloat durition = .23f;
@implementation CustomIndicatory
{
    @private
    UIImageView *_icon;
    CABasicAnimation *_animation;
}
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 90*x_6_plus, 90*x_6_plus)];
    if (self) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _animation.fromValue = [NSNumber numberWithFloat:0.0];
        _animation.duration = durition;
        _animation.toValue = [NSNumber numberWithFloat:-60 * M_PI];
        _animation.repeatCount = CGFLOAT_MAX;
        
        [_icon.layer addAnimation:_animation forKey:rotationAnimation];
        [self addSubview:_icon];
    }
    
    return self;
}

- (void)setImg:(UIImage *)img{
    _icon.image = img;
}

- (void)startAnimating{
    [_icon.layer addAnimation:_animation forKey:rotationAnimation];
}

- (void)stopAnimating{
    [_icon.layer removeAnimationForKey:rotationAnimation];
}

@end

@interface MJRefreshLegendHeader()
@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, strong) CustomIndicatory *activityView;
@end

@implementation MJRefreshLegendHeader
#pragma mark - 懒加载
- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_"]];
        [self addSubview:_arrowImage = arrowImage];
    }
    return _arrowImage;
}

//- (UIActivityIndicatorView *)activityView
//{
//    if (!_activityView) {
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityView.bounds = self.arrowImage.bounds;
//        [self addSubview:_activityView = activityView];
//    }
//    return _activityView;
//}

- (CustomIndicatory *)activityView{
    if (_activityView) {
        return _activityView;
    }
    _activityView = [[CustomIndicatory alloc]init];
    _activityView.img = [UIImage imageNamed:@"loading_"];
    [self addSubview:_activityView];
    
    return _activityView;
}


#pragma mark - 初始化
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 箭头
    CGFloat arrowX = (self.stateHidden && self.updatedTimeHidden) ? self.mj_w * 0.5 : (self.mj_w * 0.5 - 80);
    self.arrowImage.center = CGPointMake(arrowX, self.mj_h * 0.5);
    
    // 指示器
    self.activityView.center = self.arrowImage.center;
}

#pragma mark - 公共方法
#pragma mark 设置状态
- (void)setState:(MJRefreshHeaderState)state
{
    if (self.state == state) return;
    
    // 旧状态
    MJRefreshHeaderState oldState = self.state;
    
    switch (state) {
        case MJRefreshHeaderStateIdle: {
            if (oldState == MJRefreshHeaderStateRefreshing) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
//                    self.activityView.alpha = 0.0;
                } completion:^(BOOL finished) {
//                    self.arrowImage.alpha = 1.0;
                    self.activityView.alpha = 1.0;
                    [self.activityView stopAnimating];
                }];
            } else {
//                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//                    self.arrowImage.transform = CGAffineTransformIdentity;
//                }];
            }
            break;
        }
            
        case MJRefreshHeaderStatePulling: {
//            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//                self.arrowImage.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
//            }];
            [self.activityView startAnimating];

            break;
        }
            
        case MJRefreshHeaderStateRefreshing: {
            [self.activityView startAnimating];
//            self.arrowImage.alpha = 0.0;
            break;
        }
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

@end
