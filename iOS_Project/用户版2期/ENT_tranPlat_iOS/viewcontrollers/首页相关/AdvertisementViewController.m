//
//  AdvertisementViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-5.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AdvertisementViewController.h"

@interface AdvertisementViewController ()

@end

@implementation AdvertisementViewController

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
    
    
    NSString *urlString = self.url;
    NSRange range = [self.url rangeOfString:@"[value]"];
    if (range.location != NSNotFound) {//有参数
        urlString = [self.url substringToIndex:range.location];
        
        NSMutableArray *hpzlArr = [[NSMutableArray alloc] initWithCapacity:0];
        [hpzlArr addObject:@"null"];
        [hpzlArr addObject:@"null"];
        
        NSMutableArray *vehicleArr = [[NSMutableArray alloc] initWithCapacity:0];
        [vehicleArr addObject:@"null"];
        [vehicleArr addObject:@"null"];
        
        NSArray *cars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
        for (int i = 0; i < [cars count]; i++) {
            CarInfo *car = [cars objectAtIndex:i];
            [vehicleArr replaceObjectAtIndex:i withObject:[car.hphm uppercaseString]];
            [hpzlArr replaceObjectAtIndex:i withObject:car.hpzl];
        }
        
        NSString *urlPendString = [NSString stringWithFormat:@"{\"username\":\"%@\",\"vehicle1\":\"%@\",\"hpzl1\":\"%@\",\"vehicle2\":\"%@\",\"hpzl2\":\"%@\"}", APP_DELEGATE.userName, [vehicleArr objectAtIndex:0], [hpzlArr objectAtIndex:0], [vehicleArr objectAtIndex:1], [hpzlArr objectAtIndex:1]];
        
        urlString = [urlString stringByAppendingString:urlPendString];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    //http://cms.956122.com/m/activity2.html?paramet=[%22username%22:%22test%22,%22vehicle1%22:%22%E4%BA%91AFF869%22,%22hpzl1%22:%2202%22,%22vehicle2%22:%22null%22,%22hpzl2%22:%22null%22]
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"开车邦"];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    ENTLog(@"newurl = %@",request.URL);
    
    return YES;
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
