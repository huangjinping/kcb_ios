//
//  AdviceSetViewController.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-20.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AdviceSetViewController.h"

@interface AdviceSetViewController ()

@end

@implementation AdviceSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    // Do any additional setup after loading the view.
}

- (void)addView{
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, APP_VIEW_Y+10, APP_WIDTH-20, 210)];
    bgImageView.image = [UIImage imageNamed:@"bg_white.png"];
    [self.view addSubview:bgImageView];
    _txView = [[UITextView alloc]initWithFrame:CGRectMake(10, APP_VIEW_Y+10, APP_WIDTH-20, 210)];
    _txView.text = @"请将您宝贵的意见或建议反馈给我们。";
    _txView.textColor = [UIColor lightGrayColor];
    _txView.textAlignment = NSTextAlignmentLeft;
    _txView.font = [UIFont systemFontOfSize:17];
    _txView.delegate = self;
    [self.view addSubview:_txView];
    NSArray *stringArray = [NSArray arrayWithObjects:@"全国服务热线：",@"4000—956122", nil];
    NSArray *colorArray = [NSArray arrayWithObjects:COLOR_FONT_NOMAL,[UIColor orangeColor], nil];
    for (int i = 0 ; i < 2 ; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10+120*i, _txView.frame.origin.y+_txView.frame.size.height+10, 120, 20)];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = [stringArray objectAtIndex:i];
        lable.textColor = [colorArray objectAtIndex:i];
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont systemFontOfSize:17];
        [self.view addSubview:lable];
    }
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(10, _txView.frame.origin.y+_txView.frame.size.height+40, APP_WIDTH-20, 47);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.textColor = [UIColor whiteColor];
    sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [sendBtn setBackgroundColor:COLOR_BUTTON_BLUE];
    [sendBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"意见反馈"];
}
- (BOOL)ruleCommitText{
    if ([_txView.text isEqualToString:@"请将您宝贵的意见或建议反馈给我们。"] || !_txView.text || [_txView.text isEqualToString:@""]) {
        
        [UIAlertView alertTitle:@"提示信息" msg:@"请将您宝贵的意见或建议反馈给我们"];
        return NO;
    }
    return YES;
}

- (void)sendBtnClicked:(UIButton *)btn {
    if (![self ruleCommitText]) {
        return;
    }
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:@"40" forKey:@"news.adnewstypeid"];
    [body setObject:_txView.text forKey:@"news.adnewscontant"];
    [body setObject:APP_DELEGATE.userName forKey:@"news.adnewsname"];
    [body setObject:@"1" forKey:@"news.isdelete"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_CMS_956122];
    MKNetworkOperation *op = [en operationWithPath:@"news_addAdnewsForPlat.action" params:body httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *reqStr = completedOperation.responseString;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([reqStr isEqualToString:@"null()"]) {
            [self.view showAlertText:@"服务器返回异常"];
            
            return ;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"您的意见与建议已发送至956122平台管理员，我们会认真处理、采纳您的意见，谢谢！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view showAlertText:@"网络连接超时或服务器异常"];
    }];
    [en enqueueOperation:op];
    
}

#pragma mark - alertview Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self gobackPage];
}

#pragma mark - TextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_txView.text isEqualToString:@"请将您宝贵的意见或建议反馈给我们。"]) {
        
        textView.text = @"";
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        NSString *str = [textView.text substringFromIndex:textView.text.length - 1];
        if ([str isEqualToString:@"\n"]) {
            textView.text = [textView.text substringToIndex:textView.text.length - 1];
            [textView resignFirstResponder];
        }
    }
    
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
