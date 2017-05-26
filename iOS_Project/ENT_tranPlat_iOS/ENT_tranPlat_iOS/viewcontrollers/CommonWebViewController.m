//
//  CommonWebViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-11-27.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CommonWebViewController.h"

@implementation CommonWebViewController


- (void)viewDidLoad{

    [super viewDidLoad];
    
    if (self.url == nil) {
        [self.view showAlertText:@"地址为空"];
    }else{
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
        webView.delegate = self;
        NSURL *url = self.url;//[NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
    
    
    
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if(self.web_title){
        [self setCustomNavigationTitle:self.web_title];

    }else{
        NSString *title = [self.url webTitle];
        if (title.length > 10) {
            title = [title substringWithRange:NSMakeRange(0, 10)];
            title = [title stringByAppendingString:@"..."];
        }
        if ([title isEqualToString:@"0"]) {
            title = @"无法打开该链接";
        }
        [self setCustomNavigationTitle:title];
    }
    
    
    
}

#pragma mark - uiwebviewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
    if (![self.web_title isEqualToString:@"车险缴款"]) {
        [self.view showAlertText:[NSString stringWithFormat:@"%@", error]];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
