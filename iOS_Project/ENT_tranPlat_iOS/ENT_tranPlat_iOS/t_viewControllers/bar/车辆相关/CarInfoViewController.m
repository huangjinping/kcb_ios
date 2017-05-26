//
//  CarInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarBindViewController.h"

@interface CarInfoViewController ()

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
        _hphm = [[NSString alloc] initWithString:hphm];
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
    for (UIView *v in self.view.subviews){
        [v removeFromSuperview];
    }
    CGFloat bgImgViewY = 20;
    NSRange range = [self.car.vehiclestatus rangeOfString:@"成功"];
    if (range.location == NSNotFound){//失败
        UIView *warnView = [[UIView alloc] initWithFrame:YYRectMake(0, 0, APP_PX_WIDTH, 80)];
        warnView.backgroundColor = [UIHelper getColor:@"#ffeda3"];
        [self.view addSubview:warnView];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:YYRectMake(20, 20, 40, 40)];
        [imgV setImage:[UIImage imageNamed:@"warn_logo.png"]];
        [warnView addSubview:imgV];
        UILabel *l = [[UILabel alloc] initWithFrame:YYRectMake(imgV.r + 20, 20, warnView.w, warnView.h - 40)];
        l.text = @"验证失败，请核对信息后重新提交验证";
        [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [warnView addSubview:l];
        
        bgImgViewY += warnView.b;
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
    UILabel *label = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车牌号码";
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [bgImgView addSubview:label];
    
    UILabel *contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [self.car.hphm uppercaseString];
    [bgImgView addSubview:contentL];
    //*********************************识别代号*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"识别代号";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 35)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    NSString *str1 = [self.car.clsbdh substringToIndex:3];
    NSString *str2 = [self.car.clsbdh substringFromIndex:self.car.clsbdh.length-2];
    contentL.text = [NSString stringWithFormat:@"%@**********%@",str1,str2];
    [bgImgView addSubview:contentL];
    //*********************************车辆类型*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX*2 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车辆类型";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = self.car.hpzlname;
    [bgImgView addSubview:contentL];
    //*********************************验证状态*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX*3 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"验证状态";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    if (range.location != NSNotFound) {
        contentL.text = @"验证成功";
        contentL.textColor = [UIHelper getColor:@"#72a0c5"];
        
    }else{
        contentL.text = @"验证失败";
        contentL.textColor = [UIColor redColor];
    }
    [bgImgView addSubview:contentL];
    //*********************************距离年检*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX*4 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"年检时间";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [[self.car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"];
    if ([self.car.yxqz isEqualToString:@""]){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];
    
    
    //*********************************保险到期*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX*5 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"保险到期";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    contentL.text = [[self.car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"];
    if ([self.car.bxzzrq isEqualToString:@""]){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];
   
    //*********************************车辆状态*********************************
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeightPX*6 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车辆状态";
    label.size = size;
    [bgImgView addSubview:label];
    contentL = [[UILabel alloc] initWithFrame:YYRectMake(label.r, label.t, bgImgView.w - label.r - 30, 30)];
    [contentL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [contentL setText:self.car.zt];
    if ([self.car.zt isEqualToString:@""]){
        contentL.text = @"--";
    }
    [bgImgView addSubview:contentL];

    //*********************************按钮*********************************
    CGFloat buttonBgHeight = 60 + 20 + 20;
    UIView *buttonBgView = [[UIView alloc] initWithFrame:YYRectMake(0, self.view.h - buttonBgHeight, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    CGFloat buttonWidth = 30*6;
    CGFloat buttonHeight = 60;
    CGFloat buttonSpace = 20;
    CGFloat x = (APP_PX_WIDTH - (buttonWidth*2 + buttonSpace))/2;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = YYRectMake(x, buttonSpace, buttonWidth, buttonHeight);
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button setTitle:@"取消绑定" forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    button.titleLabel.font = FONT_NOMAL;
    button.tag = TAG_BUTTON_CANCEL_BIND;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBgView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = YYRectMake(x + buttonSpace + buttonWidth, buttonSpace, buttonWidth, buttonHeight);
    [button setTitle:@"重新绑定" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    button.tag = TAG_BUTTON_RE_BIND;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    if (range.location == NSNotFound) {//失败
        [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIColor whiteColor]];

    }else{
        [button setBackgroundImage:[[UIImage imageNamed:@"button_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 100, 25, 100)] forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIHelper getColor:@"#cccccc"]];
        [button setUserInteractionEnabled:NO];
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
    
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_hphm];
    self.car = [array lastObject];
    [self reloadViews_];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - ButtonAction
- (void)buttonAction:(UIButton *)button
{
    if (button.tag == TAG_BUTTON_CANCEL_BIND) {//取消绑定车辆
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"是否确认执行取消绑定操作？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = TAG_ALERT_CANCEL_BIND;
        [alert show];
        
        
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
            NSMutableDictionary *body = [NSMutableDictionary dictionary];
            [body setObject:self.car.hpzl forKey:@"hpzl"];
            [body setObject:self.car.hphm forKey:@"hphm"];
            [body setObject:APP_DELEGATE.userName forKey:@"username"];
            [body setObject:@"deletecar" forKey:@"action"];
            
            [[Network sharedNetwork] postBody:body isResponseJson:NO doShowIndicator:YES callBackWithObj:self.car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
                
                if (result == postSucc) {
                    CarInfo *car = (CarInfo*)callBackObj;
                    [car unbind];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"解绑成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                else{
                    [UIAlertView alertTitle:@"提示信息" msg:@"解绑失败"];
                }
                
                
            } onError:^(NSString *errorStr) {
                [UIAlertView alertTitle:@"提示信息" msg:errorStr];
            }];

        }
        
    }else {
        [self gobackPage];
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
