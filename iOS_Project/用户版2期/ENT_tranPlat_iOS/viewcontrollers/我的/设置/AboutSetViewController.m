//
//  AboutSetViewController.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-17.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AboutSetViewController.h"

@interface AboutSetViewController ()

@end

@implementation AboutSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:LGRectMake((APP_PX_WIDTH - 120)/2, APP_VIEW_Y/PX_Y_SCALE + 30, 120, 120)];
    imageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    [self.view addSubview:imageView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:LGRectMake(0, imageView.b + 30, APP_PX_WIDTH, 30)];
    [lable1 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    lable1.text = @"开车邦";
    [self.view addSubview:lable1];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *str = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versionLable = [[UILabel alloc]initWithFrame:LGRectMake(0, lable1.b + 10, lable1.w, 24)];
    [_versionLable convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    _versionLable.text = [NSString stringWithFormat:@"版本：%@",str];
    [self.view addSubview:_versionLable];
    
    CGFloat singleLineHeight = 30*3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:_versionLable.b + 60 width:APP_PX_WIDTH height:singleLineHeight*3];
    [self.view addSubview:bgImgView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 160, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [lable setText:@"官网"];
    [bgImgView addSubview:lable];
    UILabel *contentL = [[ UILabel alloc] initWithFrame:LGRectMake(lable.r + 30, lable.t, bgImgView.w - (lable.r + 30) - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [contentL setText:@"www.956122.com"];
    [bgImgView addSubview:contentL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeight + 30, 160, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [lable setText:@"服务热线"];
    [bgImgView addSubview:lable];
    contentL = [[ UILabel alloc] initWithFrame:LGRectMake(lable.r + 30, lable.t, bgImgView.w - (lable.r + 30) - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [contentL setText:@"4000-956122"];
    [bgImgView addSubview:contentL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeight*2 + 30, 160, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [lable setText:@"微信号"];
    [bgImgView addSubview:lable];
    contentL = [[ UILabel alloc] initWithFrame:LGRectMake(lable.r + 30, lable.t, bgImgView.w - (lable.r + 30) - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [contentL setText:@"w956122"];
    [bgImgView addSubview:contentL];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight - 1)];
    [bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight*2 - 1)];
    [bgImgView addSubview:lineL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(0, (APP_VIEW_Y + APP_HEIGHT - APP_NAV_HEIGHT)/PX_Y_SCALE - 30 - 30 - 30, APP_PX_WIDTH, 30)];
    [lable convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    [lable setText:@"开车邦(北京)科技发展有限公司  版权所有"];
    [self.view addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(0, (APP_VIEW_Y + APP_HEIGHT - APP_NAV_HEIGHT)/PX_Y_SCALE - 30 - 30, APP_PX_WIDTH, 30)];
    [lable convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    [lable setText:@"Copyright© 2014 All Rights RESERVED. "];
    [self.view addSubview:lable];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"关于"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
