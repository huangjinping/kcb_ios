//
//  BXBaojiaViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXBaojiaViewController.h"
#import "BXDetailViewController.h"

@interface BXBaojiaViewController ()
{
    UIImageView     *_topBgImgView;
    UIView          *_baojiaBgView;
    
    NSInteger       _countNetResult;
}

//@property (nonatomic, retain)   NSString    *priceRenBao;
//@property (nonatomic, retain)   NSString    *priceYangGuang;
//@property (nonatomic, retain)   NSString    *pricePingAn;
//@property (nonatomic, retain)   NSString    *priceTaiPingYang;
@property (nonatomic ,retain ) NSString * priceTaiPingYang;
@property (nonatomic ,retain )NSString * priceTaiPIngYang;


@property (nonatomic, retain)   NSMutableDictionary    *priceDictRenBao;
@property (nonatomic, retain)   NSMutableDictionary    *priceDictYangGuang;
@property (nonatomic, retain)   NSMutableDictionary    *priceDictPingAn;
@property (nonatomic, retain)   NSMutableDictionary    *priceDictTaiPingYang;

@property (nonatomic, retain)   NSString    *ygSpecialMsg;

@end

@implementation BXBaojiaViewController

- (void)addInsWithTag:(NSInteger)tag i:(int)i andPrice:(NSString*)price onView:(UIView*)bgview{
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:i*(30*3 + 20) width:APP_PX_WIDTH height:30*3];
    [bgview addSubview:bgImgView];
    
    UIImageView *logoImgV = [[UIImageView alloc] initWithFrame:LGRectMake(30, (bgImgView.h - 70)/2, 199*70/93, 70)];//199 × 93
    [bgImgView addSubview:logoImgV];
    UILabel *nameL = [[UILabel alloc] initWithFrame:LGRectMake(logoImgV.r + 30, 30, 150, 30)];
    [nameL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    if (tag == TAG_REN_BAO) {
        [nameL setText:@"人保财险"];
        [logoImgV setImage:[UIImage imageNamed:@"ins_renbao"]];
    }else if (tag == TAG_YANG_GUANG){
        [nameL setText:@"阳光保险"];
        [logoImgV setImage:[UIImage imageNamed:@"ins_yangguang"]];

    }else if (tag == TAG_PING_AN){
        [nameL setText:@"平安保险"];
        [logoImgV setImage:[UIImage imageNamed:@"ins_pingan"]];

    }else if (tag == TAG_TAI_PING_YANG){
        [nameL setText:@"太平洋保险"];
        [logoImgV setImage:[UIImage imageNamed:@"ins_taipingyang"]];

    }
    [bgImgView addSubview:nameL];
    
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (bgImgView.h - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    
    if (!price || [price isEqualToString:@""]) {
        UIActivityIndicatorView *indicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorV setFrame:LGRectMake(arrowImgV.l - 100, 30, 30, 30)];
        [bgImgView addSubview:indicatorV];
        [indicatorV startAnimating];
    }else{
        UILabel *priceL = [[UILabel alloc] initWithFrame:LGRectMake(arrowImgV.l - 200, 30, 180, 30)];
        [priceL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentRight];
        [priceL setText:price];
        [bgImgView addSubview:priceL];

    }
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [button setFrame:bgImgView.bounds];
    [bgImgView addSubview:button];
}

- (void)reloadBaojiaView{
    
    for (UIView *v in _baojiaBgView.subviews) {
        [v removeFromSuperview];
    }
    
    [self addInsWithTag:TAG_REN_BAO i:0 andPrice:[self.priceDictRenBao objectForKey:INS_KEY_SUM_PRICE] onView:_baojiaBgView];
    [self addInsWithTag:TAG_YANG_GUANG i:1 andPrice:[self.priceDictYangGuang objectForKey:INS_KEY_SUM_PRICE] onView:_baojiaBgView];
    [self addInsWithTag:TAG_PING_AN i:2 andPrice:[self.priceDictPingAn objectForKey:INS_KEY_SUM_PRICE] onView:_baojiaBgView];
    [self addInsWithTag:TAG_TAI_PING_YANG i:3 andPrice:[self.priceDictTaiPingYang objectForKey:INS_KEY_SUM_PRICE] onView:_baojiaBgView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.pricePingAn = @"";
//    self.priceRenBao = @"";
//    self.priceTaiPingYang = @"";
//    self.priceYangGuang = @"";
    
    self.priceDictRenBao = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.priceDictYangGuang = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.priceDictPingAn = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.priceDictTaiPingYang = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.ygSpecialMsg = @"";
    
    UILabel *insCountL = [[UILabel alloc] initWithFrame:LGRectMake(20, 30, APP_PX_WIDTH - 20*2, 30)];
    [insCountL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [insCountL setText:[NSString stringWithFormat:@"已选 %d 险种", (int)[self.baoxian.insSelectedArr count]]];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(0, insCountL.b + 30)];
    
    UILabel *insContentL = [[UILabel alloc] initWithFrame:LGRectMake(insCountL.l, insCountL.b + 30*2, insCountL.w, 100)];
    [insContentL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *insStr = @"";
    for (NSString *str in self.baoxian.insSelectedArr) {
        if (![insStr isEqualToString:@""]) {
            insStr = [insStr stringByAppendingString:@", "];
        }
        insStr = [insStr stringByAppendingString:str];
        
    }
    [insContentL setText:insStr];
    insContentL.numberOfLines = 0;
    [insContentL setSize:[insContentL.text sizeWithFont:insContentL.font constrainedToSize:CGSizeMake(insContentL.width, 100000)]];

    _topBgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y + 30 width:APP_PX_WIDTH height:insContentL.b + 30];
    [self.view addSubview:_topBgImgView];
    [_topBgImgView addSubview:insCountL];
    [_topBgImgView addSubview:lineL];
    [_topBgImgView addSubview:insContentL];
    
    
    _baojiaBgView = [[UIView alloc] initWithFrame:LGRectMake(0, (_topBgImgView.b + 30), APP_PX_WIDTH, self.view.h - _topBgImgView.b)];
    _baojiaBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_baojiaBgView];
    
    [self reloadBaojiaView];

    _countNetResult = 4;
    [self netSubmitToYangGuang];
    [self netSubmitToPingAn];
    [self netSubmitToTaiPingYang];
    [self netSubmitToRenBao];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"精准报价"];

}



- (void)buttonClicked:(UIButton*)button{

    NSMutableDictionary *dict = nil;
    if (button.tag == TAG_TAI_PING_YANG) {
        dict = self.priceDictTaiPingYang;
        
    }else if (button.tag == TAG_YANG_GUANG){
        dict = self.priceDictYangGuang;
        
    }else if (button.tag == TAG_PING_AN){
        dict = self.priceDictPingAn;
        
    }else if (button.tag == TAG_REN_BAO){
        dict = self.priceDictRenBao;
        
    }
    NSRange range = [[dict objectForKey:INS_KEY_SUM_PRICE] rangeOfString:@"失败"];
    if (range.location != NSNotFound) {
        if (button.tag == TAG_TAI_PING_YANG) {
            [self.priceDictTaiPingYang setObject:@"" forKey:INS_KEY_SUM_PRICE];
            [self netSubmitToTaiPingYang];
        }else if (button.tag == TAG_YANG_GUANG){
            [self.priceDictYangGuang setObject:@"" forKey:INS_KEY_SUM_PRICE];
            [self netSubmitToYangGuang];
        }else if (button.tag == TAG_PING_AN){
            [self.priceDictPingAn setObject:@"" forKey:INS_KEY_SUM_PRICE];
            [self netSubmitToPingAn];
        }else if (button.tag == TAG_REN_BAO){
            [self.priceDictRenBao setObject:@"" forKey:INS_KEY_SUM_PRICE];
            [self netSubmitToRenBao];
        }
        [self reloadBaojiaView];
    }else{
//        NSString *p1 = [self.priceDictTaiPingYang objectForKey:INS_KEY_SUM_PRICE];
//        NSString *p2 = [self.priceDictYangGuang objectForKey:INS_KEY_SUM_PRICE];
//        NSString *p3 = [self.priceDictPingAn objectForKey:INS_KEY_SUM_PRICE];
//        NSString *p4 = [self.priceDictRenBao objectForKey:INS_KEY_SUM_PRICE];
//
//        if (p1 && ![p1 isEqualToString:@""] && p2 && ![p2 isEqualToString:@""] && p3 && ![p3 isEqualToString:@""] && p4 && ![p4 isEqualToString:@""]) {
            BXDetailViewController *vc = [[BXDetailViewController alloc] init];
            vc.baoxian = self.baoxian;
            vc.insDetailPriceDict = dict;
            vc.ins_name_code = button.tag;
            vc.ygSpecialMsg = self.ygSpecialMsg;
            if (button.tag == TAG_YANG_GUANG) {
                vc.showNextButton = YES;
            }else{
                vc.showNextButton = NO;
            }
            [self.navigationController pushViewController:vc animated:YES];
        //}
        
    }
    
}


#pragma mark- NET
- (void)netSubmitToYangGuang{
    //qiye.956122.com/Insurance/cx_getYgprice.action?jsondata= 参数
    //132.96.77.116:8080/Insurance/cx_getYgprice.action?jsondata={"sfzh":"532322197010020913","hphm":"云AM8374","boli":"0","fdjh":"q","vid":"JBBAYD0009","s_zuo":"0","chesun":"1","firstDate":"2002-11-29","clsbdh":"lsyhr4af02k067014","sanze":"100000","huahen":"0","cname":"张存才","c_zuo":"0","citycode":"01682900","seats":"7","ziran":"0","daoqiang":"0","clxh":"金杯 2.2L 海狮 手动档 实用II型 参考价：69800","fdjx":"0","forceFlag":"1","buji":"1"}
    _countNetResult --;
    NSString *bodyStr = [self getBodyStr];
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];//@"132.96.77.148:8080"
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_getYgprice.action" params:[NSDictionary dictionaryWithObjectsAndKeys:bodyStr, @"jsondata", nil] httpMethod:@"POST"];//cx_test.action
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"cx_getYgprice.action==>%@", completedOperation.responseString);
        _countNetResult ++;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        NSString *status = [resDict analysisStrValueByKey:@"status"];
        if ([status isEqualToString:@"100"]) {
            [self fillDict:TAG_YANG_GUANG withData:resDict];

            NSString *errMsg = [resDict analysisStrValueByKey:@"ErrorMessage"];//{"status":100,"ErrorMessage":"您上年的商业险保单终保日期为：2015-08-06。您选择的2015-07-30日期将会重复投保。您上年的交强险保单终保日期为：2015-08-06。请您选择2015-08-06以后的日期进行承保。","sessionId":"201507291510356614","datas":
            if (![errMsg isEqualToString:@""]) {
                //[UIAlertView alertTitle:nil msg:errMsg];
                self.ygSpecialMsg = [[NSString alloc] initWithString:errMsg];
            }
            
        }else if ([status isEqualToString:@"400"]){
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"阳光保险报价" msg:errorMessage];
            [self fillDict:TAG_YANG_GUANG withData:nil];
        }else{
//            [UIAlertView alertTitle:@"阳光保险报价" msg:@"服务器返回数据格式错误，无法解析"];
//            [self fillDict:TAG_YANG_GUANG withData:nil];
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"阳光保险报价" msg:errorMessage];
            [self fillDict:TAG_YANG_GUANG withData:nil];
        }
        [self netReloadBaojiaView];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _countNetResult ++;
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:@"阳光保险报价" msg:errStr];
        //报价失败
        [self fillDict:TAG_YANG_GUANG withData:nil];
        [self netReloadBaojiaView];
    }];
    
    [en enqueueOperation:op];
}

- (void)netSubmitToPingAn{
    //qiye.956122.com/Insurance/cx_getAboutpricePingan.action?jsondata= 参数
    _countNetResult --;
    NSString *bodyStr = [self getBodyStr];

    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_getAboutpricePingan.action" params:[NSDictionary dictionaryWithObjectsAndKeys:bodyStr, @"jsondata", nil] httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"cx_getAboutpricePingan.action==>%@", completedOperation.responseString);
        _countNetResult ++;

        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        NSString *status = [resDict analysisStrValueByKey:@"status"];
        if ([status isEqualToString:@"100"]) {
            [self fillDict:TAG_PING_AN withData:resDict];
            
        }else if ([status isEqualToString:@"400"]){
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"平安保险报价" msg:errorMessage];
            [self fillDict:TAG_PING_AN withData:nil];
        }else{
            [UIAlertView alertTitle:@"平安保险报价" msg:@"服务器返回数据格式错误，无法解析"];
            [self fillDict:TAG_PING_AN withData:nil];
        }
        [self netReloadBaojiaView];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _countNetResult ++;

        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:@"平安保险报价" msg:errStr];

        //报价失败
        [self fillDict:TAG_PING_AN withData:nil];
        [self netReloadBaojiaView];
    }];
    
    [en enqueueOperation:op];
}

- (void)netSubmitToTaiPingYang{
    //qiye.956122.com/Insurance/cx_getAboutpriceTaipingyang.action?jsondata= 参数
    _countNetResult --;

    NSString *bodyStr = [self getBodyStr];

    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_getAboutpriceTaipingyang.action" params:[NSDictionary dictionaryWithObjectsAndKeys:bodyStr, @"jsondata", nil] httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"cx_getAboutpriceTaipingyang.action==>%@", completedOperation.responseString);
        _countNetResult ++;

        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        NSString *status = [resDict analysisStrValueByKey:@"status"];
        if ([status isEqualToString:@"100"]) {
            [self fillDict:TAG_TAI_PING_YANG withData:resDict];
            
        }else if ([status isEqualToString:@"400"]){
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"太平洋保险报价" msg:errorMessage];
            [self fillDict:TAG_TAI_PING_YANG withData:nil];
        }else{
            [UIAlertView alertTitle:@"太平洋保险报价" msg:@"服务器返回数据格式错误，无法解析"];
            [self fillDict:TAG_TAI_PING_YANG withData:nil];
        }
        [self netReloadBaojiaView];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _countNetResult ++;

        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:@"太平洋保险报价" msg:errStr];
        //报价失败
        [self fillDict:TAG_TAI_PING_YANG withData:nil];
        [self netReloadBaojiaView];
    }];

    
    [en enqueueOperation:op];

}

- (void)netSubmitToRenBao{
    //qiye.956122.com/Insurance/cx_getAboutpriceRenbao.action?jsondata= 参数
    _countNetResult --;

    NSString *bodyStr = [self getBodyStr];
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_getAboutpriceRenbao.action" params:[NSDictionary dictionaryWithObjectsAndKeys:bodyStr, @"jsondata", nil] httpMethod:@"POST"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"cx_getAboutpriceRenbao.action==>%@", completedOperation.responseString);
        _countNetResult ++;

        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        NSString *status = [resDict analysisStrValueByKey:@"status"];
        if ([status isEqualToString:@"100"]) {
            [self fillDict:TAG_REN_BAO withData:resDict];
            
        }else if ([status isEqualToString:@"400"]){
            NSString *errorMessage = [resDict analysisStrValueByKey:@"ErrorMessage"];
            [UIAlertView alertTitle:@"人保财险报价" msg:errorMessage];
            [self fillDict:TAG_REN_BAO withData:nil];
        }else{
            [UIAlertView alertTitle:@"人保财险报价" msg:@"服务器返回数据格式错误，无法解析"];
            [self fillDict:TAG_REN_BAO withData:nil];
        }
        [self netReloadBaojiaView];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        _countNetResult ++;

        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:@"人保财险报价" msg:errStr];
        //报价失败
        [self fillDict:TAG_REN_BAO withData:nil];
        [self netReloadBaojiaView];
    }];
    
    [en enqueueOperation:op];
    

}

- (void)netReloadBaojiaView{
    if (_countNetResult == 4) {
        [self reloadBaojiaView];
    }
}

- (NSString*)getBodyStr{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    UserInfo *actUser = [[[DataBase sharedDataBase] selectActiveUser]lastObject];
    [bodyDict setObject:actUser.contactNum forKey:@"mobile"];
    [bodyDict setObject:[self.baoxian.syr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"cname"];
    [bodyDict setObject:[self.baoxian.hphm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"hphm"];
    [bodyDict setObject:self.baoxian.sfzhm forKey:@"sfzh"];
    [bodyDict setObject:self.baoxian.fdjh forKey:@"fdjh"];
    [bodyDict setObject:self.baoxian.vin forKey:@"clsbdh"];
    [bodyDict setObject:self.baoxian.zcrq forKey:@"firstDate"];
    NSDictionary *dict = [self.baoxian.pCartypeArr lastObject];
    [bodyDict setObject:[dict analysisStrValueByKey:@"key"] forKey:@"vid"];
    
    NSString *clxh = [dict analysisStrValueByKey:@"value"];
    NSString *clxhStr = [clxh stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [bodyDict setObject:clxhStr forKey:@"clxh"];
    [bodyDict setObject:[dict analysisStrValueByKey:@"seats"] forKey:@"seats"];
    [bodyDict setObject:self.baoxian.citycode forKey:@"citycode"];
    [bodyDict setObject:self.baoxian.ins_chesun forKey:@"chesun"];
    [bodyDict setObject:self.baoxian.ins_sanze_code forKey:@"sanze"];
    [bodyDict setObject:self.baoxian.ins_s_zuo_code forKey:@"s_zuo"];
    [bodyDict setObject:self.baoxian.ins_c_zuo_code forKey:@"c_zuo"];
    [bodyDict setObject:self.baoxian.ins_daoqiang forKey:@"daoqiang"];
    [bodyDict setObject:self.baoxian.ins_boli_code forKey:@"boli"];
    [bodyDict setObject:self.baoxian.ins_ziran forKey:@"ziran"];
    [bodyDict setObject:self.baoxian.ins_huahen_code forKey:@"huahen"];
    [bodyDict setObject:self.baoxian.ins_buji forKey:@"buji"];
    [bodyDict setObject:self.baoxian.ins_forceFlag forKey:@"forceFlag"];
    [bodyDict setObject:self.baoxian.ins_fdjx forKey:@"fdjx"];
//    [bodyDict setObject:self.baoxian.jqxToubaoDate forKey:@"forceBeginDate"];
//    [bodyDict setObject:self.baoxian.syxToubaoDate forKey:@"bizBeginDate"];
    [bodyDict setObject:@"" forKey:@"forceBeginDate"];
    [bodyDict setObject:@"" forKey:@"bizBeginDate"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *bodyStr = [writer stringWithObject:bodyDict];
    return bodyStr;
}


- (void)fillDict:(NSInteger)instag withData:(NSDictionary*)dict{
    
    NSMutableDictionary *priceDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (!dict) {
        [priceDict setObject:@"报价失败" forKey:INS_KEY_SUM_PRICE];
    }else{
        //解析
        NSString *sessionid = [dict analysisStrValueByKey:@"sessionId"];
        NSArray *datasArr = [dict analysisArrValueByKey:@"datas"];
        NSDictionary *resDict = [datasArr lastObject];
        NSString *bj_c_zuo = [resDict analysisStrValueByKey:@"bj_c_zuo"];
        NSString *bj_chesun = [resDict analysisStrValueByKey:@"bj_chesun"];
        NSString *bj_daoqiang = [resDict analysisStrValueByKey:@"bj_daoqiang"];
        NSString *bj_fdjx = [resDict analysisStrValueByKey:@"bj_fdjx"];
        NSString *bj_s_zuo = [resDict analysisStrValueByKey:@"bj_s_zuo"];
        NSString *bj_sanze = [resDict analysisStrValueByKey:@"bj_sanze"];
        CGFloat bj = [bj_c_zuo floatValue] + [bj_chesun floatValue] + [bj_daoqiang floatValue] + [bj_fdjx floatValue] + [bj_s_zuo floatValue] + [bj_sanze floatValue];
        NSString *bjmp = [NSString stringWithFormat:@"%f", bj];
        NSString *boli = [resDict analysisStrValueByKey:@"boli"];
        NSString *c_zuo = [resDict analysisStrValueByKey:@"c_zuo"];
        NSString *chesun = [resDict analysisStrValueByKey:@"chesun"];
        NSString *daoqiang = [resDict analysisStrValueByKey:@"daoqiang"];
        NSString *fdjx = [resDict analysisStrValueByKey:@"fdjx"];
        NSString *forcePremium = [resDict analysisStrValueByKey:@"forcePremium"];
        //NSString *forceTotalPremium = [resDict analysisStrValueByKey:@"forceTotalPremium"];
        NSString *huahen = [resDict analysisStrValueByKey:@"huahen"];
        NSString *s_zuo = [resDict analysisStrValueByKey:@"s_zuo"];
        NSString *sanze = [resDict analysisStrValueByKey:@"sanze"];
        NSString *vehicleTaxPremium = [resDict analysisStrValueByKey:@"vehicleTaxPremium"];
        NSString *ziran = [resDict analysisStrValueByKey:@"ziran"];
        NSString *wanggoujia = [resDict analysisStrValueByKey:@"wanggoujia"];
        //NSString *shichangjia = [resDict analysisStrValueByKey:@"shichangjia"];
        
        //填充新数据
        for (NSString *str in self.baoxian.insSelectedArr) {
            if ([str hasPrefix:INS_BO_LI_CHINESE]) {
                [priceDict setObject:boli forKey:INS_BO_LI_CHINESE];
                
            }else if ([str hasPrefix:INS_BU_JI_CHINESE]){
                [priceDict setObject:bjmp forKey:INS_BU_JI_CHINESE];
                [priceDict setObject:bj_c_zuo forKey:INS_BU_JI_CHENGKE_CHINESE];
                [priceDict setObject:bj_chesun forKey:INS_BU_JI_CHESUN_CHINESE];
                [priceDict setObject:bj_daoqiang forKey:INS_BU_JI_DAOQIANG_CHINESE];
                [priceDict setObject:bj_fdjx forKey:INS_BU_JI_FDJ_CHINESE];
                [priceDict setObject:bj_s_zuo forKey:INS_BU_JI_SIJI_CHINESE];
                [priceDict setObject:bj_sanze forKey:INS_BU_JI_SANZHE_CHINESE];
                
            }else if ([str hasPrefix:INS_CHE_SUN_CHINESE]){
                [priceDict setObject:chesun forKey:INS_CHE_SUN_CHINESE];
                
            }else if ([str hasPrefix:INS_CHENG_KE_CHINESE]){
                [priceDict setObject:c_zuo forKey:INS_CHENG_KE_CHINESE];
                
            }else if ([str hasPrefix:INS_DAO_QIANG_CHINESE]){
                [priceDict setObject:daoqiang forKey:INS_DAO_QIANG_CHINESE];
                
            }else if ([str hasPrefix:INS_FDJX_CHINESE]){
                [priceDict setObject:fdjx forKey:INS_FDJX_CHINESE];
                
            }else if ([str hasPrefix:INS_FORCE_CHINESE]){
                [priceDict setObject:forcePremium forKey:INS_FORCE_CHINESE];
                
            }else if ([str hasPrefix:INS_HUA_HEN_CHINESE]){
                [priceDict setObject:huahen forKey:INS_HUA_HEN_CHINESE];
                
            }else if ([str hasPrefix:INS_SAN_ZHE_CHINESE]){
                [priceDict setObject:sanze forKey:INS_SAN_ZHE_CHINESE];
                
            }else if ([str hasPrefix:INS_SI_JI_CHINESE]){
                [priceDict setObject:s_zuo forKey:INS_SI_JI_CHINESE];
                
            }else if ([str hasPrefix:INS_TAX_CHINESE]){
                [priceDict setObject:vehicleTaxPremium forKey:INS_TAX_CHINESE];
                
            }else if ([str hasPrefix:INS_ZI_RAN_CHINESE]){
                [priceDict setObject:ziran forKey:INS_ZI_RAN_CHINESE];
                
            }
        }
        
        [priceDict setObject:wanggoujia forKey:INS_KEY_SUM_PRICE];
        [priceDict setObject:sessionid forKey:INS_KEY_SESSION_ID];
    }
    
    

    
    if (instag == TAG_REN_BAO) {
        self.priceDictRenBao = priceDict;
    }else if (instag == TAG_TAI_PING_YANG){
        self.priceDictTaiPingYang = priceDict;
    }else if (instag == TAG_PING_AN){
        self.priceDictPingAn = priceDict;
    }else if (instag == TAG_YANG_GUANG){
        self.priceDictYangGuang = priceDict;
    }
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
