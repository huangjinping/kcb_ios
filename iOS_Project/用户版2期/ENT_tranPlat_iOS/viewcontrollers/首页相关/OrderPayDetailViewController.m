//
//  OrderPayDetailViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/23.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderPayDetailViewController.h"

@interface OrderPayDetailViewController()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *footerView;

@end

@implementation OrderPayDetailViewController
{
    UILabel *_statusLabel;
    UILabel *_subLabel;
    UILabel *_orderNoLabel;
    UILabel *_timeLabel;
    UILabel *_outLetLabel;
    UILabel *_addressLabel;
    UILabel *_phoneLabel;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"订单支付"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI{
    [self.view addSubview:self.scrollView];
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200*y_6_plus, APP_WIDTH, 50*y_6_plus)];
    _statusLabel.font = V3_46PX_FONT;
//    _subLabel = [UILabel alloc]initWithFrame:cg
}

- (UIScrollView *)scrollView{
    if (_scrollView) {
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_VIEW_Y+APP_NAV_HEIGHT)];
    
    return _scrollView;
}

@end
