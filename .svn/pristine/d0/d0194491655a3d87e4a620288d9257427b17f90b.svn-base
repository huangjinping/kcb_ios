//
//  DriverBindViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriverBindViewController.h"
#import "QuestionNoticeView.h"

@interface DriverBindViewController ()<UITextFieldDelegate>
{
    QuestionNoticeView      *_quesNoticeview;
    UIView                  *_bgDarkView;
    UIImageView             *_bgView0;
    UIImageView             *_bgView1;
    UIImageView             *_bgView2;
    UIScrollView *scrollV;
}
@end

@implementation DriverBindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#define INPUT_BGVIEW_HEIGHT    220

- (void)loadView_
{
    
  
    
    scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [self.view addSubview:scrollV];
    
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(30, 20, 200, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    l.text = @"驾驶证信息";
    [scrollV addSubview:l];
    
    CGFloat singleLineHeightPX = 30*3;
    //*********************************真实姓名+证件号码*********************************
    _bgView0 = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:l.b + 20 width:APP_PX_WIDTH height:singleLineHeightPX*2];
    [scrollV addSubview:_bgView0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"真实姓名";
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_bgView0 addSubview:label];
    _xmTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _bgView0.w - label.r - 30, 40) placeholder:@"您的姓名" tag:0 delegate:self];
    
    _xmTF.tag=100;
    [_bgView0 addSubview:_xmTF];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"证件号码";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_bgView0 addSubview:label];
    _sfzhmTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _bgView0.w - label.r - 30, 40) placeholder:@"身份证号码" tag:0 delegate:self];
    _sfzhmTF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _sfzhmTF.keyboardType = UIKeyboardTypeASCIICapable;
    [_bgView0 addSubview:_sfzhmTF];
    //横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_bgView0 addSubview:lineLabel];
   
    //*********************************档案编号*********************************
    _bgView1 = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:_bgView0.b + 20 width:APP_PX_WIDTH height:singleLineHeightPX];
    [scrollV addSubview:_bgView1];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"档案编号";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_bgView1 addSubview:label];
    
    _dabhTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _bgView1.w - label.r - 35 - 30 - 50, 40) placeholder:@"驾照档案编号" tag:0 delegate:self];
    _dabhTF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _dabhTF.keyboardType = UIKeyboardTypeASCIICapable;
    
    [_bgView1 addSubview:_dabhTF];
    
    UIButton *iButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iButton setFrame:LGRectMake(_dabhTF.r + 5, _dabhTF.t, 40, 40)];
    [iButton setImage:[UIImage imageNamed:@"warn_logo"] forState:UIControlStateNormal];
    [iButton addTarget:self action:@selector(iButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView1 addSubview:iButton];

    //*********************************证芯编号*********************************
    _bgView2 = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:_bgView1.b + 20 width:APP_PX_WIDTH height:singleLineHeightPX];
    [scrollV addSubview:_bgView2];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"证芯编号";
    size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_bgView2 addSubview:label];
    
    _zxbhTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _bgView2.w - label.r - 35 - 30 - 50, 40) placeholder:@"新版驾照请填写" tag:0 delegate:self];
    _zxbhTF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _zxbhTF.keyboardType = UIKeyboardTypeASCIICapable;

    
    [_bgView2 addSubview:_zxbhTF];

    
    UIButton *submitB = [UIButton mainButtonWithPXY:_bgView2.b + 30 title:@"完 成" target:self action:@selector(submitButtonClicked:)];
    [scrollV addSubview:submitB];
    
    UIImageView *baomiImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, submitB.b + 30, 45 , 52)];
    [baomiImgView setImage:[UIImage imageNamed:@"home_secret"]];
    [scrollV addSubview:baomiImgView];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:LGRectMake(baomiImgView.r + 20, baomiImgView.t, APP_PX_WIDTH - baomiImgView.r - 20 - 30, 60)];
    [noticeLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    noticeLabel.numberOfLines = 0;
    noticeLabel.text = @"以上信息仅用于本次违法查询和缴款，开车邦将严格保密，请您放心填写！";
    [scrollV addSubview:noticeLabel];
    
    UILabel *tishiL = [[UILabel alloc] initWithFrame:LGRectMake(baomiImgView.l, noticeLabel.b + 30, 400, 24)];
    [tishiL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    tishiL.text = @"提示";
    [scrollV addSubview:tishiL];
    tishiL = [[UILabel alloc] initWithFrame:LGRectMake(tishiL.l, tishiL.b + 20, APP_PX_WIDTH - tishiL.l - 30, 24)];
    [tishiL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    tishiL.numberOfLines = 0;
    tishiL.text = @"1、系统默认您绑定的驾驶证为违法处理人，云南省除外；";
    [tishiL setSize:[tishiL.text sizeWithFont:tishiL.font constrainedToSize:CGSizeMake(tishiL.width, 1000)]];
    [scrollV addSubview:tishiL];
    tishiL = [[UILabel alloc] initWithFrame:LGRectMake(tishiL.l, tishiL.b + 20, APP_PX_WIDTH - tishiL.l - 30, 24)];
    [tishiL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    tishiL.numberOfLines = 0;
    tishiL.text = @"2、驾驶证信息将由交警系统核验，校验通过后不可取消绑定";
    [tishiL setSize:[tishiL.text sizeWithFont:tishiL.font constrainedToSize:CGSizeMake(tishiL.width, 1000)]];
    [scrollV addSubview:tishiL];
    
    if (tishiL.bottom + APP_NAV_HEIGHT > scrollV.height) {
        [scrollV setContentSize:CGSizeMake(scrollV.width, tishiL.bottom + APP_NAV_HEIGHT)];
    }else{
        [scrollV setContentSize:CGSizeMake(scrollV.width, scrollV.height)];
    }
    

    //*********************************弹出框背景等*********************************
    _bgDarkView = [[UIView alloc] initWithFrame:CGRectMake(scrollV.left, scrollV.top, scrollV.width, scrollV.contentSize.height)]
    ;
    _bgDarkView.backgroundColor = [UIHelper getColor:@"#000000"];
    _bgDarkView.alpha = 0.4;
    _bgDarkView.hidden = YES;
    [scrollV addSubview:_bgDarkView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfviewTaped)];
    [_bgDarkView addGestureRecognizer:tap];
    
    _quesNoticeview = [[QuestionNoticeView alloc] initWithFrame:CGRectMake(30, scrollV.contentSize.height, APP_WIDTH - 30*2, 200) image:[UIImage imageNamed:@"jsz.png"] andTitle:@"怎样查找识别代码?"];
    [scrollV addSubview:_quesNoticeview];

    
    if (self.reBindDriver) {
        _xmTF.text = self.reBindDriver.xm;
        _zxbhTF.text = self.reBindDriver.zxbh;
        _dabhTF.text = self.reBindDriver.dabh;
        _sfzhmTF.text = self.reBindDriver.driversfzmhm;
    }

}
- (void)keyboardWillHide:(NSNotification*)notify{
    [scrollV setFrame:CGRectMake(scrollV.left, 0, scrollV.width, scrollV.height)];
    
}
- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_xmTF isFirstResponder]) {
        bottomY = _xmTF.bottom + _bgView0.top + space;
    }else if ([_sfzhmTF isFirstResponder]) {
        bottomY = _sfzhmTF.bottom + _bgView0.top + space;
    }else if ([_dabhTF isFirstResponder]) {
        bottomY = _dabhTF.bottom + _bgView1.top + space;
    }else if ([_zxbhTF isFirstResponder]) {
        bottomY = _zxbhTF.bottom + _bgView2.top + space;
    }
    
    CGFloat keyBoardStartY = scrollV.frame.size.height - scrollV.frame.origin.y - frame.size.height;
    if (keyBoardStartY < bottomY) {
        [scrollV setFrame:CGRectMake(scrollV.left, scrollV.top - (bottomY - keyBoardStartY), scrollV.width, scrollV.height)];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];

    //初始化子视图
    [self loadView_];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"驾照绑定"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)iButtonClicked:(UIButton*)button{
    if (_quesNoticeview.frame.origin.y > scrollV.height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = NO;
            
            [_quesNoticeview setFrame:CGRectMake(30, scrollV.contentSize.height/4, _quesNoticeview.width, _quesNoticeview.height)];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = YES;
            
            [_quesNoticeview setFrame:CGRectMake(30, scrollV.contentSize.height, _quesNoticeview.width, _quesNoticeview.height)];
            
        }];
    }
    
}

- (void)selfviewTaped{
    if (_quesNoticeview.frame.origin.y > scrollV.height/2) {
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = YES;
            [_quesNoticeview setFrame:CGRectMake(30, scrollV.contentSize.height, _quesNoticeview.width, _quesNoticeview.height)];
            
        }];
    }
}


- (BOOL)keepAndRuleCommitText{
    self.xmStr = _xmTF.text;
    self.sfzhmStr = _sfzhmTF.text;
    self.zxbhStr = _zxbhTF.text;
    self.dabhStr = _dabhTF.text;
    
    if (self.zxbhStr == nil) {
        self.zxbhStr = @"";
    }
    
    if (self.xmStr == nil || [self.xmStr isEqualToString:@""]) {
        [UIAlertView alertTitle:@"提示信息" msg:@"真实姓名不能为空!"];
        return NO;
    }
    if (self.sfzhmStr == nil || [self.sfzhmStr isEqualToString:@""]) {
        [UIAlertView alertTitle:@"提示信息" msg:@"证件号码不能为空!"];
        return NO;
    }
    
    if (self.dabhStr == nil || [self.dabhStr isEqualToString:@""]) {
        [UIAlertView alertTitle:@"提示信息" msg:@"档案编号不能为空!"];
        return NO;
    }


//    if (self.zxbhStr == nil || [self.zxbhStr isEqualToString:@""]) {
//        [UIAlertView alertTitle:@"提示信息" msg:@"证芯编号不能为空!"];
//        return NO;
//    }
    
    if (![self.sfzhmStr isValidIDNumber]){
        [UIAlertView alertTitle:@"提示信息" msg:@"请填写正确的证件号码!"];
        return NO;
    }
    if ([self.dabhStr length] != 12){
        [UIAlertView alertTitle:@"提示信息" msg:@"请填写正确的档案编号!"];
        return NO;
    }
    return YES;
}


//提交验证的响应方法
- (void)submitButtonClicked:(UIButton *)button
{
    [_xmTF resignFirstResponder];
    [_dabhTF resignFirstResponder];
    [_zxbhTF resignFirstResponder];
    [_sfzhmTF resignFirstResponder];
    
    if (![self keepAndRuleCommitText]) {
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:self.sfzhmStr forKey:@"sfzmhm"];
    [dict setObject:self.dabhStr forKey:@"dabh"];
    [dict setObject:self.xmStr forKey:@"xm"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    
    if (!self.reBindDriver) {//bind
        [dict setObject:@"addDriver" forKey:@"action"];
        
        Network *netWork = [Network sharedNetwork];
        [netWork postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            
            
            if (result == postSucc) {
                
                //0,zjcx,ljjf
                NSString *resStr = (NSString*)requestObj;
                NSArray *arr = [resStr componentsSeparatedByString:@","];
                NSString *zjcx = @"";
                NSString *ljjf = @"";
                NSString *driverzt = @"";
                if ([arr count] == 3) {
                    zjcx = [arr objectAtIndex:0];
                    ljjf = [arr objectAtIndex:1];
                    driverzt = [arr objectAtIndex:2];
                }
                //0,C1D,28,违法未处理;超分;协查;停止使用
                DriverInfo *driverInfo = [[DriverInfo alloc] initWithDriverfzmhm:self.sfzhmStr
                                                                            dabh:self.dabhStr
                                                                              xm:self.xmStr
                                                                    driverstatus:@"绑定成功"
                                                                            ljjf:ljjf
                                                                            zjcx:zjcx
                                                                            yxqz:@""
                                                                            zxbh:self.zxbhStr
                                                                      drivergxsj:[[NSDate date] string]
                                                                        djzsxxdz:@""
                                                                        driverzt:driverzt
                                                                        andUseId:APP_DELEGATE.userId];
                [driverInfo add];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"绑定成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                
                DriverInfo *driverInfo = [[DriverInfo alloc] initWithDriverfzmhm:self.sfzhmStr
                                                                            dabh:self.dabhStr
                                                                              xm:self.xmStr
                                                                    driverstatus:(NSString*)requestObj
                                                                            ljjf:@""
                                                                            zjcx:@""
                                                                            yxqz:@""
                                                                            zxbh:self.zxbhStr
                                                                      drivergxsj:[[NSDate date] string]
                                                                        djzsxxdz:@""
                                                                        driverzt:@"--"
                                                                        andUseId:APP_DELEGATE.userId];
                [driverInfo add];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"绑定失败,%@", (NSString*)requestObj] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        } onError:^(NSString *errorStr) {
            
            [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"绑定失败,%@", errorStr]];
        }];

    }else{//re bind

        [dict setObject:@"updatedriver" forKey:@"action"];
        
        [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            if (result == postSucc) {
                
                //0,zjcx,ljjf
                NSString *resStr = (NSString*)requestObj;
                NSArray *arr = [resStr componentsSeparatedByString:@","];
                NSString *zjcx = @"";
                NSString *ljjf = @"";
                NSString *driverzt = @"";
                if ([arr count] == 3) {
                    zjcx = [arr objectAtIndex:0];
                    ljjf = [arr objectAtIndex:1];
                    driverzt = [arr objectAtIndex:2];
                }
                DriverInfo *driverInfo = [[DriverInfo alloc] initWithDriverfzmhm:self.sfzhmStr
                                                                            dabh:self.dabhStr
                                                                              xm:self.xmStr
                                                                    driverstatus:@"绑定成功"
                                                                            ljjf:ljjf
                                                                            zjcx:zjcx
                                                                            yxqz:@""
                                                                            zxbh:self.zxbhStr
                                                                      drivergxsj:[[NSDate date] string]
                                                                        djzsxxdz:@""
                                                                        driverzt:driverzt
                                                                        andUseId:APP_DELEGATE.userId];
                [self.reBindDriver unbind];
                [driverInfo add];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"重新绑定成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                
                DriverInfo *driverInfo = [[DriverInfo alloc] initWithDriverfzmhm:self.sfzhmStr
                                                                            dabh:self.dabhStr
                                                                              xm:self.xmStr
                                                                    driverstatus:(NSString*)requestObj
                                                                            ljjf:@""
                                                                            zjcx:@""
                                                                            yxqz:@""
                                                                            zxbh:self.zxbhStr
                                                                      drivergxsj:[[NSDate date] string]
                                                                        djzsxxdz:@""
                                                                        driverzt:@"--"
                                                                        andUseId:APP_DELEGATE.userId];
                [self.reBindDriver unbind];
                [driverInfo add];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"重新绑定失败,%@", (NSString*)requestObj] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
            }

            
        } onError:^(NSString *errorStr) {
            
            [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"重新绑定失败,%@", errorStr]];

        }];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    BOOL pushSelfFromInfo = NO;
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        if ([vc isKindOfClass:[DriverInfoViewController class]]) {
//            pushSelfFromInfo = YES;
//            break;
//        }
//        
//    }
//    if (pushSelfFromInfo) {
//        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
//        animation.duration = 0.2;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = kCATransitionPush;
//        animation.subtype = kCATransitionFromRight;;
//        [self.navigationController.view.layer addAnimation:animation forKey:nil];
//        [self.navigationController popViewControllerAnimated:NO];
//    }else{
        DriveLicenseManageViewController *driverVC = [[DriveLicenseManageViewController alloc] init];
        [self.navigationController pushViewController:driverVC animated:YES];
//    }

}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField;
//{
//    
//    [textField resignFirstResponder];
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==100) {
        return YES;
    }else{
    //    define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    NSString *upperCaseString1 = [filtered uppercaseString];
    BOOL canChange = [string isEqualToString:upperCaseString1];
    
    return canChange;
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
