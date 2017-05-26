//
//  CheLiang_ZHViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-10-22.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CheLiang_ZHViewController.h"

@interface CheLiang_ZHViewController ()

@end

@implementation CheLiang_ZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *pendingArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *cars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    for (int i = 0; i < [cars count]; i++) {
        CarInfo *car = [cars objectAtIndex:i];

        NSString *string = [NSString stringWithFormat:@"{\"hphm\":\"%@\",\"vin\":\"%@\"}",[car.hphm uppercaseString], car.clsbdh];
        [pendingArr addObject:string];
    }
    
    NSString *urlPendString = @"";
    for (int i = 0; i < [pendingArr count]; i++) {
        if (i == 0) {
            urlPendString = [urlPendString stringByAppendingString:@"["];
        }else if(i == 1){
            urlPendString = [urlPendString stringByAppendingString:@","];
        }
        urlPendString = [urlPendString stringByAppendingString:[pendingArr objectAtIndex:i]];

    }
    
    NSString *urlString = @"";
    if (urlPendString.length == 0) {
        urlString = @"http://cms.956122.com/m/recall.html";
    }else{
        urlString = [[@"http://cms.956122.com/m/recall.html?paramet=" stringByAppendingString:urlPendString] stringByAppendingString:@"]"];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //内容视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _webView.delegate = self;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
    [self.view addSubview:_webView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"车辆召回速查"];
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
