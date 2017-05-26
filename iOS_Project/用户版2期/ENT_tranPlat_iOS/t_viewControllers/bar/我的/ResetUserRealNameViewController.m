//
//  ResetUserInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ResetUserRealNameViewController.h"

@interface ResetUserRealNameViewController ()<
UITextFieldDelegate,
UIAlertViewDelegate
>
{
    UITextField                 *_realNameTF;
}
//@property (nonatomic, retain)   UserInfo        *tempUserInfo;
@end



@implementation ResetUserRealNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y/PX_X_SCALE + 30 width:APP_PX_WIDTH height:30*3];
    [self.view addSubview:bgImgView];
    _realNameTF = [UITextField mainTextFieldWithFrame:YYRectMake(30, 30, bgImgView.w - 30*2, 40) placeholder:@"请输入真实姓名" tag:0 delegate:self];
    [bgImgView addSubview:_realNameTF];
    
    NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    UserInfo *user = [arr lastObject];
    if (![user.realName isEqualToString:@""]) {
        _realNameTF.text = user.realName;
    }
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"修改真实姓名"];
    
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
    [_realNameTF resignFirstResponder];
    if ([self keepAndRuleCommitText]) {
        [self netUpdateUserInfoToServer];

    }
}
#pragma mark-   textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString:@""]) {
        if (textField.text.length > 19) {
            return NO;
        }
    }
    return YES;
}



- (BOOL)keepAndRuleCommitText{
    
    if ([_realNameTF.text isValidRealname]) {
        
        [UIAlertView alertTitle:@"格式错误" msg:@"请输入正确的姓名"];
        return NO;
        
    }
    return YES;
}

#pragma mark-   网络请求
- (void)netUpdateUserInfoToServer{
    NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    UserInfo *user = [arr lastObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"updateuser" forKey:@"action"];
    [dict setObject:user.userName forKey:@"username"];
    [dict setObject:_realNameTF.text forKey:@"realname"];
    [dict setObject:user.email forKey:@"email"];
    [dict setObject:user.contactNum forKey:@"mobilephone"];
    [dict setObject:user.addr forKey:@"address"];
    [dict setObject:user.postCode forKey:@"postcode"];
    [dict setObject:user.photoServerPath forKey:@"photo"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            NSDictionary *userInfoDict = (NSDictionary*)callBackObj;
            
            //将修改后的信息保存到数据库中
            NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
            UserInfo *user = [arr lastObject];
            user.realName =  [userInfoDict analysisStrValueByKey:@"realname"];
            
            //更新数据库
            [user update];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:@"更新用户真实姓名失败,服务器异常！"];
        }
        
        
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[@"更新用户真实姓名失败!" stringByAppendingString:errorStr]];
        
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
