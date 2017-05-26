//
//  LoginViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RegistViewController.h"
#import "FindPWViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
//#import <TencentOpenAPI/TencentOAuth.h>
#import <CoreLocation/CoreLocation.h>

@interface LoginViewController ()
<
UITextFieldDelegate,
//TencentSessionDelegate,
CLLocationManagerDelegate
>
{
    UITextField      *_userNameTF;
    UITextField      *_passwordTF;
    
    //TencentOAuth        *_tencentOAuth;
    NSMutableArray      *_permissions;
    
}

//定位管理器
//@property (nonatomic, strong) CLLocationManager       * locationManager;

//地理编码
//@property (nonatomic, strong) CLGeocoder               *geocoder;


@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)gobackPage{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
#if 0
  CGFloat y = 0;
    if (iOS7) {
        y = 20;
    }
    CGRect frame = CGRectMake(APP_X, y, APP_WIDTH, APP_NAV_HEIGHT);
    UIImageView *navigationImgView = [[UIImageView alloc] init];
    [navigationImgView setFrame:frame];
    [navigationImgView setBackgroundColor:COLOR_NAV];
    navigationImgView.userInteractionEnabled = YES;
    [self.view addSubview:navigationImgView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(8, 8, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"go_back.png"] forState:UIControlStateNormal];
    
    //[backButton setTitle:@"取消" forState:UIControlStateNormal];
    //[backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[backButton setBackgroundColor:[UIColor clearColor]];
    [backButton addTarget:self action:@selector(gobackPage) forControlEvents:UIControlEventTouchUpInside];
    [navigationImgView addSubview:backButton];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_X, 5, APP_WIDTH, APP_NAV_HEIGHT - 10)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = SYS_FONT_SIZE(40);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"登 录";
    [navigationImgView addSubview:titleLabel];
#endif
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:LGRectMake((APP_PX_WIDTH - 315)/2, APP_VIEW_Y/PX_X_SCALE + 60, 315, 128)];
    [logoImgView setImage:[UIImage imageNamed:@"login_logo.png"]];
    [self.view addSubview:logoImgView];
    
    UIImageView *textfBgImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, logoImgView.b + 40, 580, 180)];
    [textfBgImgView setImage:[UIImage imageNamed:@"login_bg.png"]];
    [textfBgImgView setUserInteractionEnabled:YES];
    [self.view addSubview:textfBgImgView];
    
    
    CGFloat space = (180/2-FIRST_PAGE_TF_HEIGHT)/2;
    _userNameTF = [UITextField mainTextFieldWithFrame:LGRectMake(130, space, textfBgImgView.w - 100 - 30, FIRST_PAGE_TF_HEIGHT) placeholder:@"用户名或手机号" tag:0 delegate:self];
    [textfBgImgView addSubview:_userNameTF];
    
    
    
    _passwordTF = [UITextField mainTextFieldWithFrame:LGRectMake(_userNameTF.l, _userNameTF.b + space*1.8, _userNameTF.w - 30 - PW_SHOW_BUTTON_WIDTH - 10, FIRST_PAGE_TF_HEIGHT) placeholder:@"登录密码" tag:0 delegate:self];
    [_passwordTF setSecureTextEntry:YES];
    [textfBgImgView addSubview:_passwordTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"pw_unshow"] forState:UIControlStateNormal];
    [button setFrame:LGRectMake(_passwordTF.r + 15, _passwordTF.t + 10, PW_SHOW_BUTTON_WIDTH, PW_SHOW_BUTTON_WIDTH)];
    [button addTarget:self action:@selector(pwShowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = NO;
    [textfBgImgView addSubview:button];
    
//    _userNameTF.backgroundColor = [UIColor blueColor];
//    _passwordTF.backgroundColor = [UIColor yellowColor];
    
    UIButton *loginButton = [UIButton mainButtonWithPXY:textfBgImgView.b + 30 title:@"登 录" target:self action:@selector(login:)];
    [self.view addSubview:loginButton];

    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotPasswordButton.titleLabel.font = FONT_NOTICE;
    [forgotPasswordButton setTitle:@"忘记登录密码?" forState:UIControlStateNormal];
    CGSize s = [forgotPasswordButton.titleLabel.text sizeWithFont:forgotPasswordButton.titleLabel.font constrainedToSize:CGSizeMake(10000, 24)];
    [forgotPasswordButton setFrame:LGRectMake((APP_PX_WIDTH - s.width/PX_X_SCALE)/2, loginButton.b + 40, s.width/PX_X_SCALE, 24)];
    [forgotPasswordButton setBackgroundColor:[UIColor clearColor]];
    [forgotPasswordButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(findPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.titleLabel.font = FONT_NOMAL;
    [registButton setTitle:@"还没有账号，免费开通" forState:UIControlStateNormal];
    s = [registButton.titleLabel.text sizeWithFont:registButton.titleLabel.font constrainedToSize:CGSizeMake(10000, 24)];
    [registButton setFrame:LGRectMake((APP_PX_WIDTH - s.width/PX_X_SCALE)/2, forgotPasswordButton.b + 60, s.width/PX_X_SCALE, 30)];
    [registButton setBackgroundColor:[UIColor clearColor]];
    [registButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(goToRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"账户登录"];
    //[self setBackButtonHidden:YES];

    NSArray *arr = [[DataBase sharedDataBase] selectActiveUser];
    if ([arr count]) {
        UserInfo *user = [arr lastObject];
        _userNameTF.text = user.userName;
    }
    _passwordTF.text = @"";
}


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


#if user_other_login_way
- (void)loginWechat:(UIButton*)button{

    SendAuthReq* req = [[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"ENT_TENCENT_20141111" ;
    [WXApi sendReq:req];
}

- (void)loginTencent:(UIButton*)button{
    
    [TencentOAuth iphoneQQInstalled];
    
    /*
     
     iphoneQQSupportSSOLogin
     iphoneQZoneInstalled
     iphoneQZoneSupportSSOLogin
     
     */
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1101345283" andDelegate:self];
    _permissions =  [NSMutableArray arrayWithObjects:kOPEN_PERMISSION_GET_VIP_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    
    [_tencentOAuth authorize:_permissions inSafari:YES];
}

#pragma mark- tencent delegate
- (void)tencentDidLogin
{
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        //记录登录用户的OpenID、Token以及过期时间
        _tencentOAuth.accessToken;
        _tencentOAuth.expirationDate;
        _tencentOAuth.openId;
        _tencentOAuth.localAppId;
        
        ENTLog(@"tencent 登录成功！");
        if ([_tencentOAuth getUserInfo]){
        
        }
    }
    else
    {
        //登录不成功 没有获取accesstoken
        ENTLog(@"tencent 登录不成功 没有获取accesstoken！")

    }
}
//非网络错误导致登录失败
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        //用户取消登录
        ENTLog(@"tencent 用户取消登录！")
    }
    else
    {
        //登录失败
        ENTLog(@"tencent 登录失败！")

    }
}

//网络错误导致登录失败
-(void)tencentDidNotNetWork
{
    //无网络连接，请设置网络
    ENTLog(@"tencent 登录失败！无网络连接，请设置网络")
}

- (void)getUserInfoResponse:(APIResponse *)response{
    if (response.retCode == URLREQUEST_SUCCEED) {
        
        NSDictionary *userInfoDict = response.jsonResponse;
        [userInfoDict objectForKey:@"city"];//城市
        [userInfoDict objectForKey:@"figureurl_qq_2"];//qq 100*100头像
        [userInfoDict objectForKey:@"gender"];//性别
        [userInfoDict objectForKey:@"nickname"];
        [userInfoDict objectForKey:@"province"];
        [userInfoDict objectForKey:@"year"];//生日年

    }else{
        
        [self.view showAlertText:response.errorMsg];
        
    }
}
#endif

- (BOOL)verifyLoginInfo{
    //验证不为空
    
    if ([_userNameTF.text isEqualToString:@""] || !_userNameTF.text) {
        [UIAlertView alertTitle:@"用户名" msg:@"请输入用户名"];
        return NO;
    }
    if ([_passwordTF.text isEqualToString:@""] || !_passwordTF.text) {
        [UIAlertView alertTitle:@"密码" msg:@"请输入密码"];
        return NO;
    }
    return YES;
}




#pragma mark- 网络请求

- (void)login:(id)sender{
    
    [_passwordTF resignFirstResponder];
    [_userNameTF resignFirstResponder];
    if ([self verifyLoginInfo]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dict setObject:@"alogin" forKey:@"action"];
        [dict setObject:_userNameTF.text forKey:@"username"];
        [dict setObject:_passwordTF.text forKey:@"password"];
        [UITools showIndicatorToView:self.view];
        [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            [UITools hideHUDForView:self.view];
            NSDictionary *resDict = (NSDictionary*)requestObj;
            if (result == postSucc) {
                
                
                
                NSString *conResult = [resDict objectForKey:@"result"];
                if ([conResult isEqualToString:@"success"]) {
                    
                    //登录成功
                    APP_DELEGATE.loginSuss = YES;
                    APP_DELEGATE.userName = _userNameTF.text;
                    APP_DELEGATE.realName = resDict[@"realname"];
                    NSArray *users = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
                    if ([users count]) {
                        APP_DELEGATE.userId = ((UserInfo*)[users lastObject]).userId;
                    }else{
                        APP_DELEGATE.userId = [_userNameTF.text userIdString];
                    }
                    
                    NSLog(@"resDict:%@",resDict);
                   // dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        //写入数据库
                        UserInfo *user = [Helper loginAnalysisUser:resDict withUserId:APP_DELEGATE.userId userName:APP_DELEGATE.userName andPassword:_passwordTF.text];
                        [user update];
                      //  NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
                        //[center postNotificationName:@"zhuanshu" object:self userInfo:nil];
                        
                        NSArray *drivers = [Helper loginAnalysisDriver:resDict withUserId:APP_DELEGATE.userId];
                        [drivers updateDriversAfterLogin];
                        
                        NSArray *cars = [Helper loginAnalysisCarInfo:resDict withUserId:APP_DELEGATE.userId];
                        [cars updateCarsAfterLogin];
                        
                        [NETHelper asynchronousDownloadPhotoImage];
                       
                    //});

//                    //跳转主页
//                    //修改处---》标签控制器
//                    TabBarViewController *tabVC = [[TabBarViewController alloc] init];
////                  HomeViewController *homeVC = [[HomeViewController alloc] init];
//                    [self.navigationController pushViewController:tabVC animated:YES];
                    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
                    [center postNotificationName:@"zhuanshu" object:self userInfo:nil];

                    [self gobackPage];
                    
                    [self requestCount];
                }else if ([conResult isEqualToString:@"fail"]){
                    NSString *reason = [resDict objectForKey:@"reason"];
                    if ([reason isEqualToString:@"password not right"]) {
                        reason = @"密码不正确";
                    }
                    if ([reason isEqualToString:@"user not existed"]) {
                        reason = @"用户不存在";
                    }
                    [UIAlertView alertTitle:@"登录失败" msg:reason];
                }
                
            }else{
                [UIAlertView alertTitle:@"登录失败" msg:(NSString*)requestObj];
            }

        } onError:^(NSString *errorStr) {
            [UIAlertView alertTitle:@"登录失败" msg:errorStr];
            [UITools hideHUDForView:self.view];
        }];
    }
}



- (void)findPassword:(id)sender{
    FindPWViewController *fpwVC = [[FindPWViewController alloc] init];
    [self.navigationController pushViewController:fpwVC animated:YES];
}
//注册新用户
- (void)goToRegist:(id)sender{

    RegistViewController    *regisVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:regisVC animated:YES];
    
}

- (void)requestCount{
    [[NetworkEngine sharedNetwork] postBody:@{@"account":APP_DELEGATE.userName} apiPath:kOrderCount hasHeader:YES finish:^(ResultState state, id resObj) {
        if (state == StateSucceed) {
            NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
            
            [u setObject:resObj[@"body"][0][@"noPaySum"] forKey:WATTINGFORPAY];
            [u setObject:resObj[@"body"][0][@"noServiceSum"] forKey:WATTINGFORSERVICE];
            [u setObject:resObj[@"body"][0][@"noEvaluationSum"] forKey:WATTINGFORCOMMNET];
            [u setObject:resObj[@"body"][0][@"backSum"] forKey:WATTINGFORREFOUND];
            
            [u synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderCount object:nil];
        }
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark- UI DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
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
