//
//  BXOrderFormViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXOrderFormViewController.h"
#import "BXDetailViewController.h"
#import "BXAddHongBaoViewController.h"
#import "BXAddInfoViewController.h"
#import "BXAddDeliverInfoViewController.h"
#import "BXAddBeibaorenAddrViewController.h"
#import "BXOrderPayViewController.h"

@interface BXOrderFormViewController ()<
UIAlertViewDelegate
>
{
    BOOL            _payOnline;
    UIButton        *_payOnlineButton;
    UIButton        *_payOfflineButton;
    UIImageView     *_payOnlineImgView;
    UIImageView     *_payOfflineImgView;
}
@property (nonatomic)   NSMutableDictionary     *toubaorenInfoDict;
@property (nonatomic)   NSMutableDictionary     *beibaorenInfoDict;
@property (nonatomic)   NSMutableDictionary     *chezhuInfoDict;
@property (nonatomic)   NSMutableDictionary     *deliverInfoDict;
@property (nonatomic)   NSMutableDictionary     *beibaorenAddrInfoDict;

@end

#define TAG_BUTTON_PAY_ONLINE       111
#define TAG_BUTTON_PAY_OFFLINE      112

@implementation BXOrderFormViewController

- (void)loadView_{
    CGFloat buttonBgHeight = 60 + 20 + 20;
    UIScrollView *rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    
    CGFloat height = 120;
    CGFloat contentLineHeight = 90;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:(contentLineHeight*1 + height*1)];
    [rootScrollView addSubview:bgImgView];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, contentLineHeight)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.width - 30*2*PX_X_SCALE, lineL.height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 200, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"保单详情"];
    [bgImgView addSubview:label];
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:LGRectMake(0, 0, bgImgView.w, contentLineHeight)];
    [button addTarget:self action:@selector(detailButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:button];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, lineL.b + 30, 199*75/93, 75)];////199 × 93
    [bgImgView addSubview:logoImgView];
    NSString *imgName = nil;
    NSString *baoxianName = @"";
    if (self.ins_name_code == TAG_TAI_PING_YANG) {
        imgName = @"ins_taipingyang";
        baoxianName = @"太平洋保险";
    }else if (self.ins_name_code == TAG_YANG_GUANG){
        imgName = @"ins_yangguang";
        baoxianName = @"阳光保险";
        
    }else if (self.ins_name_code == TAG_PING_AN){
        imgName = @"ins_pingan";
        baoxianName = @"平安保险";
        
    }else if (self.ins_name_code == TAG_REN_BAO){
        imgName = @"ins_renbao";
        baoxianName = @"人保财险";
        
    }
    [logoImgView setImage:[UIImage imageNamed:imgName]];
    label = [[UILabel alloc] initWithFrame:LGRectMake(logoImgView.r + 30, logoImgView.t + logoImgView.h/2 - 30, 200, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:baoxianName];
    [label setSize:[label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(10000, label.height)]];
    [bgImgView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(label.r, lineL.b + 20, bgImgView.w - 30 - label.r, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [label setText:[NSString stringWithFormat:@"共选择 %d 险种", (int)[self.baoxian.insSelectedArr count]]];
    [bgImgView addSubview:label];
    label = [[UILabel alloc] initWithFrame:LGRectMake(label.l, label.b + 15, label.w, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [label setText:[NSString stringWithFormat:@"总价：%@元", [self.insDetailPriceDict objectForKey:INS_KEY_SUM_PRICE]]];
    [bgImgView addSubview:label];
    
    
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight + 30 + 30];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, bgImgView.w - 30*2, 30 + 30 + 30)];
    [label convertNewLabelWithFont:FONT_NOTICE textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
    [label setText:@"通过本平台成功购买保险后，将返还您200~500元不等的现金红包。成功购买后请及时联系我们的客服人员领取您的红包！！"];
    label.numberOfLines = 0;
    [bgImgView addSubview:label];
    //    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    //    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    //    [arrowImgV setUserInteractionEnabled:YES];
    //    [bgImgView addSubview:arrowImgV];
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddYhq)];
    //    [bgImgView addGestureRecognizer:tap];
    
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"完善被保人信息"];
    [bgImgView addSubview:label];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddBeibaorenInfo)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"完善投保人信息"];
    [bgImgView addSubview:label];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddToubaorenInfo)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"完善车主信息"];
    [bgImgView addSubview:label];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddCarOwnerInfo)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"完善收件人信息"];
    [bgImgView addSubview:label];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddContactInfo)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"被保人身份证地址"];
    [bgImgView addSubview:label];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (contentLineHeight - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddBeibaorenAddr)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:contentLineHeight*2];
    [rootScrollView addSubview:bgImgView];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, contentLineHeight)];
    [bgImgView addSubview:lineL];
    [lineL setSize:CGSizeMake(bgImgView.width - 30*2*PX_X_SCALE, lineL.height)];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, bgImgView.w - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"网银支付"];
    [bgImgView addSubview:label];
    _payOnlineImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30*2, 30, 30, 30)];
    [_payOnlineImgView setImage:[UIImage imageNamed:@"button_duihao_selected.png"]];
    [bgImgView addSubview:_payOnlineImgView];
    _payOnlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payOnlineButton setFrame:LGRectMake(0, 0, bgImgView.w, 90)];
    _payOnlineButton.tag = TAG_BUTTON_PAY_ONLINE;
    [_payOnlineButton addTarget:self action:@selector(payWayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_payOnlineButton];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + 30, bgImgView.w - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"线下支付"];
    [bgImgView addSubview:label];
    _payOfflineImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30*2, contentLineHeight + 30, 30, 30)];
    [_payOfflineImgView setImage:[UIImage imageNamed:@"button_duihao_unselected.png"]];
    [bgImgView addSubview:_payOfflineImgView];
    _payOfflineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payOfflineButton setFrame:LGRectMake(0, contentLineHeight, bgImgView.w, 90)];
    _payOfflineButton.tag = TAG_BUTTON_PAY_OFFLINE;
    [_payOfflineButton addTarget:self action:@selector(payWayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_payOfflineButton];
    
    _payOnline = YES;
    
    [rootScrollView setContentSize:CGSizeMake(rootScrollView.width, bgImgView.bottom + 30*PX_Y_SCALE)];
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"确认订单" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.toubaorenInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.beibaorenInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.chezhuInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.deliverInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.beibaorenAddrInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    self.toubaorenInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_INS_INFO_TEL, self.baoxian.sfzhm, KEY_INS_INFO_SFZHM, self.baoxian.syr, KEY_INS_INFO_NAME, @"", KEY_INS_INFO_EMAIL, nil];
    self.beibaorenInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_INS_INFO_TEL, self.baoxian.sfzhm, KEY_INS_INFO_SFZHM, self.baoxian.syr, KEY_INS_INFO_NAME, @"", KEY_INS_INFO_EMAIL, nil];
    self.chezhuInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_INS_INFO_TEL, self.baoxian.sfzhm, KEY_INS_INFO_SFZHM, self.baoxian.syr, KEY_INS_INFO_NAME, @"", KEY_INS_INFO_EMAIL, nil];
//    self.deliverInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_INS_INFO_TEL, @"", KEY_INS_INFO_NAME, @"", KEY_INS_INFO_PROVINCE_DICT, @"", KEY_INS_INFO_CITY_DICT, @"", KEY_INS_INFO_REGION_DICT, @"", KEY_INS_INFO_DETAIL_ADDR, nil];
//    self.beibaorenAddrInfoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", KEY_INS_INFO_PROVINCE_DICT, @"", KEY_INS_INFO_CITY_DICT, @"", KEY_INS_INFO_REGION_DICT, @"", KEY_INS_INFO_DETAIL_ADDR, nil];
    [self loadView_];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"确认订单"];
    
}

- (void)payWayButtonClicked:(UIButton*)button{
    
    if (button.tag == TAG_BUTTON_PAY_OFFLINE) {
        [_payOnlineImgView setImage:[UIImage imageNamed:@"button_duihao_unselected.png"]];
        [_payOfflineImgView setImage:[UIImage imageNamed:@"button_duihao_selected.png"]];
        _payOnline = NO;

    }else if (button.tag == TAG_BUTTON_PAY_ONLINE){
        
        [_payOnlineImgView setImage:[UIImage imageNamed:@"button_duihao_selected.png"]];
        [_payOfflineImgView setImage:[UIImage imageNamed:@"button_duihao_unselected.png"]];
        _payOnline = YES;
    }
    
}


//- (void)tapToAddYhq{
//    BXAddHongBaoViewController *vc = [[BXAddHongBaoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}

- (void)tapToAddBeibaorenInfo{
    BXAddInfoViewController *vc = [[BXAddInfoViewController alloc] init];
    vc.identification = IDENTIFICATION_ADD_INS_INFO_BEIBAOREN;
    vc.infoDict = self.beibaorenInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapToAddToubaorenInfo{
    BXAddInfoViewController *vc = [[BXAddInfoViewController alloc] init];
    vc.identification = IDENTIFICATION_ADD_INS_INFO_TOUBAOREN;
    vc.infoDict = self.toubaorenInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapToAddCarOwnerInfo{
    BXAddInfoViewController *vc = [[BXAddInfoViewController alloc] init];
    vc.identification = IDENTIFICATION_ADD_INS_INFO_CHEZHU;
    vc.infoDict = self.chezhuInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapToAddContactInfo{
    BXAddDeliverInfoViewController *vc = [[BXAddDeliverInfoViewController alloc] init];
    vc.infoDict = self.deliverInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapToAddBeibaorenAddr{
    BXAddBeibaorenAddrViewController *vc = [[BXAddBeibaorenAddrViewController alloc] init];
    vc.infoDict = self.beibaorenAddrInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)detailButtonClicked{
    
    BXDetailViewController *vc = [[BXDetailViewController alloc] init];
    vc.baoxian = self.baoxian;
    vc.insDetailPriceDict = self.insDetailPriceDict;
    vc.ins_name_code = self.ins_name_code;
    vc.showNextButton = NO;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)nextStepButtonClicked{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返现金" message:@"在成功购买保险后，请不要忘记联系我们的客服人员领取现金红包哦~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self netSubmitOrderForm];
}

- (void)netSubmitOrderForm{

    NSMutableDictionary *bodyDict = [self package];
    if (!bodyDict) {
        return;
    }
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *bodyStr = [writer stringWithObject:bodyDict];
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];//@"132.96.77.120:8080"
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_applyYg.action" params:[NSDictionary dictionaryWithObjectsAndKeys:bodyStr, @"orderinfo", nil] httpMethod:@"POST"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"cx_applyYg.action==>%@", completedOperation.responseString);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        NSString *status = [resDict analysisStrValueByKey:@"status"];
        if ([status isEqualToString:@"100"]) {
            NSString *jmorderid = [resDict analysisStrValueByKey:@"jmorderid"];
            NSString *jminsuredName = [resDict analysisStrValueByKey:@"jminsuredName"];
            NSString *oiderid = [resDict analysisStrValueByKey:@"oiderid"];
            /*
            {"status":100,"ErrorMessage":"","jmorderid":"52c8c2d6b744d29f81b85db2001eada472e3e0fc839cbe19","jminsuredName":"b927cecaf4646cd24614b461b9f88d83","oiderid":"T245805092015002815"}
            
            */
            if (_payOnline){
                BXOrderPayViewController *vc = [[BXOrderPayViewController alloc] init];
                vc.companyName = @"阳光保险";
                vc.orderNo = oiderid;
                vc.price = [self.insDetailPriceDict objectForKey:INS_KEY_SUM_PRICE];
                vc.goodsName = @"车险付款订单";
                vc.jminsuredName = jminsuredName;
                vc.jmorderid = jmorderid;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSString *msgStr = [NSString stringWithFormat:@"尊敬的用户您好，您已成功下单，订单编号：%@，订单金额：%@，24小时内会有保险公司相关人员联系您进一步完成订单，请您耐心等待。", @"", @""];
                [UIAlertView alertTitle:@"您已成功下单" msg:msgStr];
            }
            
        }else if ([status isEqualToString:@"400"]){
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"提交订单" msg:errorMessage];
        }else{
            [UIAlertView alertTitle:@"提交订单" msg:@"服务器返回数据格式异常,无法解析！"];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        //
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:@"提交订单" msg:errStr];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
    
    [en enqueueOperation:op];
}


- (NSMutableDictionary*)package{
    
    
/************************************被保人信息******************************************************/
    NSString *insuredIdNo = [self.beibaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_SFZHM];
    NSString *insuredEmail = [self.beibaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_EMAIL];
    NSString *insuredName = [self.beibaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_NAME];
    NSString *insuredMobile = [self.beibaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_TEL];
    
    if (!insuredEmail || [insuredEmail isEqualToString:@""]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"被保人邮箱不能为空，请检查并修改后重新提交！"];
        return nil;
    }
    if (!insuredName || [insuredName isEqualToString:@""]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"被保人姓名不能为空，请检查并修改后重新提交！"];
        return nil;
    }
    if (!insuredIdNo || ![insuredIdNo isValidIDNumber]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"被保人身份证号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }
    if (!insuredMobile || ![insuredMobile isValidPhoneNum]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"被保人手机号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }
    
    NSMutableDictionary *insuredInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [insuredInfo setObject:insuredIdNo forKey:@"insuredIdNo"];
    [insuredInfo setObject:insuredEmail forKey:@"insuredEmail"];
    [insuredInfo setObject:[insuredName  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"insuredName"];
    [insuredInfo setObject:insuredMobile forKey:@"insuredMobile"];
    
/************************************投保人信息******************************************************/
    
    NSString *applicantEmail = [self.toubaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_EMAIL];
    NSString *applicantIdNo = [self.toubaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_SFZHM];
    NSString *applicantMobile = [self.toubaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_TEL];
    NSString *applicantName = [self.toubaorenInfoDict analysisStrValueByKey:KEY_INS_INFO_NAME];
    
    if (!applicantEmail || [applicantEmail isEqualToString:@""]) {
        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人邮箱不能为空，请检查并修改后重新提交！"];
        return nil;
    }
    if (!applicantName || [applicantName isEqualToString:@""]) {
        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人姓名不能为空，请检查并修改后重新提交！"];
        return nil;
    }
    if (!applicantIdNo || ![applicantIdNo isValidIDNumber]) {
        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人身份证号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }
    if (!applicantMobile || ![applicantMobile isValidPhoneNum]) {
        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人手机号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }
    
    NSMutableDictionary *applicantInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [applicantInfo setObject:applicantEmail forKey:@"applicantEmail"];
    [applicantInfo setObject:applicantIdNo forKey:@"applicantIdNo"];
    [applicantInfo setObject:applicantMobile forKey:@"applicantMobile"];
    [applicantInfo setObject:[applicantName  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"applicantName"];
    
/*************************************车主信息******************************************************/
    NSString *ownerName = [self.chezhuInfoDict analysisStrValueByKey:KEY_INS_INFO_NAME];
    NSString *ownerMobile = [self.chezhuInfoDict analysisStrValueByKey:KEY_INS_INFO_TEL];
    NSString *ownerIdNo = [self.chezhuInfoDict analysisStrValueByKey:KEY_INS_INFO_SFZHM];
    NSString *ownerEmail = [self.chezhuInfoDict analysisStrValueByKey:KEY_INS_INFO_EMAIL];
    
    if (!ownerEmail || [ownerEmail isEqualToString:@""]) {
        [UIAlertView alertTitle:@"车主信息" msg:@"车主邮箱不能为空，请检查并修改后重新提交！"];
        return nil;
    }
//    if (!applicantName || [applicantName isEqualToString:@""]) {
//        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人姓名不能为空，请检查并修改后重新提交！"];
//        return nil;
//    }
//    if (!applicantIdNo || ![applicantIdNo isValidIDNumber]) {
//        [UIAlertView alertTitle:@"投保人信息" msg:@"投保人身份证号码填写有误，请检查并修改后重新提交！"];
//        return nil;
//    }
    if (!ownerMobile || ![ownerMobile isValidPhoneNum]) {
        [UIAlertView alertTitle:@"车主信息" msg:@"车主手机号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }

    
    NSMutableDictionary *ownerInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [ownerInfo setObject:[ownerName  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"ownerName"];
    [ownerInfo setObject:ownerMobile forKey:@"ownerMobile"];
    [ownerInfo setObject:ownerIdNo forKey:@"ownerIdNo"];
    [ownerInfo setObject:ownerEmail forKey:@"ownerEmail"];
    
/*************************************收件人信息******************************************************/
    NSString *pname = [[[self.beibaorenAddrInfoDict objectForKey:KEY_INS_INFO_PROVINCE_DICT] allKeys] lastObject];
    NSString *cname = [[[self.beibaorenAddrInfoDict objectForKey:KEY_INS_INFO_CITY_DICT] allKeys] lastObject];
    NSString *rname = [[[self.beibaorenAddrInfoDict objectForKey:KEY_INS_INFO_REGION_DICT] allKeys] lastObject];
    NSString *detailAddr = [self.beibaorenAddrInfoDict analysisStrValueByKey:KEY_INS_INFO_DETAIL_ADDR];
    if (!pname || !cname || !rname || !detailAddr || [detailAddr isEqualToString:@""]) {
        [UIAlertView alertTitle:nil msg:@"被保人身份证地址信息部分为空，请填写后重新提交！"];
        return nil;
    }
    NSString *beibaorenAddr = [NSString stringWithFormat:@"%@ %@ %@ %@", pname, cname, rname, detailAddr] ;
    
    
    NSString *deliverPname = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_PROVINCE_DICT] allKeys] lastObject];
    NSString *deliverCname = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_CITY_DICT] allKeys] lastObject];
    NSString *deliverRname = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_REGION_DICT] allKeys] lastObject];
    NSString *deliverDetailAddr = [self.deliverInfoDict analysisStrValueByKey:KEY_INS_INFO_DETAIL_ADDR];
    if (!deliverPname || !deliverCname || !deliverRname || !deliverDetailAddr || [deliverDetailAddr isEqualToString:@""]) {
        [UIAlertView alertTitle:nil msg:@"收件人地址信息部分为空，请填写后重新提交！"];
        return nil;
    }
    NSString *deliverAddr = [NSString stringWithFormat:@"%@ %@ %@ %@", deliverPname, deliverCname, deliverRname, deliverDetailAddr] ;
    
    NSString *addresseeName = [self.deliverInfoDict analysisStrValueByKey:KEY_INS_INFO_NAME];
    NSString *addresseeMobile = [self.deliverInfoDict analysisStrValueByKey:KEY_INS_INFO_TEL];
    if (!addresseeName || [addresseeName isEqualToString:@""]) {
        [UIAlertView alertTitle:@"收件人信息" msg:@"收件人姓名不能为空，请检查并修改后重新提交！"];
        return nil;
    }
    if (!addresseeMobile || ![addresseeMobile isValidPhoneNum]) {
        [UIAlertView alertTitle:@"收件人信息" msg:@"收件人手机号码填写有误，请检查并修改后重新提交！"];
        return nil;
    }
    NSString *deliverPcode = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_PROVINCE_DICT] allValues] lastObject];
    if (!deliverPcode) {
        deliverPcode = @"";
    }
    NSString *deliverCcode = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_CITY_DICT] allValues] lastObject];
    if (!deliverCcode) {
        deliverCcode = @"";
    }
    NSString *deliverRcode = [[[self.deliverInfoDict objectForKey:KEY_INS_INFO_REGION_DICT] allValues] lastObject];
    if (!deliverRcode) {
        deliverRcode = @"";
    }
    
    NSMutableDictionary *deliverInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [deliverInfo setObject:[beibaorenAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"insuredaddresseeDetails"];
    [deliverInfo setObject:[deliverAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]forKey:@"addresseeDetails"];
    [deliverInfo setObject:[addresseeName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"addresseeName"];
    [deliverInfo setObject:addresseeMobile forKey:@"addresseeMobile"];
    [deliverInfo setObject:deliverPcode forKey:@"addresseeProvince"];
    [deliverInfo setObject:deliverCcode forKey:@"addresseeCity"];
    [deliverInfo setObject:deliverRcode forKey:@"addresseeTown"];
    
/*************************************车信息******************************************************/
    NSMutableDictionary *vehicle = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *hphm = [self.baoxian.hphm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *clsyr = [self.baoxian.syr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sfzhm = self.baoxian.sfzhm;
    NSString *ccdjrq = self.baoxian.zcrq;
    NSString *fdjh = self.baoxian.fdjh;
    NSString *clsbdh = self.baoxian.vin;
    [vehicle setObject:hphm forKey:@"hphm"];
    [vehicle setObject:clsyr forKey:@"clsyr"];
    [vehicle setObject:sfzhm forKey:@"sfzhm"];
    [vehicle setObject:ccdjrq forKey:@"ccdjrq"];
    [vehicle setObject:fdjh forKey:@"fdjh"];
    [vehicle setObject:clsbdh forKey:@"clsbdh"];
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *bujiKeys = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *bujiSubKeys = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in [self.insDetailPriceDict allKeys]){
        if ([key isEqualToString:INS_KEY_SUM_PRICE]) {
            continue;
        }
        if ([key isEqualToString:INS_KEY_SESSION_ID]) {
            continue;
        }
        if ([key isEqualToString:INS_BU_JI_CHINESE]) {
            [bujiKeys addObject:key];
            continue;
        }
        if ([key isEqualToString:INS_BU_JI_SANZHE_CHINESE] || [key isEqualToString:INS_BU_JI_CHENGKE_CHINESE] || [key isEqualToString:INS_BU_JI_CHESUN_CHINESE] || [key isEqualToString:INS_BU_JI_DAOQIANG_CHINESE] || [key isEqualToString:INS_BU_JI_FDJ_CHINESE] || [key isEqualToString:INS_BU_JI_SIJI_CHINESE]) {
            
            
            [bujiSubKeys addObject:key];
            continue;
        }
        
        [keys addObject:key];
    }
    NSMutableArray *prodocts = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in keys) {
        if ([key isEqualToString:INS_KEY_SESSION_ID]) {
            continue;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dict setObject:[key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"productName"];
        [dict setObject:[self.insDetailPriceDict objectForKey:key] forKey:@"productPrice"];
        [prodocts addObject:dict];
    }
    
    
    
    NSString *cityName = [self.baoxian.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *cityCode = self.baoxian.citycode;
    NSString *insuranceType = @"";
    if (self.ins_name_code == TAG_REN_BAO) {
        insuranceType = @"1";
    }else if (self.ins_name_code == TAG_YANG_GUANG){
        insuranceType = @"2";
        
    }else if (self.ins_name_code == TAG_TAI_PING_YANG){
        insuranceType = @"4";
        
    }else if (self.ins_name_code == TAG_PING_AN){
        insuranceType = @"3";
        
    }
    NSString *totalPrice = [self.insDetailPriceDict objectForKey:INS_KEY_SUM_PRICE];
    NSString *totalAmount = [NSString stringWithFormat:@"%d", (int)[self.baoxian.insSelectedArr count]];
    NSString *username = [APP_DELEGATE.userName  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sessionid = [self.insDetailPriceDict objectForKey:INS_KEY_SESSION_ID];;
    
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:cityName forKey:@"cityName"];
    [bodyDict setObject:cityCode forKey:@"cityCode"];
    [bodyDict setObject:insuranceType forKey:@"insuranceType"];
    [bodyDict setObject:totalPrice forKey:@"totalPrice"];
    [bodyDict setObject:totalAmount forKey:@"totalAmount"];
    [bodyDict setObject:username forKey:@"username"];
    [bodyDict setObject:sessionid forKey:@"sessionid"];
    [bodyDict setObject:insuredInfo forKey:@"insuredInfo"];
    [bodyDict setObject:applicantInfo forKey:@"applicantInfo"];
    [bodyDict setObject:ownerInfo forKey:@"ownerInfo"];
    [bodyDict setObject:deliverInfo forKey:@"deliverInfo"];
    [bodyDict setObject:vehicle forKey:@"vehicle"];
    [bodyDict setObject:prodocts forKey:@"prodocts"];
    
    NSString *paymentMethod = @"1";
    if (_payOnline) {//0网上支付，1线下支付
        paymentMethod = @"0";
    }
    [bodyDict setObject:paymentMethod forKey:@"paymentMethod"];
    
    return bodyDict;

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
