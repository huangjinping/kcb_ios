//
//  APPIllustrateViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/24.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "APPIllustrateViewController.h"

@interface APPIllustrateViewController ()<
UIWebViewDelegate
>

{
    UIWebView                   *_webView;
    
    BOOL                        _gobackPage;
}

@end

@implementation APPIllustrateViewController
-(void)loadWebView
{
    NSString *urlString = @"http://appsns.956122.com/apphelp/apphelp.html";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //内容视图
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gobackPage = YES;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, 0, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT - APP_TAB_HEIGHT)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"活动"];
    
    
    UIButton *statementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statementButton setTitle:@"声明" forState:UIControlStateNormal];
    [statementButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [statementButton addTarget:self action:@selector(showStatement) forControlEvents:UIControlEventTouchUpInside];
    [statementButton setFrame:CGRectMake(APP_WIDTH - 80, 2, 60, APP_NAV_HEIGHT - 2*2)];
    [_navigationImgView addSubview:statementButton];
    
    [self loadWebView];
    
}


- (void)showStatement{
    [UIAlertView alertTitle:@"活动声明" msg:@"本活动与苹果公司（Apple Inc.）无关，活动由易恩通智能科技有限公司发起，易恩通智能科技有限公司享有最终解释权。"];
}

#pragma mark - delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
    [self.view showAlertText:[NSString stringWithFormat:@"%@", error]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *urlString = [NSString stringWithFormat:@"%@", webView.request.URL];
    NSRange range = [urlString rangeOfString:@"http://cms.956122.com/m/list.html"];
    if (range.location != NSNotFound) {
        _gobackPage = YES;
    }else{
        _gobackPage = NO;
    }
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [NSString stringWithFormat:@"%@", request.URL];
    NSRange range = [urlString rangeOfString:@"http://cms.956122.com/m/list.html"];
    if (range.location != NSNotFound) {
        _gobackPage = YES;
    }else{
        _gobackPage = NO;
    }
    return YES;
}

- (void)gobackPage{
    if (_gobackPage) {
        [super gobackPage];
    }else{
        [_webView goBack];
    }
}




- (void)sendTopic:(UIButton*)button{
    CYHDSendTopicViewController *sendTopicVC = [[CYHDSendTopicViewController alloc] init];
    [self.navigationController pushViewController:sendTopicVC animated:YES];
}


@end
