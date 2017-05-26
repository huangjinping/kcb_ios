//
//  PayViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithFkje:(NSString*)fkje
               znj:(NSString*)znj
              hphm:(NSString*)hphm
             jdsbh:(NSString*)jdsbh
          username:(NSString*)username
              fxjg:(NSString*)fxjg
              cljg:(NSString*)cljg
            cljgmc:(NSString*)cljgmc
             wsjyw:(NSString*)wsjyw{
    if (self = [super init]) {
        _fkje = [[NSString alloc] initWithString:fkje];
        _znj = [[NSString alloc] initWithString:znj];
        _hphm = [[NSString alloc] initWithString:hphm];
        _jdsbh = [[NSString alloc] initWithString:jdsbh];
        
        _username = [[NSString alloc] initWithString:username];
        _fxjg = [[NSString alloc] initWithString:fxjg];
        _cljg = [[NSString alloc] initWithString:cljg];
        _cljgmc = [[NSString alloc] initWithString:cljgmc];
        
        _wsjyw = [[NSString alloc] initWithString:wsjyw];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    //支付
    NSInteger zje = [_fkje integerValue] + [_znj integerValue];
    NSString *zjeStr = [NSString stringWithFormat:@"%d", zje];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://pr.956122.com/peccancy.do?action=androidOrder&transamt=%@&hphm=%@&jdsbh=%@&username=%@&fkje=%@&znj=%@&fxjg=%@&cljg=%@&cljgmc=%@&wsjyw=%@", zjeStr, _hphm, _jdsbh, _username, _fkje, _znj, _fxjg, _cljg, _cljgmc, _wsjyw ];
    
    NSString * encodeUrlStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8));
                      
                      
                      
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:encodeUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    //@"http://open.956122.com/peccancy.do?action=androidOrder&transamt=200&hphm=%E9%9D%92AL7688&jdsbh=630104100043935&username=admin&fkje=200&znj=0&fxjg=630104005000&cljg=630104005000&cljgmc=%E5%9F%8E%E8%A5%BF%E4%B8%80%E4%B8%AD%E9%98%9F&wsjyw=7"
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"缴款"];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark - uiwebviewDelegate

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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
