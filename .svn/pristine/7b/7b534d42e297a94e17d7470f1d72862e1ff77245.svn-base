//
//  RegistViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<
UITextFieldDelegate,
UIAlertViewDelegate
>
{
    
    UITextField     *_userNameTF;
    UITextField     *_passwordTF;
    UITextField     *_phoneNumTF;
    UITextField     *_yanzhengmaTF;
    
    
    UIButton        *_getYanzhengmaB;
    
    
    UIButton        *_dealButton0;
    UIButton        *_dealButton1;
    UIButton        *_dealButton2;
    
    CGFloat         _keyBoardHeight;
}

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)_load_view{
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:YYRectMake(0, APP_VIEW_Y/PX_Y_SCALE + 30, APP_PX_WIDTH, FIRST_PAGE_TF_LINE_HEIGHT*4)];
    [bgImgView setUserInteractionEnabled:YES];
    [bgImgView setImage:[UIImage imageNamed:@""]];
    //[bgImgView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:bgImgView];
    
    UILabel *l = [[UILabel alloc] initWithFrame:YYRectMake(40, FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"用户名";
    [bgImgView addSubview:l];
    _userNameTF = [UITextField mainTextFieldWithFrame:YYRectMake(l.r + 40, FIRST_PAGE_TF_SPACE, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"4-20位字符" tag:TAG_TF_USER_EXIST_NO delegate:self];
    [bgImgView addSubview:_userNameTF];
    
    l = [[UILabel alloc] initWithFrame:YYRectMake(40, FIRST_PAGE_TF_LINE_HEIGHT + FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"手机号码";
    [bgImgView addSubview:l];
    _phoneNumTF = [UITextField mainTextFieldWithFrame:YYRectMake(l.r + 40, FIRST_PAGE_TF_SPACE + FIRST_PAGE_TF_LINE_HEIGHT, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"常用手机号码" tag:0 delegate:self];
    [bgImgView addSubview:_phoneNumTF];

    _yanzhengmaTF = [UITextField mainTextFieldWithFrame:YYRectMake(40 + 30, FIRST_PAGE_TF_SPACE+ FIRST_PAGE_TF_LINE_HEIGHT*2, 300, FIRST_PAGE_TF_HEIGHT) placeholder:@"请输入验证码" tag:0 delegate:self];
    [bgImgView addSubview:_yanzhengmaTF];
    _getYanzhengmaB = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getYanzhengmaB setFrame:YYRectMake(_yanzhengmaTF.r, _yanzhengmaTF.t, 300, _yanzhengmaTF.h)];
    [_getYanzhengmaB setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_getYanzhengmaB setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    _getYanzhengmaB.titleLabel.font = FONT_NOMAL;
    [_getYanzhengmaB setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    [_getYanzhengmaB addTarget:self action:@selector(getYanzhengmaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_getYanzhengmaB];

    l = [[UILabel alloc] initWithFrame:YYRectMake(40, FIRST_PAGE_TF_LINE_HEIGHT*3 + FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"密码";
    [bgImgView addSubview:l];
    _passwordTF = [UITextField mainTextFieldWithFrame:YYRectMake(l.r + 40, FIRST_PAGE_TF_SPACE+ FIRST_PAGE_TF_LINE_HEIGHT*3, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"6-16位字符" tag:0 delegate:self];
    [_passwordTF setSecureTextEntry:YES];
    [bgImgView addSubview:_passwordTF];
    
    
    
    //注册
    UIButton *submitBtn = [UIButton mainButtonWithPXY:bgImgView.b + 30 title:@"注 册" target:self action:@selector(registUser)];
    [self.view addSubview:submitBtn];

    
    CGFloat dealLabelWidth = 500;
    _dealButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dealButton0 setFrame:YYRectMake((APP_PX_WIDTH - dealLabelWidth)/2, submitBtn.b + 40, 14/PX_X_SCALE, 14/PX_Y_SCALE)];
    [_dealButton0 setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    [_dealButton0 addTarget:self action:@selector(dealClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_dealButton0 setTag:BUTTON_TAG_UNSELECTED];
    [self.view addSubview:_dealButton0];
    UILabel *dealLabel = [[UILabel alloc] initWithFrame:YYRectMake(_dealButton0.r, _dealButton0.t - 2, dealLabelWidth, 24)];
    [dealLabel setFont:FONT_NOTICE];
    [dealLabel setTextColor:COLOR_LINK];
    [dealLabel setText:@"《用户注册协议》"];
    [dealLabel setTextAlignment:NSTextAlignmentLeft];
    [dealLabel setBackgroundColor:[UIColor clearColor]];
    [dealLabel setUserInteractionEnabled:YES];
    [self.view addSubview:dealLabel];
    UITapGestureRecognizer *tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealJSY:)];
    [dealLabel addGestureRecognizer:tapDeal];
    
    _dealButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dealButton1 setFrame:YYRectMake(_dealButton0.l, _dealButton0.b + 10, _dealButton0.w, _dealButton0.h)];
    [_dealButton1 setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    [_dealButton1 addTarget:self action:@selector(dealClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_dealButton1 setTag:BUTTON_TAG_UNSELECTED];
    [self.view addSubview:_dealButton1];
    dealLabel = [[UILabel alloc] initWithFrame:YYRectMake(dealLabel.l, dealLabel.b + 10, dealLabel.w, dealLabel.h)];
    [dealLabel setFont:FONT_NOTICE];
    [dealLabel setTextColor:COLOR_LINK];
    [dealLabel setText:@"《交通违法行为网上自助处理使用协议》"];
    [dealLabel setTextAlignment:NSTextAlignmentLeft];
    [dealLabel setBackgroundColor:[UIColor clearColor]];
    [dealLabel setUserInteractionEnabled:YES];
    [self.view addSubview:dealLabel];
    tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealZZFW:)];
    [dealLabel addGestureRecognizer:tapDeal];
    
    _dealButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dealButton2 setFrame:YYRectMake(_dealButton1.l, _dealButton1.b + 10, _dealButton1.w, _dealButton1.h)];
    [_dealButton2 setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    [_dealButton2 addTarget:self action:@selector(dealClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_dealButton2 setTag:BUTTON_TAG_UNSELECTED];
    [self.view addSubview:_dealButton2];
    dealLabel = [[UILabel alloc] initWithFrame:YYRectMake(dealLabel.l, dealLabel.b + 10, dealLabel.w, dealLabel.h)];
    [dealLabel setFont:FONT_NOTICE];
    [dealLabel setTextColor:COLOR_LINK];
    [dealLabel setText:@"《互动模块（发帖论坛）使用协议》"];
    [dealLabel setTextAlignment:NSTextAlignmentLeft];
    [dealLabel setBackgroundColor:[UIColor clearColor]];
    [dealLabel setUserInteractionEnabled:YES];
    [self.view addSubview:dealLabel];
    tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealHDMK:)];
    [dealLabel addGestureRecognizer:tapDeal];
}
- (void)viewDidLoad
{
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [super viewDidLoad];
    [self _load_view];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"免费注册"];

}

#pragma mark- button response
- (void)getYanzhengmaClicked:(UIButton*)btn{
    if ([_phoneNumTF.text isValidPhoneNum]) {
        [self netSendYanzhengma:_phoneNumTF.text];
    }else{
        [self.view showAlertText:@"请输入正确的手机号码"];
    }
}

- (void)dealClicked:(UIButton*)button{
    if (button.tag == BUTTON_TAG_UNSELECTED) {
        button.tag = BUTTON_TAG_SELECTED;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_dealSelected.png"] forState:UIControlStateNormal];
    }else if(button.tag == BUTTON_TAG_SELECTED) {
        button.tag = BUTTON_TAG_UNSELECTED;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    
    }
}

- (void)tapDealZZFW:(UITapGestureRecognizer*)tap{
    SelfHelpDealViewController *shdVC = [[SelfHelpDealViewController alloc] init];
    [self.navigationController pushViewController:shdVC animated:YES];
}

- (void)tapDealJSY:(UITapGestureRecognizer*)tap{
    DriverServicePlatDealViewController *dspdVC = [[DriverServicePlatDealViewController alloc] init];
    [self.navigationController pushViewController:dspdVC animated:YES];
}

- (void)tapDealHDMK:(UITapGestureRecognizer*)tap{
    RidersInteractionViewController *riVC = [[RidersInteractionViewController alloc] init];
    [self.navigationController pushViewController:riVC animated:YES];
}

//校验用户填写的注册信息
- (BOOL)verifyRegistInfo{
    if (_dealButton1.tag == BUTTON_TAG_UNSELECTED) {
        [UIAlertView alertTitle:@"协议勾选" msg:@"如注册，请选择同意《交通违法行为网上自助处理使用协议》！"];
        return NO;
    }
    if (_dealButton0.tag == BUTTON_TAG_UNSELECTED) {
        [UIAlertView alertTitle:@"协议勾选" msg:@"如注册，请选择同意《用户注册协议》！"];
        return NO;
    }
    if (_dealButton2.tag == BUTTON_TAG_UNSELECTED) {
        [UIAlertView alertTitle:@"协议勾选" msg:@"如注册，请选择同意《互动模块（发帖论坛）使用协议》！"];
        return NO;
    }
    //手机号码
    if ([_phoneNumTF.text isEqualToString:@""] || !_phoneNumTF.text || ![_phoneNumTF.text isValidPhoneNum]) {
        [UIAlertView alertTitle:@"手机号码" msg:@"请您填写正确的手机号码！"];
        return NO;
    }
    //用户名
    if ([_userNameTF.text isEqualToString:@""] || !_userNameTF.text || [_userNameTF.text length] < 4 || [_userNameTF.text length] > 20) {
        [UIAlertView alertTitle:@"用户名" msg:@"请您填写符合规则的用户名(4-20位字符)！"];
        return NO;
    }
    if (_userNameTF.tag == TAG_TF_USER_EXIST_YES) {
        [UIAlertView alertTitle:@"用户名" msg:@"用户名已存在，请修改用户名或直接登录！"];
        return NO;
    }
    //密码
    if ([_passwordTF.text isEqualToString:@""] || !_passwordTF.text || [_passwordTF.text length] < 6 || [_passwordTF.text length] > 16) {
        [UIAlertView alertTitle:@"密码" msg:@"请您设置符合规则的密码(6-16位字符)！"];
        return NO;
    }
    
    
    return YES;
}

#pragma mark- 网络请求

//注册
- (void)registUser{
    
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    //[_verifyPasswordTF resignFirstResponder];
    [_phoneNumTF resignFirstResponder];
    //[_emailAddrTF resignFirstResponder];
    
    if ([self verifyRegistInfo]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dict setObject:@"register" forKey:@"action"];
        [dict setObject:_userNameTF.text forKey:@"username"];
        [dict setObject:_passwordTF.text forKey:@"cmspassword"];
        //[dict setObject:_emailAddrTF.text forKey:@"email"];
        [dict setObject:_phoneNumTF.text forKey:@"mobilephone"];
        [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            NSString *reqStr = (NSString*)requestObj;
            if (postSucc == result) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"注册成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                alert.tag = ALERT_REGIST_SUCC;
                [alert show];
            }else{
                [UIAlertView alertTitle:@"注册失败" msg:reqStr];
                //注册失败逻辑
            }

        } onError:^(NSString *errorStr) {
            [UIAlertView alertTitle:@"网络请求失败" msg:errorStr];

        }];
    }
}


- (void)netExistUser:(NSString*)user{
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"checkuser", @"action", user, @"usernmae", nil];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"pr.956122.com"];
    MKNetworkOperation *op = [en operationWithPath:@"user.do" params:dict httpMethod:@"GET"];

    ENTLog(@"\n网络请求地址：%@",op.url);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //请求成功
        NSString *responseStr = completedOperation.responseString;
        
        ENTLog(@"\n连接服务器成功，返回字符串：%@",responseStr);
        
        if ([responseStr isEqualToString:@"0"]) {//不存在
            
        }else if ([responseStr isEqualToString:@"1"]){//存在
            _userNameTF.textColor = [UIColor redColor];
            _userNameTF.tag = TAG_TF_USER_EXIST_YES;
            [UIAlertView alertTitle:@"用户名已存在" msg:@"请修改用户名或直接登录"];
            //[self.view showAlertText:@"用户名已存在，请修改用户名或直接登录。"];
        }else{//异常
        
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //请求失败
        NSString *errorStr = [NSString stringWithFormat:@"error%@", error];
        
        
        ENTLog(@"%@", [NSString stringWithFormat:@"连接服务器失败，错误信息%@,服务器返回：%@", errorStr, completedOperation.responseString]);
        
        
        
    }];
    
    [en enqueueOperation:op];

    
}


//获取验证码
- (void)netSendYanzhengma:(NSString*)tel{
    
    //成功后，self.yanzhengma赋值，并开始计时3分钟后，self.yanzhengma置空
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"sendverifymes" forKey:@"action"];
    [dict setObject:tel forKey:@"mobile"];//pr.956122.com/user.do?aciton=sendverifymes
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict  = (NSDictionary*)requestObj;
            NSString *resultStr = [resDict analysisStrValueByKey:@"result"];
            if ([resultStr isEqualToString:@"0"]) {//成功
               // NSString *shortmessage = [NSString stringWithString:[resDict analysisStrValueByKey:@"shortmessage"]];

                //[self performSelector:@selector(invalideYanzhengma) withObject:nil afterDelay:60*3.0f];
                //_yanzhengButton.userInteractionEnabled = NO;
                //[_yanzhengButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];
            }else if ([resultStr isEqualToString:@"1"]){
                NSString *errormsg = [resDict analysisStrValueByKey:@"errormsg"];
                [UIAlertView alertTitle:nil msg:[NSString stringWithFormat:@"发送验证码失败，%@", errormsg]];
            }else{
                [UIAlertView alertTitle:nil msg:@"发送验证码失败，服务器返回异常"];
                
            }
        }
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:nil msg:[NSString stringWithFormat:@"发送验证码失败，%@", errorStr]];
        
    }];
    
}



#pragma mark- notification
- (void)keyboardWillShow:(NSNotification*)notify{
    //获取键盘的高度
    NSDictionary *userInfo = [notify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyBoardHeight = keyboardRect.size.height;

}

#pragma mark- UI DELEGATE

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ([textField isEqual:_phoneNumTF] ) {
        if ([textField.text length] > 10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }else if ([textField isEqual:_userNameTF] ) {
        if ([textField.text length] > 19 && ![string isEqualToString:@""]) {
            return NO;
        }
    }else if ([textField isEqual:_passwordTF] ) {
        if ([textField.text length] > 15 && ![string isEqualToString:@""]) {
            return NO;
        }
    }else if ([textField isEqual:_yanzhengmaTF]){
        if (textField.text.length > 3 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//
//    textField.textColor = COLOR_FONT_NOMAL;
//    
//    
//    if (_keyBoardHeight == 0) {
//        _keyBoardHeight = 216;
//    }
//    CGPoint point = [textField convertPoint:CGPointMake(0, 0) toView:self.view];
//    CGFloat tfTail = point.y + textField.frame.size.height;
//    CGFloat tfRTail = tfTail;
//    int offset = APP_HEIGHT - tfRTail - _keyBoardHeight;
//    
//    
//    if (offset < 0) {
//        offset += 20;
//        self.view
//        [_rootScrollView scrollRectToVisible:CGRectMake(0, APP_NAV_HEIGHT + APP_VIEW_Y + offset, _rootScrollView.width, _rootScrollView.height) animated:YES];
//    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
    //textField.textColor = COLOR_FONT_NOMAL;
    
    //[_rootScrollView scrollRectToVisible:CGRectMake(0, 0, _rootScrollView.width, _rootScrollView.height) animated:YES];
    
    if ([textField isEqual:_userNameTF]) {
        textField.tag = TAG_TF_USER_EXIST_NO;
        [self netExistUser:_userNameTF.text];
    }
    if ([textField isEqual:_userNameTF]) {
        if((textField.text.length < 4 || textField.text.length > 20) && ![textField.text isEqualToString:@""]){
            _userNameTF.textColor = [UIColor redColor];
        }else{
            textField.textColor = [UIColor greenColor];
        }
        
    }
    //判断密码位
    if ([textField isEqual:_passwordTF]) {
        if ((textField.text.length < 6 || textField.text.length > 16) && ![textField.text isEqualToString:@""]){
            textField.textColor = [UIColor redColor];
        }else{
            textField.textColor = [UIColor greenColor];
            
        }
    }
    //判断电话号码格式是否正确
    if ([textField isEqual:_phoneNumTF]) {
        if(![_phoneNumTF.text isValidPhoneNum] && ![textField.text isEqualToString:@""]){
            _phoneNumTF.textColor = [UIColor redColor];
        }else{
            _phoneNumTF.textColor = [UIColor greenColor];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark- UIALERT DELEGATE
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == ALERT_REGIST_SUCC) {
        //注册成功逻辑
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
