//
//  ResetUserAddrViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/4.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ResetUserAddrViewController.h"

@interface ResetUserAddrViewController ()<
UITextFieldDelegate,
UIAlertViewDelegate
>
{
    UITextField     *_addrTF;
    UITextField     *_postCodeTF;
}
@end

@implementation ResetUserAddrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat singleLineHeight = 30 *3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y + 30 width:APP_PX_WIDTH height:singleLineHeight*2];
    [self.view addSubview:bgImgView];
    UILabel *bottomL = [[UILabel alloc] initWithFrame:LGRectMake(30, bgImgView.b, APP_PX_WIDTH - 30*2, 100)];
    bottomL.numberOfLines = 0;
    [bottomL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    bottomL.text = @"通讯地址将作为交管邮寄交通处罚决定书地址，请务必填写您的有效地址。";
    [self.view addSubview:bottomL];
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 140, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"详细地址";
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, label.height)];
    [label setSize:size];
    [bgImgView addSubview:label];
    _addrTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, bgImgView.w - (label.r + 30) - 30, 40) placeholder:@"请填写详细地址" tag:0 delegate:self];
    _addrTF.textAlignment = NSTextAlignmentLeft;
    [bgImgView addSubview:_addrTF];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeight + 30, 140, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"邮编";
    [label setSize:size];
    [bgImgView addSubview:label];
    _postCodeTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, bgImgView.w - (label.r + 30) - 30, 40) placeholder:@"请填写邮编" tag:0 delegate:self];
    _postCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _postCodeTF.textAlignment = NSTextAlignmentLeft;
    [bgImgView addSubview:_postCodeTF];
    
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeight - 1)];
    [bgImgView addSubview:lineL];
    
    
    NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    UserInfo *user = [arr lastObject];
    if (![user.postCode isEqualToString:@""]) {
        _postCodeTF.text = user.postCode;
    }
    if (![user.addr isEqualToString:@""]) {
         _addrTF.text = user.addr;
    }
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"修改通讯地址"];
    
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


- (void)saveButtonClicked{
    [_postCodeTF resignFirstResponder];
    [_addrTF resignFirstResponder];
    if ([self keepAndRuleCommitText]){
        [self netUpdateUserInfoToServer];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_postCodeTF]) {
        if (![string isEqualToString:@""]) {
            if ([textField.text length] > 5) {
                return NO;
            }
        }

    }
    return YES;
}



- (BOOL)keepAndRuleCommitText{
    if (_postCodeTF.text.length < 6){
        [UIAlertView alertTitle:@"格式错误" msg:@"邮编格式为6位"];
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
    [dict setObject:user.realName forKey:@"realname"];
    [dict setObject:user.email forKey:@"email"];
    [dict setObject:user.contactNum forKey:@"mobilephone"];
    [dict setObject:_addrTF.text forKey:@"address"];
    [dict setObject:_postCodeTF.text forKey:@"postcode"];
    [dict setObject:user.photoServerPath forKey:@"photo"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            NSDictionary *userInfoDict = (NSDictionary*)callBackObj;
            
            //将修改后的信息保存到数据库中
            NSArray *arr = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
            UserInfo *user = [arr lastObject];
            user.postCode =  [userInfoDict analysisStrValueByKey:@"postcode"];
            user.addr =  [userInfoDict analysisStrValueByKey:@"address"];

            //更新数据库
            [user update];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:@"更新用户地址、邮编失败,服务器异常！"];
        }
        
        
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[@"更新用户地址、邮编失败!" stringByAppendingString:errorStr]];
        
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
