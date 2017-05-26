#import "CarInfoViewController.h"
#import "CarBindViewController.h"

@interface CarInfoViewController ()<
UIAlertViewDelegate
>
{
    
    UIImageView                 *_contentView;
    
    UIButton                *_rightTopButton;
    
}

@property(nonatomic,strong)CarInfo                  *car;
@property(nonatomic,strong)NSString                *hphm;
@property(nonatomic,copy)NSString                *hphmPrefix;//车牌前缀
@end

@implementation CarInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHphm:(NSString*)hphm{
    if (self = [super init]) {
      //  NSLog(@"%@",_hphm);
     //   _hphm = [[NSString alloc] initWithString:[hphm uppercaseString]];
        _hphm = [[NSString alloc] initWithString:hphm];
   //     NSLog(@"%@",_hphm);

    }
    return self;
}


- (void)gobackPage{//回退至首页
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CarManagerViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TabBarViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}


- (void)reloadViews_
{
    ENTLog(@"DB车辆数量%d", (int)[[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId] count]);
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_hphm];
    self.car = [array lastObject];
    
    for (UIView *v in self.view.subviews){
        [v removeFromSuperview];
    }
    CGFloat bgImgViewY = APP_VIEW_Y/PX_Y_SCALE + 20;
    _hphmPrefix = [[_hphm uppercaseString]substringToIndex:1];
    
   // NSLog(@"%@",_hphmPrefix);
    
   // NSLog(@"%@",self.car.hphm);

    NSRange range = [self.car.vehiclestatus rangeOfString:@"成功"];
    if (range.location == NSNotFound){//失败
        UIView *warnView = [[UIView alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y/PX_Y_SCALE, APP_PX_WIDTH, 80)];
        warnView.backgroundColor = [UIHelper getColor:@"#ffeda3"];
        [self.view addSubview:warnView];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:LGRectMake(20, 20, 40, 40)];
        [imgV setImage:[UIImage imageNamed:@"warn_logo.png"]];
        [warnView addSubview:imgV];
        UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(imgV.r + 20, 20, warnView.w, warnView.h - 40)];
        l.text = @"验证失败，请核对信息后重新提交验证";
        [l convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [warnView addSubview:l];
        
        bgImgViewY = warnView.b + 20;
    }
    
    
    if (range.location == NSNotFound) {//失败
        [_rightTopButton setHidden:YES];
    }else{
        [_rightTopButton setHidden:NO];
        [_rightTopButton setTitle:@"刷新" forState:UIControlStateNormal];
    }
    
    
    CGFloat singleLineHeightPX = 30*3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgViewY width:APP_PX_WIDTH height:singleLineHeightPX*7];
    [self.view addSubview:bgImgView];
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 4 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 5 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 6 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    //*********************************车牌号码*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车牌号码";
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgImgView addSubview:label];
    
    UILabel *contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [self.car.hphm uppercaseString];
  
    [bgImgView addSubview:contentL];
    //*********************************识别代号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"识别代号";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 35)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    NSString *str1 = [self.car.clsbdh substringToIndex:3];
    NSString *str2 = [self.car.clsbdh substringFromIndex:self.car.clsbdh.length-2];
    NSLog(@"%@",self.car.clsbdh);
    contentL.text = [NSString stringWithFormat:@"%@**********%@",str1,str2];
    [bgImgView addSubview:contentL];
    //*********************************车辆类型*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车辆类型";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = self.car.hpzlname;
    [bgImgView addSubview:contentL];
    //*********************************验证状态*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"验证状态";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
 if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
        
        NSRange range = [self.car.vehiclestatus rangeOfString:@"成功"];
        
    if (range.location != NSNotFound) {
        contentL.text = @"验证成功";
        contentL.textColor = [UIHelper getColor:@"#72a0c5"];
        
    }else{
        contentL.text = @"验证失败";
        contentL.textColor = [UIColor redColor];
    }
    }else{
    
        contentL.text = @"未认证";
        contentL.textColor = COLOR_BUTTON_YELLOW;
    
    }
    [bgImgView addSubview:contentL];
    //*********************************距离年检*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*4 + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"年检时间";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [[self.car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"];
    
 
    if ([self.car.yxqz isEqualToString:@""] || range.location == NSNotFound){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];
    
    
    //*********************************保险到期*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*5 + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"保险到期";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [[self.car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"];
    if ([self.car.bxzzrq isEqualToString:@""] || range.location == NSNotFound){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];
    
    //*********************************车辆状态*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*6 + 30, 100, 30)];
    [label convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车辆状态";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:LGRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:V3_38PX_FONT textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [contentL setText:self.car.zt];
    if ([self.car.zt isEqualToString:@""] || range.location == NSNotFound){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];
    
    //*********************************按钮*********************************
    CGFloat buttonBgHeight = 60 + 20 + 20;
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, self.view.h - buttonBgHeight, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    CGFloat buttonWidth = 30*6;
    CGFloat buttonHeight = 60;
    CGFloat buttonSpace = 20;
    CGFloat x = (APP_PX_WIDTH - (buttonWidth*2 + buttonSpace))/2;
    
    //    if (![self.hphm hasPrefix:@"云"]){
    //
    //
    //
    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        button.frame = LGRectMake(x, buttonSpace, buttonWidth, buttonHeight);
    //        [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    //        [button setTitle:@"取消绑定" forState:UIControlStateNormal];
    //        [button.titleLabel setTextColor:[UIColor whiteColor]];
    //        button.titleLabel.font = FONT_NOMAL;
    //        button.tag = TAG_BUTTON_CANCEL_BIND;
    //        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [buttonBgView addSubview:button];
    //
    //        x = button.r + buttonSpace;
    //
    //
    //    }else{
    //        x = (buttonBgView.w - buttonWidth)/2;
    //    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(x, buttonSpace, buttonWidth, buttonHeight);
    [button setTitle:@"重新绑定" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    button.tag = TAG_BUTTON_RE_BIND;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    if (range.location == NSNotFound) {//失败
        
        x = button.r + buttonSpace;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = LGRectMake(x, buttonSpace, buttonWidth, buttonHeight);
        [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
        [button setTitle:@"取消绑定" forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        button.titleLabel.font = FONT_NOMAL;
        button.tag = TAG_BUTTON_CANCEL_BIND;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBgView addSubview:button];
        
        
    }else{//当绑定成功后显示取消绑定按钮
        button.hidden = YES;
        x = (buttonBgView.w - buttonWidth)/2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = LGRectMake(x, buttonSpace, buttonWidth, buttonHeight);
        [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
        [button setTitle:@"取消绑定" forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        button.titleLabel.font = FONT_NOMAL;
        button.tag = TAG_BUTTON_CANCEL_BIND;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBgView addSubview:button];
        
        x = button.r + buttonSpace;
    }
    [buttonBgView addSubview:button];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"车辆信息"];
    
    _rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightTopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightTopButton setBackgroundColor:[UIColor clearColor]];
    [_rightTopButton.titleLabel setFont:FONT_NOMAL];
    [_rightTopButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 60, 30)];
    [_rightTopButton addTarget:self action:@selector(refreshButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_rightTopButton];
    
    
    
    [self reloadViews_];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - ButtonAction


- (void)refreshButtonClicked{
    [self netRefreshCarInfo];
}


- (void)buttonAction:(UIButton *)button
{
    if (button.tag == TAG_BUTTON_CANCEL_BIND) {
        NSRange range = [self.car.vehiclestatus rangeOfString:@"成功"];
        if (range.location == NSNotFound){//失败
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"是否确认执行取消绑定操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = TAG_ALERT_CANCEL_BIND;
            [alert show];
        }else{
        
//                //取消绑定车辆
//                //判断车辆绑定日期是否大于三天 大于的才能取消绑定
//                NSDate *now = [NSDate date];
//                NSTimeInterval timeInterval = [[self.car.createTime convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:now];
//                timeInterval = -timeInterval;
//                int days = timeInterval/60/60/24;
//                if(days >= 3)
//                {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"是否确认执行取消绑定操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = TAG_ALERT_CANCEL_BIND;
                    [alert show];
//                }
//                else
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"绑定时间小于72小时,无法取消绑定" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                    alert.tag = TAG_ALERT_CANCEL_BIND;
//                    [alert show];
//                }
////
        }
        
    }else if(button.tag == TAG_BUTTON_RE_BIND){//重新绑定
        
        BOOL pushSelfFromBind = NO;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[CarBindViewController class]]) {
                ((CarBindViewController*)vc).reBindHphm = _hphm;
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
            CarBindViewController *vc = [[CarBindViewController alloc] initWithRebindHphm:_hphm];
            [self.navigationController  pushViewController:vc animated:YES];
        }
        
        
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_ALERT_CANCEL_BIND) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            
            [self netCancelBind];
            
        }
        
    }else {
        [self gobackPage];
    }
    
}



#pragma mark- 网络请求

- (void)netRefreshCarInfo{
    /*
     31.机动车信息手工刷新接口方法
     http://dev.956122.com:8090/andriod.do?action=refreshvehicle&hpzl=02&hphm=云AE355E&username=test88
     成功结果示例：
     {"yxqz":"2016-09-30","bxzzrq":"2015-09-18","zt":"违法未处理"}
     失败结果示例：
     {”errormsg:”网络异常请稍后重试"}
     {”errormsg:”返回信息格式错误请稍后重试"}
     
     */
    
if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"refreshvehicle" forKey:@"action"];
    [bodyDict setObject:self.car.hpzl forKey:@"hpzl"];
    [bodyDict setObject:self.car.hphm forKey:@"hphm"];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    
    [[Network sharedNetwork] postBody:bodyDict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSString *errorStr = [resDict analysisStrValueByKey:@"errormsg"];
            if ([errorStr isEqualToString:@""]) {//succ reloadViews_
                NSString *yxqz = [resDict analysisStrValueByKey:@"yxqz"];
                NSString *bxzzrq = [resDict analysisStrValueByKey:@"bxzzrq"];
                NSString *zt = [resDict analysisStrValueByKey:@"zt"];
                CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_hphm] lastObject];
                if (car) {
                    CarInfo *newCar = [[CarInfo alloc] initWithHpzl:car.hpzl
                                                           hpzlname:car.hpzlname
                                                               hphm:car.hphm
                                                             clsbdh:car.clsbdh
                                                              clpp1:car.clpp1
                                                    vehicletypename:car.vehicletypename
                                                         vehiclepic:car.vehiclepic
                                                      vehiclestatus:car.vehiclestatus
                                                               yxqz:yxqz
                                                             bxzzrq:bxzzrq
                                                             ccdjrq:car.ccdjrq
                                                        vehiclegxsj:car.vehiclegxsj
                                                           isupdate:car.isupdate
                                                         createTime:car.createTime
                                                                 zt:zt
                                                             sfzmhm:car.sfzmhm
                                                                syr:car.syr
                                                               fdjh:car.fdjh
                                                           andUseId:car.userId];
                    [car unbind];
                    [newCar add];
                    
                    [self reloadViews_];
                }else{
                    [UIAlertView alertTitle:@"绝对异常" msg:@"数据库车牌号码对应的原车辆数据为空，无法更新"];
                }
                
                
            }else{//failed
                [UIAlertView alertTitle:nil msg:errorStr];
            }
        }else{//解析json失败
            [UIAlertView alertTitle:@"返回格式错误" msg:@"服务器返回非json格式"];
        }
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:nil msg:errorStr];
        
        
    }];
     }
}


- (void)netCancelBind{
    if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
        
        NSMutableDictionary *body = [NSMutableDictionary dictionary];
        [body setObject:self.car.hpzl forKey:@"hpzl"];
        [body setObject:self.car.hphm forKey:@"hphm"];
        [body setObject:APP_DELEGATE.userName forKey:@"username"];
        [body setObject:@"deletecar" forKey:@"action"];
        
        [[Network sharedNetwork] postBody:body isResponseJson:NO doShowIndicator:YES callBackWithObj:self.car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            
            if (result == postSucc) {
                CarInfo *car = (CarInfo*)callBackObj;
                [car unbind];
                NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
                [center postNotificationName:@"zhuanshu" object:self userInfo:nil];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"解绑成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else{
                [UIAlertView alertTitle:@"提示信息" msg:@"解绑失败"];
            }
            
            
        } onError:^(NSString *errorStr) {
            [UIAlertView alertTitle:@"提示信息" msg:errorStr];
        }];
    }else{
        
        NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [body setObject:self.car.hpzl forKey:@"hpzl"];
        [body setObject:self.car.hphm forKey:@"hphm"];
        [body setObject:APP_DELEGATE.userName forKey:@"username"];
        [body setObject:@"deleteucar" forKey:@"action"];
        
        
        [[Network sharedNetwork] postBody:body isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            NSLog(@"%@",callBackObj);
            
            id dic=  [Instance_ENT dictionaryWithJsonString:requestObj];
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if([[dic valueForKey:@"code"]isEqualToString:@"0"]){
                    
                    [[DataBase sharedDataBase] deleteCarInfoByHphm:self.hphm andUserId:APP_DELEGATE.userId];
                    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
                    [center postNotificationName:@"zhuanshu" object:self userInfo:nil];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"解绑成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else if ([[dic valueForKey:@"code"]isEqualToString:@"1"]){
                    
                    [UIAlertView alertTitle:@"提示信息" msg:@"解绑失败"];
                    
                }else if ([[dic valueForKey:@"code"]isEqualToString:@"2"]){
                    
                    [UIAlertView alertTitle:@"提示信息" msg:@"解绑失败"];
                }else{
                    
                    [UIAlertView alertTitle:@"提示信息" msg:@"解绑失败"];
                }
            }else{
                
                if ([dic isKindOfClass:[NSString class]]) {
                    
                }
            }
            
            
            
        } onError:^(NSString *errorStr) {
            [UIAlertView alertTitle:@"提示信息" msg:errorStr];
        }];
        
        
        
        
        
        
        
        
        
        
        
    }
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
