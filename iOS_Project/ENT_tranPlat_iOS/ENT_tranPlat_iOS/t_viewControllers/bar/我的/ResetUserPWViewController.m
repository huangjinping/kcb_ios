//
//  ResetUserPWViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/4.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ResetUserPWViewController.h"

@interface ResetUserPWViewController ()<
UITextFieldDelegate,
UIAlertViewDelegate
>

{
    UITextField         *_oldPWTF;
    UITextField         *_newPWTF;
    UITextField         *_repeatNewPWTF;
}
@end

@implementation ResetUserPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat singleLineHeight = 30 *3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y + 30 width:APP_PX_WIDTH height:singleLineHeight*3];
    [self.view addSubview:bgImgView];
    UILabel *bottomL = [[UILabel alloc] initWithFrame:YYRectMake(30, bgImgView.b, APP_PX_WIDTH - 30*2, 100)];
    bottomL.numberOfLines = 0;
    [bottomL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    bottomL.text = @"为确保您的账户安全，建议您定期修改密码。";
    [self.view addSubview:bottomL];
    
    UILabel *label = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 140, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"原密码";
    CGSize size = [@"再次输入" sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, label.height)];
    [label setSize:size];
    [bgImgView addSubview:label];
    _oldPWTF = [UITextField mainTextFieldWithFrame:YYRectMake(label.r + 30, label.t, bgImgView.w - (label.r + 30) - 30, 40) placeholder:@"原登录密码" tag:0 delegate:self];
    _oldPWTF.textAlignment = NSTextAlignmentLeft;
    _oldPWTF.secureTextEntry = YES;
    [bgImgView addSubview:_oldPWTF];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeight + 30, 140, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"新密码";
    [label setSize:size];
    [bgImgView addSubview:label];
    _newPWTF = [UITextField mainTextFieldWithFrame:YYRectMake(label.r + 30, label.t, bgImgView.w - (label.r + 30) - 30, 40) placeholder:@"填写新登录密码(6-16位字符)" tag:0 delegate:self];
    _newPWTF.textAlignment = NSTextAlignmentLeft;
    _newPWTF.secureTextEntry = YES;
    [bgImgView addSubview:_newPWTF];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, singleLineHeight*2 + 30, 140, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"再次输入";
    [label setSize:size];
    [bgImgView addSubview:label];
    _repeatNewPWTF = [UITextField mainTextFieldWithFrame:YYRectMake(label.r + 30, label.t, bgImgView.w - (label.r + 30) - 30, 40) placeholder:@"再次填写确认" tag:0 delegate:self];
    _repeatNewPWTF.textAlignment = NSTextAlignmentLeft;
    _repeatNewPWTF.secureTextEntry = YES;
    [bgImgView addSubview:_repeatNewPWTF];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight - 1)];
    [bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight*2 - 1)];
    [bgImgView addSubview:lineL];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"密码修改"];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor clearColor]];
    [saveButton.titleLabel setFont:FONT_NOMAL];
    [saveButton setFrame:YYRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 60, 30)];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:saveButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)saveButtonClicked{
    [_oldPWTF resignFirstResponder];
    [_newPWTF resignFirstResponder];
    [_repeatNewPWTF resignFirstResponder];
    if ([self keepAndRuleCommitText]) {
        [self netUpdatePWToServer];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""]) {
        if ([textField.text length] > 15) {
            return NO;
        }
    }
        
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
   // [textField setTextColor:COLOR_FONT_NOMAL];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if ([textField isEqual:_oldPWTF]) {
//        UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
//        if ([_oldPWTF.text isEqualToString:user.password]) {
//            _oldPWTF.textColor = [UIColor greenColor];
//        }else{
//            _oldPWTF.textColor = [UIColor redColor];
//        }
//    }
}

- (BOOL)keepAndRuleCommitText{
//    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
//    if (![_oldPWTF.text isEqualToString:user.password]) {
//        [UIAlertView alertTitle:nil msg:@"原密码填写有误！"];
//        return NO;
//    }
    if ([_newPWTF.text isEqualToString:@""] || !_newPWTF.text || [_newPWTF.text length] < 6 || [_newPWTF.text length] > 16) {
        [UIAlertView alertTitle:nil msg:@"请您设置符合规则的密码(6-16位字符)！"];
        return NO;
    }
    if (![_newPWTF.text isEqualToString:_repeatNewPWTF.text]) {
        [UIAlertView alertTitle:nil msg:@"两次密码输入不一致！"];
        return NO;

    }
    return YES;
}

#pragma mark-   网络请求
- (void)netUpdatePWToServer{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"updatepassword" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    [dict setObject:_oldPWTF.text forKey:@"oldpassword"];
    [dict setObject:_newPWTF.text forKey:@"cmspassword"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
            user.password = _newPWTF.text;
            //更新数据库
            [user update];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"修改密码成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            [UIAlertView alertTitle:nil msg:[NSString stringWithFormat:@"修改密码失败，%@",requestObj]];
        }
        
        
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:nil msg:[NSString stringWithFormat:@"修改密码失败，%@",errorStr]];
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.delegate_ respondsToSelector:@selector(passwordChanged)]) {
        [self.delegate_ passwordChanged];
    }
    
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
