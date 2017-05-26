//
//  DriveLicenseManageViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriveLicenseManageViewController.h"

@interface DriveLicenseManageViewController ()
{
    LoadingPeccancyRecordStatus       _netStatus;
    
    
    //new
    UIScrollView            *_rootScrollView;
    UIButton                *_rightTopButton;
    UIButton                *_enterWeifaButton;
    UILabel                 *_weifaCountL;
}

//old
@property(nonatomic,strong)             DriverInfo      *driver;
//@property (nonatomic, retain)   NSMutableArray          *driveLicenses;//当前用户驾驶证--只有一条数据
//@property (nonatomic, retain)   NSMutableDictionary     *driveLicensePeccancyRecordDict;//驾驶证违章记录字典
@end

@implementation DriveLicenseManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

#define BUTTON_TAG_ENTER_LIST           101
#define BUTTON_TAG_ENTER_RELOAD         102

#define BUTTON_TAG_REFRESH_VIEW         110
#define BUTTON_TAG_EDIT_INFO            111
- (void)reloadViews
{
    NSArray *array1 = [[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId];
    self.driver = [array1 lastObject];
    DriverInfo *driverInfo = self.driver;
    for (UIView *v in _rootScrollView.subviews) {
        [v removeFromSuperview];
    }

    CGFloat lineHeightPX = 30*3;
    //*********************************扣分*********************************
    UIImageView *bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:0 width:APP_PX_WIDTH height:lineHeightPX];
    [_rootScrollView addSubview:bgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = [NSString stringWithFormat:@"违法记录        条"];
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    _weifaCountL = [[UILabel alloc] initWithFrame:LGRectMake(label.r - 100, 24, 70, 50)];
    [_weifaCountL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    _weifaCountL.textColor = COLOR_BUTTON_YELLOW;
    [bgView addSubview:_weifaCountL];
    _enterWeifaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_enterWeifaButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [_enterWeifaButton setTitle:@"缴  款" forState:UIControlStateNormal];
    [_enterWeifaButton addTarget:self action:@selector(enterWeifaClicked:) forControlEvents:UIControlEventTouchUpInside];
    _enterWeifaButton.titleLabel.font = FONT_NOMAL;
    [_enterWeifaButton setFrame:LGRectMake(label.r + 50, label.t + 3, 30*4, 30)];
    _enterWeifaButton.tag = BUTTON_TAG_ENTER_LIST;
    [bgView addSubview:_enterWeifaButton];

    
    UIImageView *yanzhengImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgView.w - 35 - 30, 30, 35, 35)];
    if ([driverInfo.driverstatus rangeOfString:@"成功"].location == NSNotFound) {
        [yanzhengImgView setImage:[UIImage imageNamed:@"yanzheng_failed"]];
        [_rightTopButton setTitle:@"编辑" forState:UIControlStateNormal];
        _rightTopButton.tag = BUTTON_TAG_EDIT_INFO;
        _enterWeifaButton.hidden = YES;
    }else{
        [yanzhengImgView setImage:[UIImage imageNamed:@"yanzheng_succ"]];
        [_rightTopButton setTitle:@"刷新" forState:UIControlStateNormal];
        _rightTopButton.tag = BUTTON_TAG_REFRESH_VIEW;
        _enterWeifaButton.hidden = NO;

    }
    [bgView addSubview:yanzhengImgView];
    
    //*********************************姓名、证件*********************************

    bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgView.b + 30 width:APP_PX_WIDTH height:lineHeightPX*2];
    [_rootScrollView addSubview:bgView];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"真实姓名";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    UILabel *contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    contentL.text = driverInfo.xm;//姓名
    [bgView addSubview:contentL];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, lineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"证件号码";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *str1 = [driverInfo.driversfzmhm substringToIndex:6];
    NSString *str2 = @"";
    if (driverInfo.driversfzmhm.length == 15) {
        str2 = [driverInfo.driversfzmhm substringFromIndex:11];
    } else {
        str2 = [driverInfo.driversfzmhm substringFromIndex:14];
    }
    contentL.text = [NSString stringWithFormat:@"%@********%@",str1,str2];
    [bgView addSubview:contentL];

    //横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, lineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgView addSubview:lineLabel];
    
    //*********************************驾驶证号、档案编号、准驾车型、证芯编号*********************************
    bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgView.b + 30 width:APP_PX_WIDTH height:lineHeightPX*4];
    [_rootScrollView addSubview:bgView];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"驾驶证号";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    contentL.text = [NSString stringWithFormat:@"%@********%@",str1,str2];
    [bgView addSubview:contentL];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, lineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"档案编号";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    str1 = driverInfo.dabh.length > 3? [driverInfo.dabh substringToIndex:3] : driverInfo.dabh;
    str2 = driverInfo.dabh.length > 5? [driverInfo.dabh substringFromIndex:driverInfo.dabh.length-2] : @"";
    contentL.text = [NSString stringWithFormat:@"%@*******%@",str1,str2];
    [bgView addSubview:contentL];

    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, lineHeightPX*2 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"准驾车型";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    contentL.text = driverInfo.zjcx;
    [bgView addSubview:contentL];

    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, lineHeightPX*3 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"证芯编号";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    str1 = driverInfo.zxbh.length > 3? [driverInfo.zxbh substringToIndex:3] : driverInfo.zxbh;
    str2 = driverInfo.zxbh.length > 5? [driverInfo.zxbh substringFromIndex:driverInfo.zxbh.length-2] : @"";
    contentL.text = [NSString stringWithFormat:@"%@*************%@",str1,str2];
    [bgView addSubview:contentL];

    //横线*********************************
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, lineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, lineHeightPX*2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, lineHeightPX*3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgView addSubview:lineLabel];
    //*********************************有效期至、驾照状态*********************************
    bgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgView.b + 30 width:APP_PX_WIDTH height:lineHeightPX*2];
    [_rootScrollView addSubview:bgView];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"有效期至";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSDate *d = [driverInfo.yxqz convertToDateWithFormat:@"yyyy-MM-dd"];
    NSString *yxqzStr = [d stringWithFormat:@"yyyy年MM月dd日"];
    contentL.text = yxqzStr;
    [bgView addSubview:contentL];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, lineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"驾照状态";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgView addSubview:label];
    
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, bgView.w - 30 - label.r - 30, label.h)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    contentL.text = driverInfo.driverzt;
    if ([contentL.text isEqualToString:@""]) {
        contentL.text = @"--";
    }
    
    [bgView addSubview:contentL];
    //横线*********************************
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, lineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgView addSubview:lineLabel];
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, bgView.bottom + APP_VIEW_Y)];
}

- (void)reloadWeifaCount{
    //违法记录数显示
    NSRange range = [self.driver.driverstatus rangeOfString:@"成功"];
    DriveLicensePeccancyRecord *record = [[[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId] lastObject];
    if (range.location != NSNotFound) {
        //网络是否加载
        if(_netStatus == loadingPeccancyRecordSucc){
            BOOL needLoad_net = NO;
            if (record) {//有记录判断是否超时
                CGFloat timeinterval = [[NSDate date] timeIntervalSinceDate:[record.jszwf_gxsj date]];
                if (timeinterval > 10*60.0f) {
                    needLoad_net = YES;
                }
            }else{//无记录
                needLoad_net = YES;
            }
            //以上判断数据需要网络加载，以下判断是否已经加载失败
            if (_netStatus == loadingPeccancyRecordFailed) {
                needLoad_net = NO;
            }
            if (needLoad_net) {
                [self getDriveLicensePeccancyRecordWithDriver:self.driver];
            }
        }
        
        
        //界面如何显示
        for (UIView *v in _weifaCountL.subviews) {
            [v removeFromSuperview];
        }
        _enterWeifaButton.hidden = NO;
        _enterWeifaButton.tag = BUTTON_TAG_ENTER_LIST;
        [_enterWeifaButton setTitle:@"缴  款" forState:UIControlStateNormal];
        if (_netStatus == loadingPeccancyRecordFailed) {
            _weifaCountL.text = @"--";//显示--
            [_enterWeifaButton setTitle:@"重新加载" forState:UIControlStateNormal];
            _enterWeifaButton.tag = BUTTON_TAG_ENTER_RELOAD;
        }else if (_netStatus == loadingPeccancyRecordSucc){
            if (record) {//显示记录数
                NSInteger count = [[Helper drivePeccancyMsgAnalysis:record.jszwf_detail] count];
                _weifaCountL.text = [NSString stringWithFormat:@"%d", (int)count];
                if (count == 0){
                    _enterWeifaButton.hidden = YES;
                }
            }
        }else if (_netStatus == isloadingPeccancyRecord){
            
            _weifaCountL.text = @"    ";//显示loading中
            _enterWeifaButton.hidden = YES;
            UIActivityIndicatorView *indicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [indicatorV setFrame:_weifaCountL.bounds];
            [indicatorV startAnimating];
            [_weifaCountL addSubview:indicatorV];
        }

    }else{
        _weifaCountL.text = @"--";
    }
    
}


- (void)gobackPage{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CarBindViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        
    }
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TabBarViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    _netStatus = loadingPeccancyRecordSucc;
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"驾照信息"];
    
    _rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightTopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightTopButton setBackgroundColor:[UIColor clearColor]];
    [_rightTopButton.titleLabel setFont:FONT_NOMAL];
    [_rightTopButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 60, 30)];
    [_rightTopButton addTarget:self action:@selector(rightTopButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_rightTopButton];
    
    [self reloadViews];
    [self reloadWeifaCount];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)rightTopButtonClicked:(UIButton*)b{
    
    if (b.tag == BUTTON_TAG_EDIT_INFO) {
        BOOL pushSelfFromBind = NO;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[DriverBindViewController class]]) {
                ((DriverBindViewController*)vc).reBindDriver = self.driver;
                pushSelfFromBind = YES;
                break;
            }
            
        }
        if (pushSelfFromBind) {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.2;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;;
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            DriverBindViewController *vc = [[DriverBindViewController alloc] init];
            vc.reBindDriver = self.driver;
            [self.navigationController  pushViewController:vc animated:YES];
        }

    }else if (b.tag == BUTTON_TAG_REFRESH_VIEW){
        [self netRefreshDriverInfoWithDriver:self.driver];
    }
    
}


- (void)enterWeifaClicked:(UIButton*)button{//未完成（判断重新加载）
    if (button.tag == BUTTON_TAG_ENTER_LIST) {
        DriveLicensePeccancyRecordViewController *dvc = [[DriveLicensePeccancyRecordViewController alloc] init];
        dvc.driver = self.driver;
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        [self getDriveLicensePeccancyRecordWithDriver:self.driver];
    }
}


#pragma mark- 网络请求
- (void)getDriveLicensePeccancyRecordWithDriver:(DriverInfo*)driver{
    _netStatus = isloadingPeccancyRecord;
    [self reloadWeifaCount];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listbyjszh" forKey:@"action"];
    [dict setObject:driver.driversfzmhm forKey:@"jszh"];
    [dict setObject:driver.dabh forKey:@"dabh"];
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO callBackWithObj:driver onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            _netStatus = loadingPeccancyRecordSucc;

            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonStr = [writer stringWithObject:requestObj];
            DriveLicensePeccancyRecord *driveLPR = [[DriveLicensePeccancyRecord alloc] initWithDriversfzmhm:((DriverInfo*)callBackObj).driversfzmhm jszwf_detail:jsonStr jszwf_gxsj:[[NSDate date]string] andUseId:APP_DELEGATE.userId];
            //ok写入数据库
            [driveLPR update];
        }else{//解析错误
            _netStatus = loadingPeccancyRecordFailed;

            [self.view showAlertText:[NSString stringWithFormat:@"驾驶证违章信息获取失败,%@", requestObj]];
        }
        
        //更新界面显示
        [self reloadWeifaCount];
        
    } onError:^(NSString *errorStr) {
        
        _netStatus = loadingPeccancyRecordFailed;
        [self.view showAlertText:errorStr];
        //更新页面显示
        [self reloadWeifaCount];
    }];
    
}


- (void)netRefreshDriverInfoWithDriver:(DriverInfo*)driver{
    /*
     
     26.驾照信息手工刷新接口方法
     android.do?action=refreshdriver&sfzmhm=632721196911030013&dabh=632700004377&username=test88
     成功结果示例：
     {"ljjf":3,"zjcx":"C1D","djzsxxdz":""}
     失败结果示例：
     {”errormsg:”网络异常请稍后重试"}
     {”errormsg:”返回信息格式错误请稍后重试"}
     */
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"refreshdriver" forKey:@"action"];
    [bodyDict setObject:driver.dabh forKey:@"dabh"];
    [bodyDict setObject:driver.driversfzmhm forKey:@"sfzmhm"];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    [[Network sharedNetwork] postBody:bodyDict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *reqDict = (NSDictionary*)requestObj;
            NSString *errorStr = [reqDict analysisStrValueByKey:@"errormsg"];
            if ([errorStr isEqualToString:@""]) {//succ
                NSString *ljjf = [reqDict analysisStrValueByKey:@"ljjf"];
                NSString *zjcx = [reqDict analysisStrValueByKey:@"zjcx"];
                NSString *djzsxxdz = [reqDict analysisStrValueByKey:@"djzsxxdz"];
                DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
                if (driver) {
                    DriverInfo *newDriver = [[DriverInfo alloc] initWithDriverfzmhm:driver.driversfzmhm
                                                                               dabh:driver.dabh
                                                                                 xm:driver.xm
                                                                       driverstatus:driver.driverstatus
                                                                               ljjf:ljjf
                                                                               zjcx:zjcx
                                                                               yxqz:driver.yxqz
                                                                               zxbh:driver.zxbh
                                                                         drivergxsj:[[NSDate date] string]
                                                                           djzsxxdz:djzsxxdz
                                                                           driverzt:driver.driverzt
                                                                           andUseId:driver.userId];
                    [driver unbind];
                    [newDriver add];
                    [self reloadViews];
                    [self reloadWeifaCount];

                }else{
                    [UIAlertView alertTitle:@"绝对异常" msg:@"数据库原驾照数据为空，无法更新"];
                }
            }else{//failed
                [UIAlertView alertTitle:nil msg:errorStr];
            }
        }else{
            [UIAlertView alertTitle:@"返回格式错误" msg:@"服务器返回非json格式"];
        }
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:nil msg:errorStr];

    }];
}
/*
 
 NSMutableDictionary *body = [NSMutableDictionary dictionary];
 [body setObject:@"deletedriver" forKey:@"action"];
 [body setObject:_driverInfo.driversfzmhm forKey:@"sfzmhm"];
 [body setObject:APP_DELEGATE.userName forKey:@"username"];
 [[Network sharedNetwork] postBody:body isResponseJson:NO doShowIndicator:YES callBackWithObj:_driverInfo onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
 if (result == postSucc) {
 
 DriverInfo *driver = (DriverInfo*)callBackObj;
 [driver unbind];
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"解绑成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
 [alert show];
 }else{
 [UIAlertView alertTitle:@"提示信息" msg:@"取消绑定失败"];
 
 }
 
 } onError:^(NSString *errorStr) {
 
 [UIAlertView alertTitle:@"提示信息" msg:errorStr];
 }];

 
 
 
 */

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
