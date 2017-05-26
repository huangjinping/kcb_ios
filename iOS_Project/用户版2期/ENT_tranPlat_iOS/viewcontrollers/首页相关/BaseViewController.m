
//
//  BaseViewController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/7.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _backButtonHidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rightBtnHidden = YES;
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationItem.hidesBackButton = YES;

    self.view.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    
    { //自己实现假的navigationBar
        CGRect frame = CGRectMake(APP_X, 0, APP_WIDTH, APP_NAV_HEIGHT);
        _navImgView = [[UIImageView alloc] initWithFrame:frame];
        [_navImgView setImage:[UIImage imageWithColor:COLOR_NAV]];
        [_navImgView setUserInteractionEnabled:YES];
        [self.navigationController.navigationBar addSubview:_navImgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_X, 5, APP_WIDTH, APP_NAV_HEIGHT - 10)];
        _titleLabel.centerY = self.navigationController.navigationBar.boundsCenter.y;
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:SYS_FONT_SIZE(40)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_navImgView addSubview:_titleLabel];
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(8, 8, 30, 30)];
        [_backButton addTarget:self action:@selector(goBackPage:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [_navImgView addSubview:_backButton];
        if (self == self.navigationController.viewControllers[0]) {
            _backButtonHidden = YES;
        }
        _backButton.hidden = _backButtonHidden;
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        __block __typeof(self) weakSelf = self;
        [_rightBtn addActionBlock:^(id weakSender) {
            [weakSelf rightAction];
        } forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.hidden = _rightBtnHidden;
        [_rightBtn setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(APP_WIDTH-40*x_6_plus-57*x_6_plus, 0, 57*x_6_plus, 70*y_6_plus);
        _rightBtn.centerY = _titleLabel.centerY;
        [self.navigationController.navigationBar addSubview:_rightBtn];
    }
}

- (void)setRightBtnHidden:(BOOL)rightBtnHidden{
    _rightBtn.hidden = rightBtnHidden;
}

- (void)goBackPage:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBackButtonHidden:(BOOL)backButtonHidden
{
    _backButtonHidden = backButtonHidden;
    _backButton.hidden = _backButtonHidden;
}
//- (void)setHidesNavBarWhenPushed:(BOOL)hidesNavBarWhenPushed
//{
//    _hidesNavBarWhenPushed = hidesNavBarWhenPushed;
//    _navImgView.hidden = _hidesNavBarWhenPushed;
//}

- (void)setNavTitle:(NSString*)title
{
    [_titleLabel setText:title];
}

//- (UIView *)navigationBar
//{
//    return _navImgView;
//}

- (UIView *)contentView
{
    [self.view bringSubviewToFront:_contentView];
    return _contentView;
}
@end
