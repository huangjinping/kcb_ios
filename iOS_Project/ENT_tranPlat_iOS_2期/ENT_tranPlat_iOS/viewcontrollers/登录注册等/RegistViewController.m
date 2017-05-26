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
    
    UIButton        *_dealButton;
    UIButton            *_yanzhengButton;
    
    CGFloat         _keyBoardHeight;
    
    
    UIImageView *_bgImgView;
}
@property (nonatomic, retain)   NSString        *yanzhengma;
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
    
    _bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y/PX_Y_SCALE + 30 width:APP_PX_WIDTH height:FIRST_PAGE_TF_LINE_HEIGHT*4];
    [self.view addSubview:_bgImgView];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, FIRST_PAGE_TF_LINE_HEIGHT - 1)];
    [lineL setSize:CGSizeMake(_bgImgView.width - 60*PX_X_SCALE, lineL.height)];
    [_bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, FIRST_PAGE_TF_LINE_HEIGHT*2 - 1)];
    [lineL setSize:CGSizeMake(_bgImgView.width - 60*PX_X_SCALE, lineL.height)];
    [_bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, FIRST_PAGE_TF_LINE_HEIGHT*3 - 1)];
    [lineL setSize:CGSizeMake(_bgImgView.width - 60*PX_X_SCALE, lineL.height)];
    [_bgImgView addSubview:lineL];
    
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(40, FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"用户名";
    [_bgImgView addSubview:l];
    _userNameTF = [UITextField mainTextFieldWithFrame:LGRectMake(l.r + 40, FIRST_PAGE_TF_SPACE, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"4-20位字符" tag:TAG_TF_USER_EXIST_NO delegate:self];
    [_bgImgView addSubview:_userNameTF];
    
    l = [[UILabel alloc] initWithFrame:LGRectMake(40, FIRST_PAGE_TF_LINE_HEIGHT + FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"手机号码";
    [_bgImgView addSubview:l];
    _phoneNumTF = [UITextField mainTextFieldWithFrame:LGRectMake(l.r + 40, FIRST_PAGE_TF_SPACE + FIRST_PAGE_TF_LINE_HEIGHT, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"常用手机号码" tag:0 delegate:self];
    [_bgImgView addSubview:_phoneNumTF];

    _yanzhengmaTF = [UITextField mainTextFieldWithFrame:LGRectMake(40 + 30, FIRST_PAGE_TF_LINE_HEIGHT*2 + (FIRST_PAGE_TF_LINE_HEIGHT - 60)/2, 300, 60) placeholder:@"请输入验证码" tag:0 delegate:self];
    [_bgImgView addSubview:_yanzhengmaTF];
    _yanzhengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yanzhengButton setFrame:LGRectMake(_bgImgView.w - 30 - 250, _yanzhengmaTF.t, 250, _yanzhengmaTF.h)];
    [_yanzhengButton setBackgroundImage:[[UIImage imageNamed:@"button_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 110, 25, 110)] forState:UIControlStateNormal];
    [_yanzhengButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [_yanzhengButton setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    _yanzhengButton.titleLabel.font = FONT_NOMAL;
    [_yanzhengButton addTarget:self action:@selector(getYanzhengmaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:_yanzhengButton];

    l = [[UILabel alloc] initWithFrame:LGRectMake(40, FIRST_PAGE_TF_LINE_HEIGHT*3 + FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"密码";
    [_bgImgView addSubview:l];
    _passwordTF = [UITextField mainTextFieldWithFrame:LGRectMake(l.r + 40, FIRST_PAGE_TF_SPACE+ FIRST_PAGE_TF_LINE_HEIGHT*3, FIRST_PAGE_TF_WIDTH - 30 - PW_SHOW_BUTTON_WIDTH - 10, FIRST_PAGE_TF_HEIGHT) placeholder:@"6-16位字符" tag:0 delegate:self];
    [_passwordTF setSecureTextEntry:YES];
    [_bgImgView addSubview:_passwordTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"pw_unshow"] forState:UIControlStateNormal];
    [button setFrame:LGRectMake(_passwordTF.r + 15, _passwordTF.t + 10, PW_SHOW_BUTTON_WIDTH,  PW_SHOW_BUTTON_WIDTH)];
    [button addTarget:self action:@selector(pwShowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = NO;
    [_bgImgView addSubview:button];
    
    
    
    //注册
    UIButton *submitBtn = [UIButton mainButtonWithPXY:_bgImgView.b + 30 title:@"注 册" target:self action:@selector(registUser)];
    [self.view addSubview:submitBtn];

    CGSize size = [@"     我已查阅并同意开车邦《用户使用条款》" sizeWithFont:FONT_NOTICE constrainedToSize:CGSizeMake(1000, 24/PX_X_SCALE)];
    _dealButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dealButton setFrame:LGRectMake((APP_PX_WIDTH - size.width/PX_X_SCALE)/2   , submitBtn.b + 40, 14/PX_X_SCALE, 14/PX_Y_SCALE)];
    [_dealButton setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    [_dealButton addTarget:self action:@selector(dealClicked:) forControlEvents:UIControlEventTouchUpInside];
    _dealButton.selected = NO;
    [self.view addSubview:_dealButton];
    UILabel *dealLabel = [[UILabel alloc] initWithFrame:LGRectMake(_dealButton.r, _dealButton.t, 400, 24)];
    [dealLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [dealLabel setText:@"  我已查阅并同意开车邦"];
    [dealLabel setSize:[dealLabel.text sizeWithFont:dealLabel.font constrainedToSize:CGSizeMake(1000, dealLabel.height)]];
    [self.view addSubview:dealLabel];
    
    
    
    dealLabel = [[UILabel alloc] initWithFrame:LGRectMake(dealLabel.r, dealLabel.t, 400, 24)];
    [dealLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [dealLabel setUserInteractionEnabled:YES];
    [dealLabel setText:@"《用户使用条款》"];
    [dealLabel setSize:[dealLabel.text sizeWithFont:dealLabel.font constrainedToSize:CGSizeMake(1000, dealLabel.height)]];
    [self.view addSubview:dealLabel];
    UITapGestureRecognizer *tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealJSY:)];
    [dealLabel addGestureRecognizer:tapDeal];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.titleLabel.font = FONT_NOMAL;
    [loginButton setTitle:@"我有账号，立即登录" forState:UIControlStateNormal];
    size = [loginButton.titleLabel.text sizeWithFont:loginButton.titleLabel.font constrainedToSize:CGSizeMake(10000, 24)];
    [loginButton setFrame:LGRectMake((APP_PX_WIDTH - size.width/PX_X_SCALE)/2, dealLabel.b + 60, size.width/PX_X_SCALE, 30)];
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}


- (void)keyboardWillHide:(NSNotification*)notify{
    [self.view setFrame:CGRectMake(self.view.left, 0, self.view.width, self.view.height)];
    
    
}
- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyBoardHeight = frame.size.height;
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_userNameTF isFirstResponder]) {
        bottomY = _userNameTF.bottom + _bgImgView.top + space;
    }else if ([_phoneNumTF isFirstResponder]) {
        bottomY = _phoneNumTF.bottom + _bgImgView.top + space;
    }else if ([_yanzhengmaTF isFirstResponder]) {
        bottomY = _yanzhengmaTF.bottom + _bgImgView.top + space;
    }else if ([_passwordTF isFirstResponder]) {
        bottomY = _passwordTF.bottom + _bgImgView.top + space;
    }
    
    CGFloat keyBoardStartY = self.view.frame.size.height - self.view.frame.origin.y - frame.size.height;
    if (keyBoardStartY < bottomY) {
        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottomY - keyBoardStartY), self.view.width, self.view.height)];
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

    
    [self _load_view];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"免费注册"];

}

#pragma mark- button response

- (void)pwShowButtonClicked:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"pw_show"] forState:UIControlStateNormal];
        [_passwordTF resignFirstResponder];
        _passwordTF.secureTextEntry = NO;
        [_passwordTF becomeFirstResponder];
        
    }else{
        [button setImage:[UIImage imageNamed:@"pw_unshow"] forState:UIControlStateNormal];
        [_passwordTF resignFirstResponder];
        _passwordTF.secureTextEntry = YES;
        [_passwordTF becomeFirstResponder];
        _passwordTF.text = _passwordTF.text;
        
    }
}

- (void)getYanzhengmaClicked:(UIButton*)btn{

  //   NSString *username=[NSString stringWithFormat:@"%@",_userNameTF.text];
    
    
    if ([_phoneNumTF.text isValidPhoneNum]) {
        [self netSendYanzhengma:_phoneNumTF.text];
    }else{
        [self.view showAlertText:@"请输入正确的手机号码"];
    }
    
}

- (void)goToLogin{
    [self gobackPage];
}


//注册
- (void)registUser{
    
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_phoneNumTF resignFirstResponder];
    
    if ([self verifyRegistInfo]) {
        if (self.yanzhengma){
            if ([self.yanzhengma isEqualToString:_yanzhengmaTF.text]) {
                [self netRegist];
            }else{
                [UIAlertView alertTitle:nil msg:@"验证码有误，请核对后重新填写"];
            }
        }else{
            [UIAlertView alertTitle:nil msg:@"未获取验证码或验证码已失效，请点击<获取短信验证码>按钮，并根据短信提示重新填写验证码"];
        }
    }
}


- (void)dealClicked:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
        [_dealButton setBackgroundImage:[UIImage imageNamed:@"btn_dealSelected"] forState:UIControlStateNormal];
    }else{
         [_dealButton setBackgroundImage:[UIImage imageNamed:@"btn_deal.png"] forState:UIControlStateNormal];
    }
}

//- (void)tapDealZZFW:(UITapGestureRecognizer*)tap{
//    SelfHelpDealViewController *shdVC = [[SelfHelpDealViewController alloc] init];
//    [self.navigationController pushViewController:shdVC animated:YES];
//}

- (void)tapDealJSY:(UITapGestureRecognizer*)tap{
    DriverServicePlatDealViewController *dspdVC = [[DriverServicePlatDealViewController alloc] init];
    dspdVC.showOtherDeals = YES;
    [self.navigationController pushViewController:dspdVC animated:YES];
}

//- (void)tapDealHDMK:(UITapGestureRecognizer*)tap{
//    RidersInteractionViewController *riVC = [[RidersInteractionViewController alloc] init];
//    [self.navigationController pushViewController:riVC animated:YES];
//}

//校验用户填写的注册信息
- (BOOL)verifyRegistInfo{
    if (!_dealButton.selected) {
        [UIAlertView alertTitle:@"协议勾选" msg:@"如注册，请选择同意开车邦相关协议！"];
        return NO;
    }
    //手机号码
    if ([_phoneNumTF.text isEqualToString:@""] || !_phoneNumTF.text || ![_phoneNumTF.text isValidPhoneNum]) {
        [UIAlertView alertTitle:@"手机号码" msg:@"请您填写正确的手机号码！"];
        return NO;
    }
    //用户名
    
    if ([_userNameTF.text isEqualToString:@""] ||!_userNameTF.text || [_userNameTF.text length] < 4 || [_userNameTF.text length] > 20) {
        [UIAlertView alertTitle:@"用户名" msg:@"请您填写符合规则的用户名(4-20位字符)！"];
        return NO;
    }
    if([_userNameTF.text rangeOfString:@" "].location !=NSNotFound)
    {
        [UIAlertView alertTitle:@"用户名" msg:@"用户名不能有空格"];
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

- (void)netRegist{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"register" forKey:@"action"];
    [dict setObject:_userNameTF.text forKey:@"username"];
    [dict setObject:_passwordTF.text forKey:@"cmspassword"];
    //[dict setObject:_emailAddrTF.text forKey:@"email"];
    [dict setObject:_phoneNumTF.text forKey:@"mobilephone"];
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        NSString *reqStr = (NSString*)requestObj;
        if (postFailed == result) {
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


- (void)netExistUser:(NSString*)user{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"checkuser", @"action", user, @"usernmae", nil];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"yetapi.956122.com"];
    MKNetworkOperation *op = [en operationWithPath:@"user.do" params:dict httpMethod:@"POST"];

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

- (void)invalideYanzhengma{
    self.yanzhengma = nil;
    _yanzhengButton.userInteractionEnabled = YES;
    [_yanzhengButton setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
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
                
                
                NSString *shortmessage = [NSString stringWithString:[resDict analysisStrValueByKey:@"shortmessage"]];
                self.yanzhengma = shortmessage;
                _yanzhengButton.userInteractionEnabled = NO;
                [_yanzhengButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];
                [self performSelector:@selector(invalideYanzhengma) withObject:nil afterDelay:60*3.0f];
                
                [UIAlertView alertTitle:nil msg:@"验证码发送成功，请注意查收短信"];
                
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
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_userNameTF isFirstResponder]) {
        bottomY = _userNameTF.bottom + _bgImgView.top + space;
    }else if ([_phoneNumTF isFirstResponder]) {
        bottomY = _phoneNumTF.bottom + _bgImgView.top + space;
    }else if ([_yanzhengmaTF isFirstResponder]) {
        bottomY = _yanzhengmaTF.bottom + _bgImgView.top + space;
    }else if ([_passwordTF isFirstResponder]) {
        bottomY = _passwordTF.bottom + _bgImgView.top + space;
    }
    
    CGFloat keyBoardStartY = self.view.frame.size.height - self.view.frame.origin.y - _keyBoardHeight;
    if (keyBoardStartY < bottomY) {
        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottomY - keyBoardStartY), self.view.width, self.view.height)];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
    
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
    if ([textField isEqual:_userNameTF]){
        [_phoneNumTF becomeFirstResponder];
    }else if ([textField isEqual:_phoneNumTF]){
        [_yanzhengmaTF becomeFirstResponder];
    }else if ([textField isEqual:_yanzhengmaTF]){
        [_passwordTF becomeFirstResponder];
    }
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
