

//
//  RegisterNextViewController.m
//  Merchant
//
//  Created by xinpenghe on 15/12/22.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "RegisterViewController.h"
#import "ReadSecondView.h"

@interface RegisterNextViewController ()

@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@""];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn addTarget:self action:@selector(nextRegister)];
    [nextBtn addBorderWithWidth:1 color:[UIColor lightGrayColor] corner:8];
    nextBtn.frame = LGRectMake(0, 0, 56, 24);
    nextBtn.titleLabel.font = SYS_FONT_SIZE(15);
    [nextBtn setTitle:@"下一步"];
    [nextBtn setTitleColor:[UIColor lightGrayColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    
    UITextField *cellPhoneFiled = [[UITextField alloc]initWithFrame:LGRectMake(0, 28, self.view.width/PX_X_SCALE, 30)];

    [cellPhoneFiled addBorderWithWidth:.5f color:[UIColor colorWithHex:0x333333] corner:10];
    UIView *spaceView = [[UIView alloc]initWithFrame:LGRectMake(0, 0, 10, 30)];
    cellPhoneFiled.leftView = spaceView;
    cellPhoneFiled.leftViewMode = UITextFieldViewModeAlways;
    cellPhoneFiled.placeholder = @"手机号注册";
    cellPhoneFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cellPhoneFiled];
    
    UITextField *yanzhengmaFiled = [[UITextField alloc]initWithFrame:LGRectMake(0, cellPhoneFiled.bottom/PX_X_SCALE+15, cellPhoneFiled.width/PX_X_SCALE, 30)];
    yanzhengmaFiled.placeholder = @"输入验证码";
    [yanzhengmaFiled addBorderWithWidth:.5f color:[UIColor colorWithHex:0x333333] corner:10];
    UIView *spaceView1 = [[UIView alloc]initWithFrame:LGRectMake(0, 0, 10, 30)];
    yanzhengmaFiled.leftView = spaceView1;
    yanzhengmaFiled.leftViewMode = UITextFieldViewModeAlways;
    yanzhengmaFiled.placeholder = @"输入验证码";
    yanzhengmaFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yanzhengmaFiled];
    
    ReadSecondView *secV = [[ReadSecondView alloc]initWithFrame:CGRectMake(0, yanzhengmaFiled.bottom+15*PX_X_SCALE, self.view.width, 30*PX_Y_SCALE)];
    secV.commplete = ^{
        
    };
    [secV addBorderWithWidth:1 color:[UIColor colorWithHex:0x333333] corner:10];
    [self.view addSubview:secV];
}

#pragma mark - event method

- (void)nextRegister{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}


@end
