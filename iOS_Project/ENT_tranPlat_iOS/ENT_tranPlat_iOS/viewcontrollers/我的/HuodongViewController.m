//
//  SixViewController.m
//  TabBar
//
//  Created by 张永维 on 14-9-1.
//  Copyright (c) 2014年 张永维. All rights reserved.
//

#import "HuodongViewController.h"

@interface HuodongViewController ()
{
    UIWebView                   *_webView;
    UIImageView                 *_privateNavView;
    
    BOOL                        _gobackPage;
}
@end

@implementation HuodongViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)loadWebView
{
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
    
    NSString *urlString = [@"http://cms.956122.com/m/list.html?paramet=" stringByAppendingString:urlPendString];
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
    
    
    CGRect frame = CGRectMake(APP_X, 0, APP_WIDTH, 30);
    _privateNavView = [[UIImageView alloc] init];
    [_privateNavView setFrame:frame];
    [_privateNavView setBackgroundColor:COLOR_NAV];
    _privateNavView.userInteractionEnabled = YES;
    [self.view addSubview:_privateNavView];
    
    
    UIButton *privateGobackPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateGobackPageButton setFrame:CGRectMake(8, 2, 30, 30)];
    [privateGobackPageButton setImage:[UIImage imageNamed:@"go_back.png"] forState:UIControlStateNormal];
    [privateGobackPageButton addTarget:self action:@selector(privateGobackPage) forControlEvents:UIControlEventTouchUpInside];
    [_privateNavView addSubview:privateGobackPageButton];
    
    UILabel *privateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_X, 0, APP_WIDTH, _privateNavView.height)];
    privateTitleLabel.backgroundColor = [UIColor clearColor];
    privateTitleLabel.textAlignment = NSTextAlignmentCenter;
    privateTitleLabel.font = FONT_NOMAL;
    privateTitleLabel.textColor = [UIColor whiteColor];
    [privateTitleLabel setText:@"活动详情"];
    [_privateNavView addSubview:privateTitleLabel];
    
    UIButton *statementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statementButton setTitle:@"声明" forState:UIControlStateNormal];
    [statementButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [statementButton addTarget:self action:@selector(showStatement) forControlEvents:UIControlEventTouchUpInside];
    [statementButton setFrame:CGRectMake(APP_WIDTH - 80, 0, 60, _privateNavView.height)];
    [_privateNavView addSubview:statementButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(APP_X, _privateNavView.bottom, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT - APP_TAB_HEIGHT - _privateNavView.height)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self loadWebView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"活动"];
    
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
    if (range.location != NSNotFound) {//回到了第一页web
        _gobackPage = YES;
        [_webView setFrame:CGRectMake(APP_X, 0, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT - APP_TAB_HEIGHT)];
    }else{
        _gobackPage = NO;
        [_webView setFrame:CGRectMake(APP_X, _privateNavView.bottom, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT - APP_TAB_HEIGHT - _privateNavView.height)];
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


- (void)privateGobackPage{
    [_webView goBack];
}

- (void)sendTopic:(UIButton*)button{
    CYHDSendTopicViewController *sendTopicVC = [[CYHDSendTopicViewController alloc] init];
    [self.navigationController pushViewController:sendTopicVC animated:YES];
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
