//
//  BXSelectInsuranceViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXSelectInsuranceViewController.h"
#import "BXSelecteInsMoneyViewController.h"
#import "BXBaojiaViewController.h"

@interface BXSelectInsuranceViewController ()<
SegmentButtonViewDelegate
>
{
    SegmentButtonView       *_seg;
    UIScrollView            *_rootScrollView;
    UILabel                 *_xzCountLabel;
    
    CGFloat             _pxy;
    CGFloat             _scrollOffsetY;

    //UISwitch            *_force_swi;
    //UISwitch            *_tax_swi;

}

@end

@implementation BXSelectInsuranceViewController


#define TAG_SWITCH_FORCE_INSURANCE          777//交强
#define TAG_SWITCH_TAX_INSURANCE            778//交强

#define TAG_SWITCH_LOSS_INSURANCE           779//车损
#define TAG_SWITCH_ROB_INSURANCE            780//盗抢
#define TAG_SWITCH_NO_COUNT_INSURANCE       781//不计免赔
#define TAG_SWITCH_ON_FIRE_INSURANCE        782//自燃
#define TAG_SWITCH_FDJ_INSURANCE            783//发动机


- (void)createSwitchViewWithPXY:(CGFloat)pxy title:(NSString*)title detail:(NSString*)detail andTag:(NSInteger)tag{
    
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:pxy width:APP_PX_WIDTH height:30 + 30 + 40 + 30 + 30];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:LGRectMake(20, 30, 400, 30)];
    [titleL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [titleL setText:title];
    [bgImgView addSubview:titleL];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(titleL.l, titleL.b + 20)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.w - lineL.l*2, lineL.height)];
    
    UILabel *detailL = [[UILabel alloc] initWithFrame:LGRectMake(titleL.l, titleL.b + 20*2, bgImgView.w - titleL.l*2, titleL.h)];
    [detailL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [detailL setText:detail];
    [bgImgView addSubview:detailL];
    
    
    CGFloat swiY = titleL.t - 15;
    if (iOS7) {
        swiY = titleL.t;
    }
    UISwitch *swi = [[UISwitch alloc] init];
    [swi setFrame:LGRectMake(bgImgView.w - 30 - swi.w, swiY, 0, 0)];
    swi.tag = tag;
    [swi addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    NSString *swichOnStr = @"0";
    switch (tag) {
        case TAG_SWITCH_FDJ_INSURANCE:
            swichOnStr = self.baoxian.ins_fdjx;
            break;
        case TAG_SWITCH_FORCE_INSURANCE:
            swichOnStr = self.baoxian.ins_forceFlag;
            break;
        case TAG_SWITCH_LOSS_INSURANCE:
            swichOnStr = self.baoxian.ins_chesun;
            break;
        case TAG_SWITCH_NO_COUNT_INSURANCE:
            swichOnStr = self.baoxian.ins_buji;
            break;
        case TAG_SWITCH_ON_FIRE_INSURANCE:
            swichOnStr = self.baoxian.ins_ziran;
            break;
        case TAG_SWITCH_ROB_INSURANCE:
            swichOnStr = self.baoxian.ins_daoqiang;
            break;
        case TAG_SWITCH_TAX_INSURANCE:
            swichOnStr = self.baoxian.ins_forceFlag;
            break;
        default:
            break;
    }
    if ([swichOnStr isEqualToString:@"0"]) {
        swi.on = NO;
    }else if ([swichOnStr isEqualToString:@"1"]) {
        swi.on = YES;
    }
    
    [bgImgView addSubview:swi];
    
//    if (tag == TAG_SWITCH_FORCE_INSURANCE) {
//        _force_swi = swi;
//    }else if (tag == TAG_SWITCH_TAX_INSURANCE){
//        _tax_swi = swi;
//    }
    [_rootScrollView addSubview:bgImgView];
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, bgImgView.bottom + 15)];
    _pxy = bgImgView.b + 30;
}

- (void)createListViewWithPXY:(CGFloat)pxy title:(NSString*)title detail:(NSString*)detail andTag:(NSInteger)tag{
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:pxy width:APP_PX_WIDTH height:30 + 30 + 40 + 30 + 30];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:LGRectMake(20, 30, 400, 30)];
    [titleL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [titleL setText:title];
    [bgImgView addSubview:titleL];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(titleL.l, titleL.b + 15)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.w - lineL.l*2, lineL.height)];

    UILabel *detailL = [[UILabel alloc] initWithFrame:LGRectMake(titleL.l, titleL.b + 20*2, bgImgView.w - titleL.l*2, titleL.h)];
    [detailL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [detailL setText:detail];
    [bgImgView addSubview:detailL];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [btn setFrame:LGRectMake(titleL.r + 30, titleL.t, 140, titleL.h)];
    btn.titleLabel.font = FONT_NOMAL;
    btn.tag = tag;
    [btn addTarget:self action:@selector(selectedInsChanged:) forControlEvents:UIControlEventTouchUpInside];
    switch (tag) {
        case TAG_BUTTON_SELECTED_INS_BOLI:
            [btn setTitle:self.baoxian.ins_boli forState:UIControlStateNormal];
            break;
        case TAG_BUTTON_SELECTED_INS_CHENGKE:
            [btn setTitle:self.baoxian.ins_c_zuo forState:UIControlStateNormal];
            break;
        case TAG_BUTTON_SELECTED_INS_SIJI:
            [btn setTitle:self.baoxian.ins_s_zuo forState:UIControlStateNormal];
            break;
        case TAG_BUTTON_SELECTED_INS_HUAHEN:
            [btn setTitle:self.baoxian.ins_huahen forState:UIControlStateNormal];
            break;
        case TAG_BUTTON_SELECTED_INS_SANZHE:
            [btn setTitle:self.baoxian.ins_sanze forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [bgImgView addSubview:btn];
    
    [_rootScrollView addSubview:bgImgView];
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, bgImgView.bottom + 15)];

    _pxy = bgImgView.b + 30;

}

- (void)reloadView{
    _scrollOffsetY = _rootScrollView.contentOffset.y;

    for (UIView *v in _rootScrollView.subviews) {
        
        [v removeFromSuperview];
        _pxy = 30;
    }
    
    [self createSwitchViewWithPXY:_pxy title:INS_FORCE_CHINESE detail:@"国家法律规定的强制险种" andTag:TAG_SWITCH_FORCE_INSURANCE];
    [self createSwitchViewWithPXY:_pxy title:INS_TAX_CHINESE detail:@"以排量为收取标准的国家税收" andTag:TAG_SWITCH_TAX_INSURANCE];
    [self createListViewWithPXY:_pxy title:INS_SAN_ZHE_CHINESE detail:@"赔付需要您承担的他人人身伤亡及财产损失" andTag:TAG_BUTTON_SELECTED_INS_SANZHE];
    [self createSwitchViewWithPXY:_pxy title:INS_CHE_SUN_CHINESE detail:@"赔付您自己爱车的损失" andTag:TAG_SWITCH_LOSS_INSURANCE];
    [self createListViewWithPXY:_pxy title:INS_SI_JI_CHINESE detail:@"车内驾驶员本人的人身伤亡费用" andTag:TAG_BUTTON_SELECTED_INS_SIJI];
    [self createListViewWithPXY:_pxy title:INS_BO_LI_CHINESE detail:@"挡风玻璃和车窗玻璃单独破碎的损失" andTag:TAG_BUTTON_SELECTED_INS_BOLI];
    [self createListViewWithPXY:_pxy title:INS_CHENG_KE_CHINESE detail:@"车内本车乘客(非驾驶员)的人身伤亡费用" andTag:TAG_BUTTON_SELECTED_INS_CHENGKE];
    [self createListViewWithPXY:_pxy title:INS_HUA_HEN_CHINESE detail:@"他人恶意行为造成的车辆车身人为划痕" andTag:TAG_BUTTON_SELECTED_INS_HUAHEN];
    [self createSwitchViewWithPXY:_pxy title:INS_DAO_QIANG_CHINESE detail:@"全车被盗窃、被抢劫、被抢夺时造成的车辆损失" andTag:TAG_SWITCH_ROB_INSURANCE];
    [self createSwitchViewWithPXY:_pxy title:INS_ZI_RAN_CHINESE detail:@"因线路老化等自身原因起火造成车辆本身的损失" andTag:TAG_SWITCH_ON_FIRE_INSURANCE];
    [self createSwitchViewWithPXY:_pxy title:INS_BU_JI_CHINESE detail:@"事故发生后自己不再承担损失，保险公司全包" andTag:TAG_SWITCH_NO_COUNT_INSURANCE];
    [self createSwitchViewWithPXY:_pxy title:INS_FDJX_CHINESE detail:@"车辆因遭水淹或因涉水行驶造成发动机损坏的修复费用" andTag:TAG_SWITCH_FDJ_INSURANCE];

   [_rootScrollView scrollRectToVisible:CGRectMake(0, _scrollOffsetY, _rootScrollView.width, _rootScrollView.height) animated:NO];
    
    
    
    NSString *countStr = [NSString stringWithFormat:@"已选 %d 险种", (int)[self.baoxian.insSelectedArr count]];
    [_xzCountLabel setText:countStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _seg = [[SegmentButtonView alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y/PX_Y_SCALE, APP_PX_WIDTH, 34*2) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
    [_seg setTitles:[NSArray arrayWithObjects:@"基本型", @"实用型", @"全面型", @"自定义", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_NAV];
    [_seg setDelegate:self];
    [_seg setSelectedIndex:0];
    [self segmentButtonView:_seg showView:0];
    [self.view addSubview:_seg];
    
    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _seg.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - _seg.height - buttonBgHeight*PX_Y_SCALE)];
    [_rootScrollView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    _xzCountLabel = [[UILabel alloc] initWithFrame:LGRectMake(0, 15, 2/5.0*buttonBgView.w, buttonBgView.h - 15*2)];
    [_xzCountLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentCenter];
    [buttonBgView addSubview:_xzCountLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(2/5.0*buttonBgView.w, 15, 3/5.0*buttonBgView.w - 30, buttonBgView.h - 15*2);
    [button setTitle:@"查看报价" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];

    
    _scrollOffsetY = 0;
    _pxy = 30;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:self.baoxian.hphm];

    [self reloadView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    

}


#pragma mark- DELEGATE
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    
    if (index == 0) {//基本型
        /*
         机动车交通事故责任强制保险
         车船使用税
         机动车第三者责任保险（保额：10万元）
         机动车损失险
         不计免赔险
         */
        self.baoxian.ins_chesun = @"1";
        self.baoxian.ins_daoqiang = @"0";
        self.baoxian.ins_ziran = @"0";
        self.baoxian.ins_buji = @"1";
        self.baoxian.ins_forceFlag = @"1";
        self.baoxian.ins_fdjx = @"0";
        
        self.baoxian.ins_boli = @"不投保";
        self.baoxian.ins_sanze = @"50万";
        self.baoxian.ins_c_zuo = @"不投保";
        self.baoxian.ins_s_zuo = @"不投保";
        self.baoxian.ins_huahen = @"不投保";
        
        self.baoxian.ins_boli_code = @"0";
        self.baoxian.ins_sanze_code = @"500000";
        self.baoxian.ins_c_zuo_code = @"0";
        self.baoxian.ins_s_zuo_code = @"0";
        self.baoxian.ins_huahen_code = @"0";
    }else if (index == 1){//实用型：
        /*
         机动车交通事故责任强制保险
         车船使用税
         机动车第三者责任保险（保额：10万元）
         机动车损失险
         车上人员责任险(司机)（保额：5万元）
         玻璃单独破碎险（国产）
         机动车盗抢险                  
         不计免赔险
         */
        self.baoxian.ins_chesun = @"1";
        self.baoxian.ins_daoqiang = @"1";
        self.baoxian.ins_ziran = @"0";
        self.baoxian.ins_buji = @"1";
        self.baoxian.ins_forceFlag = @"1";
        self.baoxian.ins_fdjx = @"0";
        
        self.baoxian.ins_boli = @"国产";
        self.baoxian.ins_sanze = @"50万";
        self.baoxian.ins_c_zuo = @"不投保";
        self.baoxian.ins_s_zuo = @"5万";
        self.baoxian.ins_huahen = @"不投保";
        
        self.baoxian.ins_boli_code = @"1";
        self.baoxian.ins_sanze_code = @"500000";
        self.baoxian.ins_c_zuo_code = @"0";
        self.baoxian.ins_s_zuo_code = @"50000";
        self.baoxian.ins_huahen_code = @"0";
    }else if (index == 2){//全面型：
        /*
         机动车交通事故责任强制保险
         车船使用税
         机动车第三者责任保险（保额：10万元）
         机动车损失险
         车身划痕损失险 （保额：2000元）
         车上人员责任险(司机)（保额：5万元）
         车上人员责任险(乘客)（保额：1万元）
         玻璃单独破碎险（国产）
         机动车盗抢险
         发动机特别损失险（涉水险） 
         自燃损失险                   
         不计免赔险
         */
        self.baoxian.ins_chesun = @"1";
        self.baoxian.ins_daoqiang = @"1";
        self.baoxian.ins_ziran = @"1";
        self.baoxian.ins_buji = @"1";
        self.baoxian.ins_forceFlag = @"1";
        self.baoxian.ins_fdjx = @"1";
        
        self.baoxian.ins_boli = @"国产";
        self.baoxian.ins_sanze = @"50万";
        self.baoxian.ins_c_zuo = @"1万";
        self.baoxian.ins_s_zuo = @"5万";
        self.baoxian.ins_huahen = @"2千";
        
        self.baoxian.ins_boli_code = @"1";
        self.baoxian.ins_sanze_code = @"500000";
        self.baoxian.ins_c_zuo_code = @"10000";
        self.baoxian.ins_s_zuo_code = @"50000";
        self.baoxian.ins_huahen_code = @"2000";

    }else if (index == 3){//自定义：
        self.baoxian.ins_chesun = @"0";
        self.baoxian.ins_daoqiang = @"0";
        self.baoxian.ins_ziran = @"0";
        self.baoxian.ins_buji = @"0";
        self.baoxian.ins_forceFlag = @"1";
        self.baoxian.ins_fdjx = @"0";
        
        self.baoxian.ins_boli = @"不投保";
        self.baoxian.ins_sanze = @"不投保";
        self.baoxian.ins_c_zuo = @"不投保";
        self.baoxian.ins_s_zuo = @"不投保";
        self.baoxian.ins_huahen = @"不投保";
        
        self.baoxian.ins_boli_code = @"0";
        self.baoxian.ins_sanze_code = @"0";
        self.baoxian.ins_c_zuo_code = @"0";
        self.baoxian.ins_s_zuo_code = @"0";
        self.baoxian.ins_huahen_code = @"0";

    }
    [_rootScrollView scrollRectToVisible:CGRectMake(0, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    [self reloadView];
}

- (void)switchValueChanged:(UISwitch*)swi{
//    if (swi.tag == TAG_SWITCH_FORCE_INSURANCE || swi.tag == TAG_SWITCH_TAX_INSURANCE) {
//        _tax_swi.on = swi.on;
//        _force_swi.on = swi.on;
//    }
    
    NSString *str = @"0";
    if (swi.on) {
        str = @"1";
    }
    switch (swi.tag) {
        case TAG_SWITCH_FDJ_INSURANCE://发动机
            self.baoxian.ins_fdjx = str;
            break;
        case TAG_SWITCH_FORCE_INSURANCE://交强
            self.baoxian.ins_forceFlag = str;
            break;
        case TAG_SWITCH_TAX_INSURANCE://交强
            self.baoxian.ins_forceFlag = str;
            break;
        case TAG_SWITCH_LOSS_INSURANCE://车损
            self.baoxian.ins_chesun = str;
            break;
        case TAG_SWITCH_NO_COUNT_INSURANCE://不计免赔
            self.baoxian.ins_buji = str;
            break;
        case TAG_SWITCH_ROB_INSURANCE://盗抢
            self.baoxian.ins_daoqiang = str;
            break;
        case TAG_SWITCH_ON_FIRE_INSURANCE://自燃
            self.baoxian.ins_ziran = str;
            break;
            
        default:
            break;
    }
    [self reloadView];
    
}


- (void)selectedInsChanged:(UIButton*)button{
    
    BXSelecteInsMoneyViewController *vc = [[BXSelecteInsMoneyViewController alloc] init];
    vc.ins_type_tag = button.tag;
    vc.baoxian = self.baoxian;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark- ACTION
- (void)nextStepButtonClicked{
    
    BXBaojiaViewController *vc = [[BXBaojiaViewController alloc] init];
    vc.baoxian = self.baoxian;
    [self.navigationController pushViewController:vc animated:YES];

    
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
