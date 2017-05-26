//
//  ResetUserTelViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/4.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ResetUserTelViewController.h"

@interface ResetUserTelViewController ()<
UITextFieldDelegate,
UIAlertViewDelegate
>
{
    UITextField         *_newTelTF;
    UITextField         *_yanzhengmaTF;
    
    UIButton            *_yanzhengButton;
}

@property (nonatomic, retain)   NSString    *yanzhengma;
@end

@implementation ResetUserTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.yanzhengma = nil;
    
    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];

    CGFloat singleLineHeight = 30*3;
    UILabel *topL = [[UILabel alloc] initWithFrame:LGRectMake(30, APP_VIEW_Y/PX_X_SCALE + 30, APP_PX_WIDTH - 30*2, 30)];
    [topL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    NSString *tel = @"";
    if (user.contactNum.length < 4) {
        tel = user.contactNum;
    }else{
        tel = [user.contactNum substringToIndex:3];
        tel = [tel stringByAppendingString:@"****"];
        if (user.contactNum.length == 11) {
            tel = [tel stringByAppendingString:[user.contactNum substringFromIndex:7]];
        }
    }
    topL.text = [NSString stringWithFormat:@"当前绑定的手机号为：%@", tel];
    [self.view addSubview:topL];

    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:topL.b + 10 width:APP_PX_WIDTH height:singleLineHeight*2];
    [self.view addSubview:bgImgView];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight - 1)];
    [bgImgView addSubview:lineL];
    
    UILabel *bottomL = [[UILabel alloc] initWithFrame:LGRectMake(30, bgImgView.b, APP_PX_WIDTH - 30*2, 100)];
    bottomL.numberOfLines = 0;
    [bottomL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    bottomL.text = @"";
    [self.view addSubview:bottomL];
    
    //新号码
    _newTelTF = [UITextField mainTextFieldWithFrame:LGRectMake(30, 30, APP_PX_WIDTH - 30*3, 40) placeholder:@"新手机号码" tag:0 delegate:self];
    _newTelTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgImgView addSubview:_newTelTF];
    if (![user.contactNum isEqualToString:@""]) {
        _newTelTF.text = user.contactNum;
    }
    
    _yanzhengmaTF = [UITextField mainTextFieldWithFrame:LGRectMake(30, singleLineHeight + 30, 300, 40) placeholder:@"请输入验证码" tag:0 delegate:self];
    _yanzhengmaTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgImgView addSubview:_yanzhengmaTF];
    _yanzhengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yanzhengButton setFrame:LGRectMake(bgImgView.w - 30 - 250, singleLineHeight + 15, 250, singleLineHeight - 15*2)];
    [_yanzhengButton setBackgroundImage:[[UIImage imageNamed:@"button_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 110, 25, 110)] forState:UIControlStateNormal];
    [_yanzhengButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [_yanzhengButton setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    _yanzhengButton.titleLabel.font = FONT_NOMAL;
    [_yanzhengButton addTarget:self action:@selector(yanzhengmaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_yanzhengButton];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"更换手机"];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor clearColor]];
    [saveButton.titleLabel setFont:FONT_NOMAL];
    [saveButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 60, 30)];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:saveButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)yanzhengmaButtonClicked{
    if ([_newTelTF.text isValidPhoneNum]) {
        [self netSendYanzhengma];
    }else{
        [UIAlertView alertTitle:@"" msg:@"请填写正确的手机号码"];
    }
}

- (void)saveButtonClicked{
    [_yanzhengmaTF resignFirstResponder];
    [_newTelTF resignFirstResponder];
    if ([_yanzhengmaTF.text isEqualToString:@""] || !_yanzhengmaTF.text) {
        [UIAlertView alertTitle:nil msg:@"请填写验证码"];
        return;
    }
    //验证验证码
    if (self.yanzhengma) {
        if ([_yanzhengmaTF.text isEqualToString:self.yanzhengma]) {
            [self netUpdateUserInfoToServer];
        }else{
            [UIAlertView alertTitle:nil msg:@"验证码有误，请核对后重新填写"];
        }
    }else{
        [UIAlertView alertTitle:nil msg:@"未获取验证码或验证码已失效，请点击<获取短信验证码>按钮，并根据短信提示重新填写验证码"];
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_yanzhengmaTF]) {
        if (![string isEqualToString:@""]) {
            if (textField.text.length > 5) {
                return NO;
            }
        }
    }else{
        if (![string isEqualToString:@""]) {
            if (textField.text.length > 10) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_newTelTF]) {
        _newTelTF.textColor = COLOR_FONT_NOMAL;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_newTelTF]) {
        if ([_newTelTF.text isValidPhoneNum]) {
            _newTelTF.textColor = [UIColor greenColor];
        }else{
            _newTelTF.textColor = [UIColor redColor];
        }
    }
}

- (void)invalideYanzhengma{
    self.yanzhengma = nil;
    _yanzhengButton.userInteractionEnabled = YES;
    [_yanzhengButton setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
}

#pragma mark- 网络请求
- (void)netSendYanzhengma{

    //成功后，self.yanzhengma赋值，并开始计时3分钟后，self.yanzhengma置空
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"sendverifymes" forKey:@"action"];
    [dict setObject:_newTelTF.text forKey:@"mobile"];//pr.956122.com/user.do?aciton=sendverifymes
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postFailed) {
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

- (void)netUpdateUserInfoToServer{
    
    NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    UserInfo *user = [arr lastObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"updateuser" forKey:@"action"];
    [dict setObject:user.userName forKey:@"username"];
    [dict setObject:user.realName forKey:@"realname"];
    [dict setObject:user.email forKey:@"email"];
    [dict setObject:_newTelTF.text forKey:@"mobilephone"];
    [dict setObject:user.addr forKey:@"address"];
    [dict setObject:user.postCode forKey:@"postcode"];
    [dict setObject:user.photoServerPath forKey:@"photo"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            NSDictionary *userInfoDict = (NSDictionary*)callBackObj;
            
            //将修改后的信息保存到数据库中
            NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
            UserInfo *user = [arr lastObject];
            user.contactNum =  [userInfoDict analysisStrValueByKey:@"mobilephone"];
            
            //更新数据库
            [user update];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:@"更新用户手机号码失败,服务器异常！"];
        }
        
        
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[@"更新用户手机号码失败!" stringByAppendingString:errorStr]];
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self gobackPage];
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
