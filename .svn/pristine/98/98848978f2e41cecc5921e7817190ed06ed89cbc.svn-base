//
//  FindPWViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/7.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "FindPWViewController.h"
#import "FindPWTelViewController.h"


@interface FindPWViewController ()
{
     UITextField             *_userNameTF;
}
@end

@implementation FindPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y/PX_X_SCALE + 30 width:APP_PX_WIDTH height:FIRST_PAGE_TF_LINE_HEIGHT];
    [self.view addSubview:bgImgView];
    
    
//    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(40, FIRST_PAGE_TF_SPACE + 8, 150, 30)];
//    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
//    l.text = @"用户名";
//    [bgImgView addSubview:l];
    _userNameTF = [UITextField mainTextFieldWithFrame:LGRectMake(30, FIRST_PAGE_TF_SPACE, APP_PX_WIDTH - 30*2, FIRST_PAGE_TF_HEIGHT) placeholder:@"请输入用户名" tag:0 delegate:self];
    [bgImgView addSubview:_userNameTF];
    
    UIButton *nextStepButton = [UIButton mainButtonWithPXY:bgImgView.b + 30 title:@"下一步" target:self action:@selector(nextStepClicked)];
    [self.view addSubview:nextStepButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"找回密码"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)nextStepClicked{
    [_userNameTF resignFirstResponder];
    if (_userNameTF.text.length > 0) {
        [self netExistUser:_userNameTF.text];
    }else{
        [UIAlertView alertTitle:nil msg:@"请输入用户名"];
    }
}


- (void)netExistUser:(NSString*)user{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"checkuser", @"action", user, @"username", nil];
    NSString *urlstr = @"yetapi.956122.com";
    if (ENT_DEBUG) {
        urlstr = @"new.956122.com";
    }

    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:urlstr];
    MKNetworkOperation *op = [en operationWithPath:@"andriod.do" params:dict httpMethod:@"POST"];
    ENTLog(@"\n网络请求地址：%@",op.url);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //请求成功
        NSString *responseStr = completedOperation.responseString;
        ENTLog(@"\n连接服务器成功，返回字符串：%@",responseStr);

        NSArray *responseArr = [responseStr componentsSeparatedByString:@","];
        if ([responseArr count] == 3) {
            NSString *result = [responseArr objectAtIndex:0];
            NSString *telNum = [responseArr objectAtIndex:1];
            //NSString *email = [responseArr objectAtIndex:2];
            if ([result isEqualToString:@"0"]) {//不存在
                [UIAlertView alertTitle:@"" msg:@"用户名不存在!"];
                
            }else if ([result isEqualToString:@"1"]){//存在
                if (telNum.length > 0){//返回有手机号

                    FindPWTelViewController *fpwt = [[FindPWTelViewController alloc] init];
                    fpwt.phoneNum = telNum;
                    fpwt.userName = _userNameTF.text;
                    [self.navigationController pushViewController:fpwt animated:YES];
                    
                }else{
                    [UIAlertView alertTitle:nil msg:@"当前用户尚未绑定手机，请到开车邦网站www.956122.com根据邮箱找回密码"];
                }
                
                
            }else{//异常
                [UIAlertView alertTitle:@"" msg:@"服务器返回异常，请稍后重试!"];
            }
        }else if ([responseStr isEqualToString:@"0"]){
             [UIAlertView alertTitle:@"" msg:@"用户名不存在!"];
        }else{
            [UIAlertView alertTitle:@"" msg:@"服务器返回异常，请稍后重试!"];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //请求失败
        NSString *errorStr = [NSString stringWithFormat:@"error%@", error];
        ENTLog(@"%@", [NSString stringWithFormat:@"连接服务器失败，错误信息%@,服务器返回：%@", errorStr, completedOperation.responseString]);
        [UIAlertView alertTitle:@"" msg:errorStr];

        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
    
    [en enqueueOperation:op];
    
    
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
