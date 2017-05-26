//
//  BXDetailViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXDetailViewController.h"
#import "BXOrderFormViewController.h"

@interface BXDetailViewController ()

@end

@implementation BXDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat buttonBgHeight = 60 + 20 + 20;
    CGFloat scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT;
    CGSize ygSpecialMsgSize = [self.ygSpecialMsg sizeWithFont:FONT_NOTICE constrainedToSize:CGSizeMake(APP_WIDTH, 1000000)];

    if (self.showNextButton) {
        if (![self.ygSpecialMsg isEqualToString:@""]){
            scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT - ygSpecialMsgSize.height;
        }else{
            scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE;
        }
        
    }
    UIScrollView *rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, scrollViewH)];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    
    CGFloat height = 120;
    CGFloat contentLineHeight = 90;
    NSInteger count = [[self.insDetailPriceDict allKeys] count] - 1;//sessionid
    NSString *bujiprice = [self.insDetailPriceDict objectForKey:INS_BU_JI_CHINESE];
    if (bujiprice) {
        if ([[bujiprice substringToIndex:1] isEqualToString:@"0"]) {
            count = count - 6;
        
        }
    }
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:(contentLineHeight*count + height*2)];
    [rootScrollView addSubview:bgImgView];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.width - 30*2*PX_X_SCALE, lineL.height)];
    
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 199*75/93, 75)];////199 × 93
    [bgImgView addSubview:logoImgView];
    NSString *imgName = nil;
    if (self.ins_name_code == TAG_TAI_PING_YANG) {
        imgName = @"ins_taipingyang";
    }else if (self.ins_name_code == TAG_YANG_GUANG){
        imgName = @"ins_yangguang";
        
    }else if (self.ins_name_code == TAG_PING_AN){
        imgName = @"ins_pingan";
        
    }else if (self.ins_name_code == TAG_REN_BAO){
        imgName = @"ins_renbao";
        
    }
    [logoImgView setImage:[UIImage imageNamed:imgName]];
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in [self.insDetailPriceDict allKeys]){
        if ([key isEqualToString:INS_KEY_SUM_PRICE]) {
            continue;
        }
        if ([key isEqualToString:INS_KEY_SESSION_ID]) {
            continue;
        }
        if ([key isEqualToString:INS_BU_JI_SANZHE_CHINESE] || [key isEqualToString:INS_BU_JI_CHENGKE_CHINESE] || [key isEqualToString:INS_BU_JI_CHESUN_CHINESE] || [key isEqualToString:INS_BU_JI_CHINESE] || [key isEqualToString:INS_BU_JI_DAOQIANG_CHINESE] || [key isEqualToString:INS_BU_JI_FDJ_CHINESE] || [key isEqualToString:INS_BU_JI_SIJI_CHINESE]) {

            continue;
        }
        
        [arr addObject:key];
    }
    if (bujiprice) {
        [arr addObject:INS_BU_JI_CHINESE];
        if (![[bujiprice substringToIndex:1] isEqualToString:@"0"]) {
            [arr addObject:INS_BU_JI_CHENGKE_CHINESE];
            [arr addObject:INS_BU_JI_CHESUN_CHINESE];
            [arr addObject:INS_BU_JI_DAOQIANG_CHINESE];
            [arr addObject:INS_BU_JI_FDJ_CHINESE];
            [arr addObject:INS_BU_JI_SANZHE_CHINESE];
            [arr addObject:INS_BU_JI_SIJI_CHINESE];
        }
    }
    [arr addObject:INS_KEY_SUM_PRICE];
    
    CGFloat labelH = 30;
    CGFloat labelW = bgImgView.w - 30*2;
    for (int i = 0; i < [arr count]; i ++) {
        NSString *key = [arr objectAtIndex:i];
        
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, height + i*contentLineHeight + labelH, labelW, labelH)];
        
        if ([key rangeOfString:@"不计免赔"].location != NSNotFound) {
            if (![key isEqualToString:@"不计免赔险"]) {
                [label setText:[NSString stringWithFormat:@"  --%@", key]];
                [label convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
            }else{
                [label setText:key];
                [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
            }
        }else{
            [label setText:key];
            [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        }
        
        [bgImgView addSubview:label];
        
        
        label = [[UILabel alloc] initWithFrame:LGRectMake(30, height + i*contentLineHeight + labelH, labelW, labelH)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
        NSString *price = [self.insDetailPriceDict objectForKey:key];
        if ([[price substringToIndex:1] isEqualToString:@"0"]) {
            price = @"不可投保";
        }
        [label setText:price];
        [bgImgView addSubview:label];
    }
    
    
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, bgImgView.h - height)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.width - 30*2*PX_X_SCALE, lineL.height)];
    
    UILabel *insCountL = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, lineL.b + 45, bgImgView.w - lineL.l*2, 30)];
    [insCountL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_NAV textAlignment:NSTextAlignmentLeft];
    [insCountL setText:[NSString stringWithFormat:@"共选择 %d 险种", (int)[self.baoxian.insSelectedArr count]]];
    [bgImgView addSubview:insCountL];
    
    UILabel *priceL = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, lineL.b + 45, bgImgView.w - lineL.l*2, 30)];
    [priceL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_NAV textAlignment:NSTextAlignmentRight];
    [priceL setText:[NSString stringWithFormat:@"需支付：%@", [self.insDetailPriceDict objectForKey:INS_KEY_SUM_PRICE]]];
    [bgImgView addSubview:priceL];

    
/*-------------------------------------车主详情及车辆信息--------------------------------------------*/
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:(contentLineHeight*6 + height)];
    [rootScrollView addSubview:bgImgView];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.width - 30*2*PX_X_SCALE, lineL.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 45, bgImgView.w - lineL.l*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车主详情及车辆信息"];
    [bgImgView addSubview:label];
    for (int i = 0; i < 6; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, height + i*contentLineHeight + labelH, labelW, labelH + 10)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [bgImgView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"车牌号：%@", self.baoxian.hphm];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"车主姓名：%@", self.baoxian.syr];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"身份证号：%@", self.baoxian.sfzhm];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"注册日期：%@", self.baoxian.zcrq];
                break;
            case 4:
                contentStr = [NSString stringWithFormat:@"发动机号：%@", self.baoxian.fdjh];
                break;
            case 5:
                contentStr = [NSString stringWithFormat:@"车辆识别代号：%@", self.baoxian.vin];
                break;
            default:
                break;
        }
        [label setText:contentStr];
    }
    if (bgImgView.b + 30 > rootScrollView.h) {
        [rootScrollView setContentSize:CGSizeMake(rootScrollView.width, bgImgView.bottom + 30*PX_Y_SCALE)];
    }
    
    if (self.showNextButton && [self.ygSpecialMsg isEqualToString:@""]) {
        UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
        buttonBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:buttonBgView];
        UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
        [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
        [buttonBgView addSubview:lineLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
        [button setTitle:@"立即购买" forState:UIControlStateNormal];
        button.titleLabel.font = FONT_NOMAL;
        [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        [buttonBgView addSubview:button];
    }
    
    if (![self.ygSpecialMsg isEqualToString:@""]){
        
        
        
        UIView *ygSpecialMsgBgView = [[UIView alloc] initWithFrame:BGRectMake(0, rootScrollView.b, APP_PX_WIDTH, ygSpecialMsgSize.height/PX_Y_SCALE)];
        ygSpecialMsgBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:ygSpecialMsgBgView];
        
        UILabel *ygSpecialMsgL = [[UILabel alloc] initWithFrame:ygSpecialMsgBgView.bounds];
        ygSpecialMsgL.numberOfLines = 0;
        [ygSpecialMsgL convertNewLabelWithFont:FONT_NOTICE textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
        [ygSpecialMsgL setText:self.ygSpecialMsg];
        [ygSpecialMsgBgView addSubview:ygSpecialMsgL];
    }
    
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"车险详情"];

    
}

- (void)nextStepButtonClicked{
    BXOrderFormViewController *bxofVC = [[BXOrderFormViewController alloc] init];
    bxofVC.baoxian = self.baoxian;
    bxofVC.insDetailPriceDict = self.insDetailPriceDict;
    bxofVC.ins_name_code = self.ins_name_code;
    [self.navigationController pushViewController:bxofVC animated:YES];

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
