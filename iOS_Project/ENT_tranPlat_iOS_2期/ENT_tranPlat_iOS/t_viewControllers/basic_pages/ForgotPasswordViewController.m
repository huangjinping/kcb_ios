//
//  ForgotPasswordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

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
    
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, APP_VIEW_Y + 20, APP_WIDTH - 10*2, 150)];
    [bgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [bgImgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgImgView];
    
    UIImageView *tfBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, bgImgView.width - 20*2, 40)];
    [tfBgImgView setImage:[UIImage imageNamed:@"bg_input_textfield"]];
    tfBgImgView.userInteractionEnabled = YES;
//    [bgImgView addSubview:tfBgImgView];
//    
//    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, tfBgImgView.width - 5*2, tfBgImgView.height - 5*2)];
//    _userNameTF.placeholder = @"请输入用户名";
//    _userNameTF.font = [UIFont systemFontOfSize:14];
//    _userNameTF.borderStyle = UITextBorderStyleNone;
//    _userNameTF.delegate = self;
//    [tfBgImgView addSubview:_userNameTF];
   
    _userNameTF = [UITextField registTextFieldWithFrame:CGRectMake(FIRST_PAGE_TF_SPACE, FIRST_PAGE_TF_SPACE, FIRST_PAGE_TF_WIDTH, FIRST_PAGE_TF_HEIGHT) delegate:self];
    [_userNameTF setPlaceholder:@"请输入用户名"];
    [_userNameTF setBackground:[UIImage imageNamed:@"bg_input_textfield"]];
    [bgImgView addSubview:_userNameTF];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(_userNameTF.left, _userNameTF.bottom + 20, _userNameTF.width, FIRST_PAGE_BUTTON_HEIGHT)];
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [submitButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:COLOR_BUTTON_BLUE];
    [bgImgView addSubview:submitButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bgImgView.left + 20, bgImgView.bottom + 20, 122, 20)];
    label.text = @"注意事项提示：";
    label.font = [UIFont italicSystemFontOfSize:16];
    label.textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 10, (APP_WIDTH - label.left*2), 120)];
    label.numberOfLines = 0;
    label.text = @"1、请输入您注册的登录用户名；\n2、点击“找回密码”按钮，系统会自动给您的账户邮箱发送邮件；\n3、提示邮件发送成功后，请登录您的邮箱进行操作；\n4、请确保您的手机能正常访问网络。";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    label.backgroundColor = [UIColor clearColor];
    [label fitSpace:5];
    [self.view addSubview:label];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"找回密码"];

}
- (IBAction)submit:(id)sender{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"sendmail" forKey:@"action"];
    [dict setObject:_userNameTF.text forKey:@"username"];
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        [UIAlertView alertTitle:@"提示信息" msg:(NSString*)requestObj];
        
    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"提示信息" msg:errorStr];
        
    }];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
