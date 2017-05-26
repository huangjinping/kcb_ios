//
//  BXOrderPayViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/27.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXOrderPayViewController.h"

@interface BXOrderPayViewController ()<
UIWebViewDelegate
>

@end

@implementation BXOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *lable = [[UILabel alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y*PX_Y_SCALE + 60, APP_PX_WIDTH, 30)];
    [lable setText:@"车险服务订单"];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(0, lable.b + 30, APP_PX_WIDTH, 60)];
    [lable setText:self.price];
    [lable convertNewLabelWithFont:SYS_FONT_SIZE(60) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lable];
    
    
    CGFloat contentLineHeight = 90;
    CGFloat space = 30;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:lable.b + space + space width:APP_PX_WIDTH height:contentLineHeight*5];
    [self.view addSubview:bgImgView];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"订单编号："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.orderNo];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"收款单位："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.companyName];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*3 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"商品名称："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*3 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.goodsName];
    [bgImgView addSubview:lable];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(space, bgImgView.b + space, APP_PX_WIDTH - space*2, 70);
    [button setTitle:@"立即支付" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:button];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"确认支付"];
}


- (void)payButtonClicked{
    CommonWebViewController *vc = [[CommonWebViewController alloc] init];
    NSString *urlstr = [NSString stringWithFormat:@"http://1.202.156.227:7002/netCarAppPayVerifyAction.action?proposalno=%@&insrancename=%@",self.jmorderid, self.jminsuredName];
    NSURL *url = [NSURL URLWithString:urlstr];//http://chexian.sinosig.com/netCarAppPayVerifyAction.action
    vc.url = url;
    vc.web_title = @"车险缴款";
    [self.navigationController pushViewController:vc animated:YES];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
//    webView.delegate = self;
//    NSString *urlstr = [NSString stringWithFormat:@"1.202.156.227:7002/netCarAppPayVerifyAction.action?proposalno=%@&insrancename=%@",self.jmorderid, self.jminsuredName];
//    NSURL *url = [NSURL URLWithString:urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
