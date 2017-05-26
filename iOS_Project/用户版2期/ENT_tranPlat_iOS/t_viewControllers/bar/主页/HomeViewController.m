//
//  HomeViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "HomeViewController.h"
#import "CarInfoScrollView.h"
#import "HomeWeatherView.h"
#import "TestNetworkViewController.h"
#import "ZhaohuiViewController.h"
#import "InformationCenterListViewController.h"

@interface HomeViewController ()<
MenuViewDelegate,
CarInfoScrollViewDelegate,
DriverViewDelegate,
AdvertisementImageViewDelegate,
UIAlertViewDelegate
>
{
    //HomeWeatherView                 *_weatherView;
    UIView                          *_advertisementView;
    NSMutableDictionary             *_carNetStatusDict;
    CarInfoScrollView                 *_carInfoScrollView;
    
    UIScrollView                    *_rootScrollView;
    
    UIView                          *_locationView;
    UIView                          *_msgView;
    UIView                          *_netUnavailibleView;
    UIView *_huodongView;
}

@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic, retain)   NSString             *appUpdateUrlString;//appStore更新地址
@property (nonatomic, retain)   NSMutableArray          *cars;//当前用户所有车
@property (nonatomic, retain)   NSMutableDictionary     *carPeccancyRecordDict;//车辆违章记录字典
@property (nonatomic, retain)   NSMutableDictionary     *carZhaohuiDict;//车辆召回信息字典


@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)addHuodongViewWithFrame:(CGRect)frame imageName:(NSString*)imgName title:(NSString*)title subTitle:(NSString*)subtitle onView:(UIView*)bgView selector:(SEL)selector{
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [bgView addSubview:v];
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:YYRectMake(30, 20, 60, 60)];
    [logoImgView setImage:[UIImage imageNamed:imgName]];
    [logoImgView setUserInteractionEnabled:YES];
    [v addSubview:logoImgView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:YYRectMake(logoImgView.r + 10, logoImgView.t + 5, v.w - logoImgView.r - 10, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [lable setText:title];
    [v addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:YYRectMake(lable.l, lable.b + 10, v.w - lable.l, 24)];
    [lable convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [lable setText:subtitle];
    [v addSubview:lable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [v addGestureRecognizer:tap];
}

-(void)loadView_
{
    //天气
//    _weatherView = [[HomeWeatherView alloc] init];
//    [_weatherView setFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, (50+50+30+30+15)*PX_Y_SCALE)];
//    [self.view addSubview:_weatherView];
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT)];
    _rootScrollView.bounces = YES;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    //其他--广告
    CGRect advertisementVFrame = YYRectMake(0, 0, APP_PX_WIDTH, (APP_WIDTH*157/457)/PX_X_SCALE);//设置的宽*210/457 改为 157/457
    _advertisementView = [[UIView alloc] initWithFrame:advertisementVFrame];
    [_rootScrollView addSubview:_advertisementView];
    [self showAdvertisementWithData:nil];
    //活动
    _huodongView = [[UIView alloc] initWithFrame:YYRectMake(_advertisementView.l, _advertisementView.b, _advertisementView.w, 120)];
    _huodongView.backgroundColor = [UIColor whiteColor];
    [_rootScrollView addSubview:_huodongView];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(_huodongView.w/2, 0)];
    [lineL setSize:CGSizeMake(1, _huodongView.height)];
    [_huodongView addSubview:lineL];
    [self addHuodongViewWithFrame:YYRectMake(0, 0, (_huodongView.w - 1)/2, _huodongView.h) imageName:@"home_zijiayou" title:@"自驾游" subTitle:@"选线路开车出发" onView:_huodongView selector:@selector(zijiayouClicked)];
    [self addHuodongViewWithFrame:YYRectMake((_huodongView.w - 1)/2 + 1, 0, (_huodongView.w - 1)/2, _huodongView.h) imageName:@"home_chefuwu" title:@"车服务" subTitle:@"养车更便捷省钱" onView:_huodongView selector:@selector(chefuwuClicked)];

    
    //netunavailible
    _netUnavailibleView = [[UIView alloc] initWithFrame:YYRectMake(0, _huodongView.b + 30, APP_PX_WIDTH, 80)];
    _netUnavailibleView.backgroundColor = [UIHelper getColor:@"#ffeda3"];
    [_rootScrollView addSubview:_netUnavailibleView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRetryNetwork)];
    [_netUnavailibleView addGestureRecognizer:tap];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:YYRectMake(20, 20, 40, 40)];
    [imgV setImage:[UIImage imageNamed:@"warn_logo.png"]];
    [_netUnavailibleView addSubview:imgV];
    UILabel *l = [[UILabel alloc] initWithFrame:YYRectMake(imgV.r + 20, 20, _netUnavailibleView.w, _netUnavailibleView.h - 40)];
    l.text = @"当前网络状态不佳，请检查您的网络";
    [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [_netUnavailibleView addSubview:l];
    [self loadNetUnavailableView:NO];
    
    //车辆信息
    CGFloat height = CAR_VIEW_HEIGHT;
    _carInfoScrollView = [[CarInfoScrollView alloc] initWithFrame:CGRectMake(APP_X, _huodongView.b + 30, APP_WIDTH, height)];
    _carInfoScrollView.scroll_delegate = self;
    [_rootScrollView addSubview:_carInfoScrollView];
    
    if (_carInfoScrollView.bottom > _rootScrollView.height) {
        [_rootScrollView setContentSize:CGSizeMake(APP_WIDTH, _carInfoScrollView.bottom)];
    }
}

- (void)loadNavComponents{
    
    _locationView = [[UIView alloc] initWithFrame:YYRectMake(30, 30, 60 + 50, 40)];
    [_navigationImgView addSubview:_locationView];
    UITapGestureRecognizer *locaitonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSetCity:)];
    [_locationView addGestureRecognizer:locaitonTap];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40*PX_X_SCALE, 40*PX_X_SCALE)];
    [imgView setImage:[UIImage imageNamed:@"location_logo_white"]];
    [imgView setUserInteractionEnabled:YES];
    [_locationView addSubview:imgView];
    UILabel *cityL = [[UILabel alloc] initWithFrame:YYRectMake(imgView.r + 10, 5, 30, 100)];
    [cityL convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    
    NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if ([cityName isEqualToString:@""]) {
        cityL.text = @"...";
        [self tapSetCity:nil];
    }else{
        cityL.text = cityName;
    }
    [cityL setSize:[cityL.text sizeWithFont:cityL.font constrainedToSize:CGSizeMake(1000, 30)]];
    [_locationView addSubview:cityL];
    
    
    _msgView = [[UIView alloc] initWithFrame:YYRectMake(APP_PX_WIDTH - _navigationImgView.h, 0, _navigationImgView.h, _navigationImgView.h)];
    _msgView.backgroundColor = [UIColor clearColor];
    [_navigationImgView addSubview:_msgView];
    
    UIImageView *msgLogoImgV = [[UIImageView alloc] initWithFrame:YYRectMake(_msgView.w - 30 - 44, 30, 33, 33)];
    [msgLogoImgV setUserInteractionEnabled:YES];
    [msgLogoImgV setImage:[UIImage imageNamed:@"msg_logo.png"]];
    [_msgView addSubview:msgLogoImgV];
    NSArray *arr = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
    if ([arr count]) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:YYRectMake(msgLogoImgV.w - 8, -4, 16, 16)];
        [imgV setImage:[UIImage imageNamed:@"msg_notice_new.png"]];
        [msgLogoImgV addSubview:imgV];
    }
    UIButton *msgB = [UIButton buttonWithType:UIButtonTypeCustom];
    [msgB setFrame:_msgView.bounds];
    [msgB addTarget:self action:@selector(msgButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [_msgView addSubview:msgB];
}

- (void)rmNavComponents{
    [_locationView removeFromSuperview];
    _locationView = nil;
    [_msgView removeFromSuperview];
    _msgView = nil;
}

- (void)reloadNavComponents{
    if (_locationView && _msgView) {
        [self rmNavComponents];
    }
    [self loadNavComponents];
}

- (void)loadNetUnavailableView:(BOOL)load{
    _netUnavailibleView.hidden = !load;
    
    if (load) {
        [_carInfoScrollView setFrame:YYRectMake(_carInfoScrollView.l, _huodongView.b + 30 + 80, _carInfoScrollView.w, _carInfoScrollView.h)];
    }else{
        [_carInfoScrollView setFrame:YYRectMake(_carInfoScrollView.l, _huodongView.b + 30, _carInfoScrollView.w, _carInfoScrollView.h)];
    }
    if (_carInfoScrollView.bottom > _rootScrollView.height) {
        [_rootScrollView setContentSize:CGSizeMake(APP_WIDTH, _carInfoScrollView.bottom)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySetChanged) name:NOTIFICATION_CITY_SET_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appUpdate:) name:NOTIFICATION_APP_UPDATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendPushIds:) name:NOTIFICATION_PUSH_REGIST_FINISHED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewMessage:) name:NOTIFICATION_FETCH_MESSAGES_FINISHED object:nil];

    //初始化界面
    _carNetStatusDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    //_driverNetStatusDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self loadView_];

    [self reloadAllFromNet];
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    [self setBackButtonHidden:YES];
    [self setCustomNavigationTitle:@"开车邦"];
    [self loadNavComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if ([cityName isEqualToString:@""]) {
        [self tapSetCity:nil];
    }
    
    if (!_netUnavailibleView.hidden) {//上次未加载成功
        [self reloadAllFromNet];
    }else{//上次加载成功
        if ([Helper netAvailible]) {//当前网络可用，可用则load相关
            [self reloadCarsView];
            [self reloadPeccancyInfoView];
        }else{//当前网络不可用，加载不可用界面
            [self loadNetUnavailableView:YES];
        }
    }
    
    
    
    
    
    //[self performSelector:@selector(reloadCarsView) withObject:nil afterDelay:12.0];
    
    //testing
    //[_weatherView setFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, (50+50+30+30+15)*PX_Y_SCALE)];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self rmNavComponents];
}

#pragma mark-   事件

- (void)zijiayouClicked{

}

- (void)chefuwuClicked{
    
}



- (void)citySetChanged{
    //获取天气情况
    //[self getWeatherCondition];
    //[self getXianxingMsg];
    
    //上传城市与车辆品牌信息-用于车友圈好友推荐
    [NETHelper chatModifyCityAndCars];
}

- (void)loadMsgsFromServer{
    [NETHelper fetchNotifycations];
}

- (void)reloadCarsView{//从DB直接load数据。（数据一定在其他位置改动了DB，故不需重新从网络请求）
    //车信息
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    self.cars = [[NSMutableArray alloc] initWithArray:array];
    
    //刷新显示车
    [_carInfoScrollView reloadCars:self.cars];
}

- (void)reloadPeccancyInfoView{//从DB直接load数据。（数据一定在其他位置改动了DB，故不需重新从网络请求）。网络请求的判断基于：超时自动加载与无数据加载
    
    //违章信息
    self.carPeccancyRecordDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (CarInfo *car in self.cars) {
        //获取车辆违章记录
        NSArray *carPeccancyRecors = [[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car.hphm];
        if ([carPeccancyRecors count]) {
            CarPeccancyRecord *record = [carPeccancyRecors lastObject];
            [self.carPeccancyRecordDict setObject:record forKey:car.hphm];
        }
    }
    
    //刷新显示违章记录
    //--刷新显示车辆违章记录
    for (CarInfo *car in self.cars) {
        CarPeccancyRecord *record = [self.carPeccancyRecordDict objectForKey:car.hphm];
        BOOL needLoad_net = NO;
        if (record) {//超时加载
            CGFloat timeinterval = [[NSDate date] timeIntervalSinceDate:[record.jdcwf_gxsj date]];
            if (timeinterval > 10*60.0f) {
                needLoad_net = YES;
            }
        }else{//无数据加载
            needLoad_net = YES;
        }
        //以上判断数据需要网络加载，以下判断是否已经加载失败
        NSString *carNetStatus = [_carNetStatusDict objectForKey:car.hphm];
        if (needLoad_net) {
            if ([carNetStatus isEqualToString:PECCANCY_NET_STATUS_FAILED]) {
                needLoad_net = NO;
            }
        }
        
        if (needLoad_net) {
            [self netGetPeccancyRecord:car];
        }else{
            [_carInfoScrollView reloadPeccancy:car.hphm];
        }
    }
}

- (void)tapRetryNetwork{
    TestNetworkViewController *tnvc = [[TestNetworkViewController alloc] init];
    [self.navigationController pushViewController:tnvc animated:YES];
}


- (void)reloadAllFromNet{
    if ([Helper netAvailible]) {
        [self loadNetUnavailableView:NO];
        //网络请求->登陆
        if (self.doLoginNetWork) {
            [self login];
        }else{
            [self loadMsgsFromServer];
        }
        //获取广告内容
        [self getAdvertisement];
        //获取天气情况
        //[self getWeatherCondition];
        //获取限行信息
        //[self getXianxingMsg];
        //获取召回信息
        NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
        for (CarInfo *car in array) {
            [self netGetZhaohuiMsgWithVin:car.clsbdh];
        }
        //检测更新
        [NETHelper checkAppUpdate];
        //发送百度推送id、channel
        [self sendPushIds:nil];
        //上传城市与车辆品牌信息-用于车友圈好友推荐
        [NETHelper chatModifyCityAndCars];
        
        
        [self reloadCarsView];
        [self reloadPeccancyInfoView];
        
    }else{
        [self loadNetUnavailableView:YES];
    }
}


#pragma mark- CarInfoScrollView Delegate
- (void)carInfoScrollViewDidTapForAdd{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    CarBindViewController *carbindVC = [[CarBindViewController alloc] init];
    [self.navigationController pushViewController:carbindVC animated:YES];
}

- (void)carInfoScrollView:(CarInfoScrollView *)scrollView car:(NSString *)hphm didRespondAction:(Action)action{

    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    if (action == actionEnterPeccancyRecord) {
        CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:hphm] lastObject];
        //绑定成功-才能查看？？？
        if (car && ([car.vehiclestatus rangeOfString:@"成功"].location != NSNotFound)) {
            
        }
        PeccancyRecordViewController *prvc = [[PeccancyRecordViewController alloc] initWithHphm:hphm];
        [self.navigationController pushViewController:prvc animated:YES];
    }else if (action == actionEnterCarInfo) {
        //查看车辆信息
        CarInfoViewController *vc = [[CarInfoViewController alloc] initWithHphm:hphm];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (action == actionLogoChange) {
        
    }else if (action == actionEnterZhaohui) {
        ZhaohuiViewController *zvc = [[ZhaohuiViewController alloc] init];
        zvc.hphm = hphm;
        [self.navigationController pushViewController:zvc animated:YES];
    }
}


#pragma mark- 广告
/***********************************广告**********************************************/
- (void)advertisementImageView:(AdvertisementImageView *)aImageView didTapedWithImgsrc:(NSString *)imgsrc andHref:(NSString *)href{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    AdvertisementViewController *advertiseVC = [[AdvertisementViewController alloc] init];
    advertiseVC.url = href;
    [self.navigationController pushViewController:advertiseVC animated:YES];
}

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
    MKNetworkOperation *op = [en operationWithPath:@"Cms/dataview/dataview_findFreeAdpostionByCityName.action" params:[NSDictionary dictionaryWithObjectsAndKeys:cityName, @"param", @"56", @"cid", nil] httpMethod:@"GET"];
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
#if use_xian_xing_tianqi
#pragma mark- 限行
/***********************************限行**********************************************/
- (void)getXianxingMsg{
    //{"StartDate":"","EndDate":"","SpecialDate":{"2015/04/16":"1,2","2015/04/23":"0,1"},"Monday":false,"Tuesday":"3,3","Wednesday":false,"Thursday":"4,5","Friday":false,"Saturday":"6,7","Sunday":false}
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if ([cityName isEqualToString:@""]) {
        [self performSelector:@selector(getXianxingMsg) withObject:nil afterDelay:1*10.0f];
        return;
    }
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cms.956122.com"];
    MKNetworkOperation *op = [engine operationWithPath:@"jgrules/j_getJgrulesByCity.action" params:[NSDictionary dictionaryWithObjectsAndKeys:cityName, @"city", nil] httpMethod:@"GET"];
    ENTLog(@"%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        ENTLog(@"%@", completedOperation.responseString);
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        Xianxing *xianxing = nil;
        if (!resDict) {//无维护数据，认为不限行
            xianxing = [[Xianxing alloc] initWithStartDate:@"2011/04/14" endDate:@"2112/04/14" specialDate:@"{}" monday:@"false" tuesday:@"false" wednesday:@"false" thursday:@"false" friday:@"false" saturday:@"false" sunday:@"false"];
        }else{
            NSString *start = [resDict analysisStrValueByKey:@"StartDate"];
            NSString *end = [resDict analysisStrValueByKey:@"EndDate"];
            NSString *special = [NSString stringWithFormat:@"%@", [resDict objectForKey:@"SpecialDate"]];
            NSString *mon = [resDict analysisStrValueByKey:@"Monday"];
            NSString *tues = [resDict analysisStrValueByKey:@"Tuesday"];
            NSString *wed = [resDict analysisStrValueByKey:@"Wednesday"];
            NSString *thur = [resDict analysisStrValueByKey:@"Thursday"];
            NSString *fri = [resDict analysisStrValueByKey:@"Friday"];
            NSString *sat = [resDict analysisStrValueByKey:@"Saturday"];
            NSString *sun = [resDict analysisStrValueByKey:@"Sunday"];
            xianxing = [[Xianxing alloc] initWithStartDate:start endDate:end specialDate:special monday:mon tuesday:tues wednesday:wed thursday:thur friday:fri saturday:sat sunday:sun];
        }
        //写数据库
        [xianxing addToDB];
        //刷新页面
        [_weatherView reloadXianxing];
        [_carInfoScrollView reloadOther:nil];//重新加载所有车辆的限行标志
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ENTLog(@"%@", @"限行信息加载失败");
        [self performSelector:@selector(getXianxingMsg) withObject:nil afterDelay:1*10.0f];
        
    }];
    [engine enqueueOperation:op];
    
}

#pragma mark- 天气
/***********************************天气**********************************************/
- (void)getWeatherCondition{
    NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if ([cityName isEqualToString:@""]) {
        [self performSelector:@selector(getWeatherCondition) withObject:nil afterDelay:1*10.0f];
        return;
    }
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cms.956122.com"];
    MKNetworkOperation *op = [engine operationWithPath:@"weather/weather.action" params:[NSDictionary dictionaryWithObjectsAndKeys:cityName, @"cityName", nil] httpMethod:@"GET"];
    ENTLog(@"%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *resDict = [parser objectWithString:completedOperation.responseString];
        if (!resDict) {
            ENTLog(@"%@", @"天气情况加载失败");
            [self performSelector:@selector(getWeatherCondition) withObject:nil afterDelay:1*10.0f];
            return ;
        }
        NSArray *results = [resDict objectForKey:@"results"];
        NSDictionary *firstDict = [results objectAtIndex:0];
        NSArray *msgarr = [firstDict objectForKey:@"index"];
        NSDictionary *xicheDict = [msgarr objectAtIndex:1];
        NSString *xiche = [xicheDict objectForKey:@"zs"];
        
        NSArray *weatherArr= [firstDict objectForKey:@"weather_data"];
        NSDictionary *weatherDict = [weatherArr objectAtIndex:0];
        NSString *weather = [weatherDict objectForKey:@"weather"];
        NSString *temp = [weatherDict objectForKey:@"temperature"];
        NSString *picUrl = [weatherDict objectForKey:@"dayPictureUrl"];
        Weather *wea = [[Weather alloc] initWithTemp:temp des:weather detail:@"" logoUrl:picUrl xiche:xiche updateTime:[[NSDate date] string] other:@""];
        //写数据库
        [wea updateToDB];
        //刷新界面
        [_weatherView reloadWeather];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ENTLog(@"%@", @"天气情况加载失败");
        [self performSelector:@selector(getWeatherCondition) withObject:nil afterDelay:1*10.0f];
    }];
    [engine enqueueOperation:op];
}
#endif

#pragma mark- 召回
/***********************************召回**********************************************/

//- (void)reloadZhaohuiView{//从DB加载，DB无数据，则走网络获取。
//    //召回信息
//    self.carZhaohuiDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    for (CarInfo *car in self.cars) {
//        //获取车辆召回信息
//        NSArray *zhaohuis = [[DataBase sharedDataBase] selectZhaohuiByClsbdh:car.clsbdh];
//        if ([zhaohuis count]) {
//            Zhaohui *zhaohui = [zhaohuis lastObject];
//            [self.carZhaohuiDict setObject:zhaohui forKey:car.clsbdh];
//        }
//    }
//    
//    //刷新显示召回信息记录
//    for (CarInfo *car in self.cars) {
//        Zhaohui *zhaohui = [self.carZhaohuiDict objectForKey:car.clsbdh];
//        if (!zhaohui) {//无数据加载
//            [self netGetZhaohuiMsgWithVin:car.clsbdh];
//        }else{
//            [_carInfoScrollView reloadOther:car.clsbdh];
//        }
//    }
//}


- (void)netGetZhaohuiMsgWithVin:(NSString*)vin{
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_CMS_956122];
    MKNetworkOperation *op = [en operationWithPath:@"recall/r_findbyvn.action" params:[NSDictionary dictionaryWithObjectsAndKeys:vin, @"vin", nil] httpMethod:@"GET"];
    ENTLog(@"%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *reqStr = completedOperation.responseString;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSArray *responseArr = [parser objectWithString:reqStr];
        if ([responseArr count]) {
            NSDictionary *dict = [responseArr lastObject];
            Zhaohui *zhaohui = nil;
            if (!dict) {
//                //返回-1，无召回信息
//                zhaohui = [[Zhaohui alloc] initWithBrand:@""cartype:@"" dealway:@"" id_fanhui:@"" method:@"" period:@"" reason:@"无召回信息" result:@"" clsbdh:vin];
            }else{
                zhaohui = [[Zhaohui alloc] initWithBrand:[dict objectForKey:@"brand"] cartype:[dict objectForKey:@"cartype"] dealway:[dict objectForKey:@"dealway"] id_fanhui:[dict objectForKey:@"id"] method:[dict objectForKey:@"method"] period:[dict objectForKey:@"period"] reason:[dict objectForKey:@"reason"] result:[dict objectForKey:@"result"] clsbdh:vin];
            }
            //写数据库
            [zhaohui updateToDB];
            //刷新界面
            [_carInfoScrollView reloadOther:nil];
            
        }else{
//           Zhaohui *zhaohui = [[Zhaohui alloc] initWithBrand:@""cartype:@"" dealway:@"" id_fanhui:@"" method:@"" period:@"" reason:@"无召回信息" result:@"" clsbdh:vin];
//            //写数据库
//            [zhaohui updateToDB];
//            //刷新界面
//            [self reloadZhaohuiView];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        Zhaohui *zhaohui = [[Zhaohui alloc] initWithBrand:@""cartype:@"" dealway:@"" id_fanhui:@"" method:@"" period:@"" reason:@"召回信息加载失败，点击重新加载" result:@"" clsbdh:vin];
//        //写数据库
//        [zhaohui updateToDB];
//        //刷新界面
//        [self reloadZhaohuiView];
        
    }];
    [en enqueueOperation:op];
    
}

#pragma mark- alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_ALERT_APP_NEW_VERSION_YES) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appUpdateUrlString]];//@"h ttps://itunes.apple.com/cn/app/wan-zhuan-quan-cheng/id692579125?mt=8"
        }
    }
}

#pragma mark- notifications!!
- (void)appUpdate:(NSNotification*)notify{
    
    if ([self.navigationController.visibleViewController isKindOfClass:[UITabBarController class]]) {
        if (notify.userInfo) {//获取版本信息-网络请求成功
            
            self.appUpdateUrlString = [notify.userInfo objectForKey:@"url"];
            NSString *version = [notify.userInfo objectForKey:@"version"];
            if (![self.appUpdateUrlString isEqualToString:@""] && ![version isEqualToString:@""]) {//需要更新
                
                if([version length] == 3 ){
                    version = [NSString stringWithFormat:@"%@.%@.%@", [version substringToIndex:1],[version substringWithRange:NSMakeRange(1, 1)],[version substringFromIndex:2]];
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"已发布新版本%@，是否更新？", version] delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                alert.tag = TAG_ALERT_APP_NEW_VERSION_YES;
                [alert show];
            }
        }
        
    }
}

- (void)didReceiveNewMessage:(NSNotification*)notify{
    NSString *resMark = [notify.userInfo objectForKey:@"responseMark"];
    if ([resMark isEqualToString:NOTIFICATION_FETCH_MESSAGES_FINISHED]) {
        [self reloadNavComponents];
    }
    
}

#pragma mark- button clicks!!!
- (void)tapSetCity:(UITapGestureRecognizer*)tap{
    SetCityViewController *setCityVC = [[SetCityViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setCityVC];
    if (iOS7) {
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, APP_WIDTH, 20)];
        statusBarView.backgroundColor = COLOR_NAV;
        [nav.navigationBar addSubview:statusBarView];
    }
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)msgButtonClicked{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    InformationCenterListViewController *infoVC = [[InformationCenterListViewController alloc] init];

    [self.navigationController pushViewController:infoVC animated:YES];
}


#pragma mark- 网络请求
- (void)login{
    
    //获取到当前活跃用户
    UserInfo *activeUser = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"alogin" forKey:@"action"];
    [dict setObject:activeUser.userName forKey:@"username"];
    [dict setObject:activeUser.password forKey:@"password"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        NSDictionary *resDict = (NSDictionary*)requestObj;
        if (result == postSucc) {
            NSString *conResult = [resDict objectForKey:@"result"];
            if ([conResult isEqualToString:@"success"]) {
                //登录成功
                APP_DELEGATE.loginSuss = YES;
                UserInfo *userFromDB = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
                APP_DELEGATE.userName =userFromDB.userName;
                APP_DELEGATE.userId = userFromDB.userId;
                
                //更新user数据库
                UserInfo *user = [Helper loginAnalysisUser:resDict withUserId:activeUser.userId userName:activeUser.userName andPassword:activeUser.password];
                [user update];
                
                //删除当前用户下所有driver,数据库添加服务器返回的driver
                NSArray *drivers = [Helper loginAnalysisDriver:resDict withUserId:activeUser.userId];
                [drivers updateDriversAfterLogin];
                
                //删除当前用户下所有car,数据库添加服务器返回的car
                NSArray *cars = [Helper loginAnalysisCarInfo:resDict withUserId:activeUser.userId];
                [cars updateCarsAfterLogin];
                
                //刷新
                [self reloadCarsView];

                [self.view showAlertText:@"网络登录成功"];
                
                [NETHelper asynchronousDownloadLanchImage];
                

                [self loadMsgsFromServer];

            }else if ([conResult isEqualToString:@"fail"]){
                
        //************        改                 ************************************/
                [self.view showAlertText:@"网络登录失败，当前为无网络登录状态"];

                    NSString *reason = [resDict objectForKey:@"reason"];
                    ENTLog(@"登录失败：%@",reason);
            }
            
        }else{
            [self.view showAlertText:@"网络登录失败，当前为无网络登录状态"];

                ENTLog(@"登录失败：%@",(NSString*)requestObj);
        }
        
    } onError:^(NSString *errorStr) {
        [self loadNetUnavailableView:YES];
        [self.view showAlertText:errorStr];
        
    }];
    
}

- (void)netGetPeccancyRecord:(CarInfo*)car{
    
    [_carNetStatusDict removeObjectForKey:car.hphm];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"list" forKey:@"action"];
    [dict setObject:car.hpzl forKey:@"hpzl"];
    [dict setObject:car.hphm forKey:@"hphm"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO  callBackWithObj:car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonStr = [writer stringWithObject:requestObj];
            CarPeccancyRecord *carpr = [[CarPeccancyRecord alloc] initWithHpzl:((CarInfo*)callBackObj).hpzl hphm:((CarInfo*)callBackObj).hphm jdcwf_detail:jsonStr jdcwf_gxsj:[[NSDate date]string] andUserId:APP_DELEGATE.userId];
            //ok写入数据库
            [carpr update];
            
            [_carNetStatusDict setObject:PECCANCY_NET_STATUS_SUCC forKey:car.hphm];
        }else{
            [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
            
            [self.view showAlertText:[NSString stringWithFormat:@"车辆违章信息查询失败,%@", requestObj]];
        }
        
        
        //更新界面显示
        [self reloadPeccancyInfoView];
        
    } onError:^(NSString *errorStr) {
        [self.view showAlertText:errorStr];
        
        //[_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
        //更新界面显示
        //[self reloadPeccancyInfoView];
        [self loadNetUnavailableView:YES];
    }];
}


- (void)sendPushIds:(NSNotification*)notify{
    if (!APP_DELEGATE.loginSuss) {
        return;
    }
    NSString *bpush_userid = nil;
    NSString *bpush_channelid = nil;
    if (notify == nil) {//主动调用
        if (!APP_DELEGATE.bpushUserId || !APP_DELEGATE.bpushChannelId) {
            return;
        }else{
            bpush_userid = APP_DELEGATE.bpushUserId;
            bpush_channelid = APP_DELEGATE.bpushChannelId;
        }
    }else{
        bpush_userid = [notify.userInfo objectForKey:KEY_BPUSH_USER_ID];
        bpush_channelid = [notify.userInfo objectForKey:KEY_BPUSH_CHANNEL_ID];
    }
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"updatebdinf" forKey:@"action"];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    [bodyDict setObject:bpush_userid forKey:@"bduserid"];
    [bodyDict setObject:bpush_channelid forKey:@"bdchannelid"];
    [[Network sharedNetwork] postBody:bodyDict isResponseJson:NO doShowIndicator:NO callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        //不处理返回结果
        
    } onError:^(NSString *errorStr) {
        [self performSelector:@selector(sendPushIds:) withObject:nil afterDelay:1*10.0f];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
