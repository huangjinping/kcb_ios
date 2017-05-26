//
//  ForgotPasswordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "FindPWTelViewController.h"
#import "ResetUserPWViewController.h"

@interface FindPWTelViewController ()<
UITextFieldDelegate,
ResetUserPWViewControllerDelegate
>
{
    UITextField             *_phoneNumTF;
    
    UITextField             *_yanzhengmaTF;
    UIButton                *_yanzhengButton;
}
@property (nonatomic, retain)  NSString *yanzhengma;
@end

@implementation FindPWTelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y/PX_X_SCALE + 30 width:APP_PX_WIDTH height:FIRST_PAGE_TF_LINE_HEIGHT*2];
    [self.view addSubview:bgImgView];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, FIRST_PAGE_TF_LINE_HEIGHT - 1)];
    [lineL setSize:CGSizeMake(bgImgView.width - 60*PX_X_SCALE, lineL.height)];
    [bgImgView addSubview:lineL];
    
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(40,  FIRST_PAGE_TF_SPACE + 8, 150, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    l.text = @"手机号码";
    [bgImgView addSubview:l];
    _phoneNumTF = [UITextField mainTextFieldWithFrame:LGRectMake(l.r + 40, FIRST_PAGE_TF_SPACE, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) placeholder:@"常用手机号码" tag:0 delegate:self];
    [bgImgView addSubview:_phoneNumTF];
    _phoneNumTF.userInteractionEnabled = NO;
    _phoneNumTF.text = [NSString stringWithFormat:@"%@****%@", [self.phoneNum substringToIndex:3], [self.phoneNum substringFromIndex:7]];
    
    
    _yanzhengmaTF = [UITextField mainTextFieldWithFrame:LGRectMake(40 + 30, FIRST_PAGE_TF_LINE_HEIGHT + (FIRST_PAGE_TF_LINE_HEIGHT - 60)/2, 300, 60) placeholder:@"请输入验证码" tag:0 delegate:self];
    [bgImgView addSubview:_yanzhengmaTF];
    _yanzhengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yanzhengButton setFrame:LGRectMake(bgImgView.w - 30 - 250, _yanzhengmaTF.t, 250, _yanzhengmaTF.h)];
    [_yanzhengButton setBackgroundImage:[[UIImage imageNamed:@"button_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 110, 25, 110)] forState:UIControlStateNormal];
    [_yanzhengButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [_yanzhengButton setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    _yanzhengButton.titleLabel.font = FONT_NOMAL;
    [_yanzhengButton addTarget:self action:@selector(getYanzhengmaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_yanzhengButton];
    
    UIButton *submitButton = [UIButton mainButtonWithPXY:bgImgView.b + 30 title:@"下一步" target:self action:@selector(nextStep)];
    [self.view addSubview:submitButton];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"找回密码"];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)passwordChanged{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}


- (void)nextStep{
    
    [_yanzhengmaTF resignFirstResponder];
    
    if (self.yanzhengma){
        if ([self.yanzhengma isEqualToString:_yanzhengmaTF.text]) {
            //push
            ResetUserPWViewController *rupwVC = [[ResetUserPWViewController alloc] init];
            rupwVC.delegate_ = self;
            rupwVC.needOldPW = NO;
            rupwVC.userName = self.userName;
            [self.navigationController pushViewController:rupwVC animated:YES];
        }else{
            [UIAlertView alertTitle:nil msg:@"验证码有误，请核对后重新填写"];
        }
    }else{
        [UIAlertView alertTitle:nil msg:@"未获取验证码或验证码已失效，请点击<获取短信验证码>按钮，并根据短信提示重新填写验证码"];
    }
    
    
    
}

- (void)getYanzhengmaClicked:(UIButton*)btn{
    
    [self netSendYanzhengma:self.phoneNum];
    
}






#pragma  mark-  网络请求

//- (void)netFindPW{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dict setObject:@"sendmail" forKey:@"action"];
//    [dict setObject:self.userName forKey:@"username"];
//    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
//        
//        [UIAlertView alertTitle:@"提示信息" msg:(NSString*)requestObj];
//        
//    } onError:^(NSString *errorStr) {
//        
//        [UIAlertView alertTitle:@"提示信息" msg:errorStr];
//        
//    }];
//
//}

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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""]) {
        if (textField.text.length > 5) {
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
