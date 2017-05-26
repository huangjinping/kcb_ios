//
//  CheXian_JSQ_ViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-10-20.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CheXian_JSQ_ViewController.h"

@interface CheXian_JSQ_ViewController ()

@end

@implementation CheXian_JSQ_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //内容视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    webView.delegate = self;
    NSString *urlStr = @"http://gab.122.gov.cn/views/inquiryjyqz.html";
    NSString *encodeUrlStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlStr, nil, nil, kCFStringEncodingUTF8));
    
    NSURL *url = [NSURL URLWithString:encodeUrlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    [self.view addSubview:webView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"车检计算器"];
}

#pragma mark - delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
    [self.view showAlertText:[NSString stringWithFormat:@"%@", error]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
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
