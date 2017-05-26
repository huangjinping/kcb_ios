//
//  FaxianViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//


#import "FaxianViewController.h"
#import "AdvertisementImageView.h"
#import "CheLiang_ZHViewController.h"
#import "BaiduMobAdView.h"
#import "UserCarViewController.h"

@interface FaxianViewController ()<
AdvertisementImageViewDelegate//,
//BaiduMobAdViewDelegate
>
{
    //BaiduMobAdView          *_advertisementView;
    UIView                  *_advertisementView;

    UIView                  *_mainBgView;
    
    UIScrollView            *_rootScrollView;
}
@end

@implementation FaxianViewController
#define TAG_BUTTON_XICHE                    700
#define TAG_BUTTON_CHEXIANBAOJIA            701
#define TAG_BUTTON_YUYUESHENCHE             702
#define TAG_BUTTON_ERSHOUCHE                703
#define TAG_BUTTON_HUANJIAZHAO              704
#define TAG_BUTTON_CHELIANGZHAOHUI          705
#define TAG_BUTTON_JIAOGUANJU               706
#define TAG_BUTTON_GAOSULUKUANG             707
#define TAG_BUTTON_CHEXIANJISUANQI          708
#define TAG_BUTTON_TINGCHECHANG             709
#define TAG_BUTTON_JIAYOUZHAN               710


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT)];
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];

    _advertisementView = [[UIView alloc] initWithFrame:LGRectMake(0, 0, APP_PX_WIDTH, APP_PX_WIDTH*250/640)];
    _advertisementView.backgroundColor = [UIColor whiteColor];
    [_rootScrollView addSubview:_advertisementView];
//    _advertisementView = [[BaiduMobAdView alloc] init]; //把在mssp.baidu.com上创建后获得的⼲⼴广告位id写到这⾥里
//    _advertisementView.AdUnitTag = @"2007801";
//    _advertisementView.AdType = BaiduMobAdViewTypeBanner;
//    _advertisementView.frame = BGRectMake(0, -APP_PX_WIDTH*250/640, APP_PX_WIDTH, APP_PX_WIDTH*250/640);
//    _advertisementView.delegate = self;
//    [_rootScrollView addSubview:_advertisementView];
//    [_advertisementView start];

    
#if 0
    /**************************第一部分。两行：洗车+车险报价*************************************/
    CGFloat singleLineHeight = 30*4;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:_advertisementView.b + 30 width:APP_PX_WIDTH height:singleLineHeight*2];
    [_rootScrollView addSubview:bgImgView];
    UILabel *lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeight - 1)];
    [bgImgView addSubview:lineLable];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 60, 60)];
    [img setImage:[UIImage imageNamed:@"qiche"]];
    [bgImgView addSubview:img];
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(img.r + 10, img.t, 400, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    l.text = @"洗车";
    [bgImgView addSubview:l];
    UILabel *cl = [[UILabel alloc] initWithFrame:LGRectMake(l.l, l.b + 8, l.w, l.h)];
    [cl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    cl.text = @"先预约，省时省钱，轻松把车洗";
    [bgImgView addSubview:cl];
    
    img = [[UIImageView alloc] initWithFrame:LGRectMake(30, singleLineHeight + 30, 60, 60)];
    [img setImage:[UIImage imageNamed:@"baoxian"]];
    [bgImgView addSubview:img];
    l = [[UILabel alloc] initWithFrame:LGRectMake(img.r + 10, img.t, 400, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    l.text = @"车险报价";
    [bgImgView addSubview:l];
    cl = [[UILabel alloc] initWithFrame:LGRectMake(l.l, l.b + 8, l.w, l.h)];
    [cl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    cl.text = @"精准报价，在线投保，快速理赔";
    [bgImgView addSubview:cl];
    UIImageView *jijiangkaitongImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 90, singleLineHeight, 90, 90)];
    [jijiangkaitongImgView setImage:[UIImage imageNamed:@"jijiangkaitong"]];
    [bgImgView addSubview:jijiangkaitongImgView];
    
    UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverButton setFrame:LGRectMake(0, 0, bgImgView.width, singleLineHeight)];
    [coverButton addTarget:self action:@selector(partOneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    coverButton.tag = TAG_BUTTON_XICHE;
    [bgImgView addSubview:coverButton];
    coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverButton setFrame:LGRectMake(0, singleLineHeight, bgImgView.width, singleLineHeight)];
    [coverButton addTarget:self action:@selector(partOneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    coverButton.tag = TAG_BUTTON_CHEXIANBAOJIA;
    [bgImgView addSubview:coverButton];
#endif
    /**************************第二部分。一行：预约审车+二手车*************************************/
    
    CGFloat singleLineHeight = 30*4 + 20;
    _mainBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _advertisementView.b, APP_PX_WIDTH, singleLineHeight*3 + 140)];
    [_rootScrollView addSubview:_mainBgView];
    
    UIImageView *bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:0 width:APP_PX_WIDTH height:singleLineHeight];
    [_mainBgView addSubview:bgView];
    CGFloat width = APP_PX_WIDTH/3;
    
    UILabel *lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width*2, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*PX_Y_SCALE)];
    [bgView addSubview:lineLable];

    UIImageView *img = [[UIImageView alloc] initWithFrame:LGRectMake((width - 60)/2, 30, 60, 60)];
    [img setImage:[UIImage imageNamed:@"yuyueshenche"]];
    [bgView addSubview:img];
    UILabel *cl = [[UILabel alloc] initWithFrame:LGRectMake(0, img.b + 8, width, 24)];
    [cl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    cl.text = @"预约审车";
    [bgView addSubview:cl];
    
    img = [[UIImageView alloc] initWithFrame:LGRectMake((width - 60)/2 + width, 30, 60, 60)];
    [img setImage:[UIImage imageNamed:@"ershouche"]];
    [bgView addSubview:img];
    cl = [[UILabel alloc] initWithFrame:LGRectMake(width, img.b + 8, width, 24)];
    [cl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    cl.text = @"二手车估值";
    [bgView addSubview:cl];
    
    img = [[UIImageView alloc] initWithFrame:LGRectMake((width - 60)/2 + width*2, 30, 60, 60)];
    [img setImage:[UIImage imageNamed:@"chexianjisuan"]];
    [bgView addSubview:img];
    cl = [[UILabel alloc] initWithFrame:LGRectMake(width*2, img.b + 8, width, 24)];
    [cl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    cl.text = @"车检计算器";
    [bgView addSubview:cl];
    
    UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    [coverButton setFrame:LGRectMake(0, 0, width, singleLineHeight)];
    [coverButton addTarget:self action:@selector(partTwoClicked:) forControlEvents:UIControlEventTouchUpInside];
    coverButton.tag = TAG_BUTTON_YUYUESHENCHE;
    [bgView addSubview:coverButton];
    coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    [coverButton setFrame:LGRectMake(width, 0, width, singleLineHeight)];
    [coverButton addTarget:self action:@selector(partTwoClicked:) forControlEvents:UIControlEventTouchUpInside];
    coverButton.tag = TAG_BUTTON_ERSHOUCHE;
    [bgView addSubview:coverButton];
    
//    UILabel *lastL = [[UILabel alloc] initWithFrame:LGRectMake(width*2, (singleLineHeight - 30*2 - 10)/2, width, 30)];
//    [lastL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
//    lastL.text = @"更多服务";
//    [bgImgView addSubview:lastL];
//    lastL = [[UILabel alloc] initWithFrame:LGRectMake(width*2, (singleLineHeight - 30*2)/2 + 30, width, 30)];
//    [lastL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
//    lastL.text = @"即将开放";
//    [bgImgView addSubview:lastL];

    coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverButton setBackgroundColor:[UIColor clearColor]];
    [coverButton setFrame:LGRectMake(width*2, 0, width, singleLineHeight)];
    [coverButton addTarget:self action:@selector(partTwoClicked:) forControlEvents:UIControlEventTouchUpInside];
    coverButton.tag = TAG_BUTTON_CHEXIANJISUANQI;
    [bgView addSubview:coverButton];
    /**************************第三部分。两行：周边服务*************************************/

    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, bgView.b + 20, 400, 24)];
    [label convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    label.text = @"周边服务";
    [_mainBgView addSubview:label];
    singleLineHeight = 30*4 + 40;

    bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:label.b + 20 width:APP_PX_WIDTH height:singleLineHeight*2];
    [_mainBgView addSubview:bgView];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeight - 1)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*2*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*2*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width*2, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*2*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width*3, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*2*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    lineLable = [UILabel lineLabelWithPXPoint:CGPointMake(width*4-1, 0)];
    [lineLable setSize:CGSizeMake(1*PX_X_SCALE, singleLineHeight*2*PX_Y_SCALE)];
    [bgView addSubview:lineLable];
    
    for (int i = 0; i < 5; i ++){

        UIImageView *imgV = [[UIImageView alloc] initWithFrame:LGRectMake((width - 60)/2 + (i%3)*width, 40 + (i/3)*singleLineHeight, 60, 60)];
        [bgView addSubview:imgV];
        UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake((i%3)*width, imgV.b + 8, width, 24)];
        [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
        [bgView addSubview:l];
        
        
        coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [coverButton setBackgroundColor:[UIColor clearColor]];
        [coverButton setFrame:LGRectMake((i%3)*width, (i/3)*singleLineHeight, width, singleLineHeight)];
        [coverButton addTarget:self action:@selector(partThreeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:coverButton];
        
        switch (i) {
            case 0:
                [imgV setImage:[UIImage imageNamed:@"jiaguanju"]];
                l.text = @"交管局";
                coverButton.tag = TAG_BUTTON_JIAOGUANJU;
                
                break;
            case 1:
                [imgV setImage:[UIImage imageNamed:@"gaosulukuang"]];
                l.text = @"高速路况";
                coverButton.tag = TAG_BUTTON_GAOSULUKUANG;
                break;
            case 2:
                [imgV setImage:[UIImage imageNamed:@"cheliangzhaohui"]];
                l.text = @"车辆召回";
                coverButton.tag = TAG_BUTTON_CHELIANGZHAOHUI;
                break;
            case 3:
                [imgV setImage:[UIImage imageNamed:@"tingchechang"]];
                l.text = @"停车场";
                coverButton.tag = TAG_BUTTON_TINGCHECHANG;
                
                break;
            case 4:
                [imgV setImage:[UIImage imageNamed:@"jiayouzhan"]];
                l.text = @"加油站";
                coverButton.tag = TAG_BUTTON_JIAYOUZHAN;
                break;
            default:
                break;
        }
        
        
        
    }
    
    
    UILabel *lastL = [[UILabel alloc] initWithFrame:LGRectMake(width*2, singleLineHeight + (singleLineHeight - 30*2 - 10)/2, width, 30)];
    [lastL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    lastL.text = @"更多服务";
    [bgView addSubview:lastL];
    lastL = [[UILabel alloc] initWithFrame:LGRectMake(width*2, singleLineHeight + (singleLineHeight - 30*2)/2 + 30, width, 30)];
    [lastL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
    lastL.text = @"即将开放";
    [bgView addSubview:lastL];
    
    
    
    
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _mainBgView.bottom + 10)];
    
    
    [self showAdvertisementWithData:nil];
    //获取广告内容
    [self getAdvertisement];
    
    
}

- (void)partOneClicked:(UIButton*)btn{
    if (btn.tag == TAG_BUTTON_XICHE) {
        [self.view showAlertText:@"该地区尚无商户入驻，请后续关注"];

    }else if (btn.tag == TAG_BUTTON_CHEXIANBAOJIA){
        
    }
}

- (void)partTwoClicked:(UIButton*)btn{
    if (btn.tag == TAG_BUTTON_YUYUESHENCHE) {
        [self.view showAlertText:@"该地区尚无服务商，请后续关注"];

    }else if (btn.tag == TAG_BUTTON_ERSHOUCHE){//二手车估值 http://buss.956122.com/eval/index.html
        UserCarViewController *cwVC = [[UserCarViewController alloc] init];
        
        
        //[self.navigationController pushViewController:cwVC animated:YES];
       // CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
      //  cwVC.url = [NSURL URLWithString:@"http://buss.956122.com/eval/index.html"];
      //  cwVC.web_title = @"二手车估值";
        [self.navigationController pushViewController:cwVC animated:YES];
    }else if (btn.tag == TAG_BUTTON_CHEXIANJISUANQI){//车检计算器：http://gab.122.gov.cn/views/inquiryjyqz.html
        CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
        cwVC.url = [NSURL URLWithString:@"http://gab.122.gov.cn/views/inquiryjyqz.html"];
        cwVC.web_title = @"车检计算器";
        [self.navigationController pushViewController:cwVC animated:YES];
        
    }
}

- (void)partThreeClicked:(UIButton*)btn{
    if (btn.tag == TAG_BUTTON_CHELIANGZHAOHUI) {
        //车辆召回需要车辆参数
        if (!APP_DELEGATE.loginSuss) {
            [self goToLoginPage];
            return;
        }
        CheLiang_ZHViewController *cheliangzhaohuiVC = [[CheLiang_ZHViewController alloc] init];
        [self.navigationController pushViewController:cheliangzhaohuiVC animated:YES];
    }else if (btn.tag == TAG_BUTTON_JIAOGUANJU){//交管局 ： http://cms.956122.com/m/trantel.html
        
        CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
        cwVC.url = [NSURL URLWithString:@"http://cms.956122.com/m/trantel.html"];
        cwVC.web_title = @"交管局";
        [self.navigationController pushViewController:cwVC animated:YES];
    }else if (btn.tag == TAG_BUTTON_GAOSULUKUANG){//高速路况：http://pr.956122.com/m/lk_cs.html
        [self.view showAlertText:@"该地区尚无服务商，请后续关注"];
        
//        CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
//        cwVC.url = [NSURL URLWithString:@"http://yetapi.956122.com/m/lk_cs.html"];
//        cwVC.web_title = @"高速路况";
//        [self.navigationController pushViewController:cwVC animated:YES];
    }else if (btn.tag == TAG_BUTTON_JIAYOUZHAN){//http://cms.956122.com/m/baiduApiH5.html?keyWord=加油站&cityName=昆明
        
        CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
        NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
        NSString *path = [[NSString alloc]initWithFormat:@"http://cms.956122.com/m/baiduApiH5.html?keyWord=加油站&cityName=%@", cityName];
        NSString * encodeUrlStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)path, NULL, NULL,  kCFStringEncodingUTF8));
        cwVC.url = [NSURL URLWithString:encodeUrlStr];
        cwVC.web_title = @"附近加油站";
        [self.navigationController pushViewController:cwVC animated:YES];
    }else if (btn.tag == TAG_BUTTON_TINGCHECHANG){// http://cms.956122.com/m/baiduApiH5.html?keyWord=停车场 &cityName=昆明
        CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
        NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
        NSString *path = [[NSString alloc]initWithFormat:@"http://cms.956122.com/m/baiduApiH5.html?keyWord=停车场&cityName=%@", cityName];
        NSString * encodeUrlStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)path, NULL, NULL,  kCFStringEncodingUTF8));
        cwVC.url = [NSURL URLWithString:encodeUrlStr];
        cwVC.web_title = @"附近停车场";
        [self.navigationController pushViewController:cwVC animated:YES];
    }
}

#pragma mark- Baidu iad Delegate
- (NSString*)publisherId{
    return @"dfcfc188";
}

- (void)willDisplayAd:(BaiduMobAdView *)adview{
    _advertisementView.frame = BGRectMake(0, 0, APP_PX_WIDTH, APP_PX_WIDTH*250/640);

    _mainBgView.frame = BGRectMake(0, _advertisementView.b, _mainBgView.w, _mainBgView.h);
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _mainBgView.bottom + 10)];

}

- (BOOL)enableLocation{
    return NO;
}

#pragma mark- 广告
/***********************************广告**********************************************/
- (void)advertisementImageView:(AdvertisementImageView *)aImageView didTapedWithImgsrc:(NSString *)imgsrc andHref:(NSString *)href{
//    if (!APP_DELEGATE.loginSuss) {
//        [self goToLoginPage];
//        return;
//    }
    AdvertisementViewController *advertiseVC = [[AdvertisementViewController alloc] init];
    advertiseVC.url = href;
    [self.navigationController pushViewController:advertiseVC animated:YES];
}
#pragma mark- 广告滚动
- (void)showAdvertisementWithData:(NSMutableDictionary*)dict{
    
    for (UIView *v in _advertisementView.subviews) {
        [v removeFromSuperview];
    }
    
    AdvertisementScrollView *asV = [[AdvertisementScrollView alloc] initWithFrame:_advertisementView.bounds dataDict:dict andDelegate:self];
    [_advertisementView addSubview:asV];
}

- (void)getAdvertisement{
    NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if ([cityName isEqualToString:@""]) {
        [self performSelector:@selector(getAdvertisement) withObject:nil afterDelay:1*10.0f];
        return;
    }
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_CMS_956122];
    MKNetworkOperation *op = [en operationWithPath:@"Cms/dataview/dataview_findFreeAdpostionByCityName.action" params:[NSDictionary dictionaryWithObjectsAndKeys:cityName, @"param", @"56", @"cid", nil] httpMethod:@"POST"];
    ENTLog(@"%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *reqStr = completedOperation.responseString;
        reqStr = [reqStr substringFromIndex:5];
        reqStr = [reqStr substringToIndex:reqStr.length - 1];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSArray *responseArr = [parser objectWithString:reqStr];
        NSMutableDictionary *advertiseHrefWithImgsrcDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        for (NSDictionary *dict in responseArr) {
            NSString *href = [dict analysisStrValueByKey:@"href"];
            NSString *img = [dict analysisStrValueByKey:@"img"];
            [advertiseHrefWithImgsrcDict setObject:href forKey:img];
        }
        [self showAdvertisementWithData:advertiseHrefWithImgsrcDict];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [self performSelector:@selector(getAdvertisement) withObject:nil afterDelay:1*10.0f];
        
    }];
    [en enqueueOperation:op];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackButtonHidden:YES];
    [self setCustomNavigationTitle:@"发现"];
    
    
    UIButton *statementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statementButton setTitle:@"声明" forState:UIControlStateNormal];
    [statementButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [statementButton addTarget:self action:@selector(showStatement) forControlEvents:UIControlEventTouchUpInside];
    [statementButton setFrame:CGRectMake(APP_WIDTH - 80, 2, 60, APP_NAV_HEIGHT - 2*2)];
    [_navigationImgView addSubview:statementButton];
}

- (void)showStatement{
    [UIAlertView alertTitle:@"活动声明" msg:@"本APP所涉及到的所有活动与苹果公司（Apple Inc.）无关，活动由易恩通智能科技有限公司发起，易恩通智能科技有限公司享有最终解释权。"];
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
