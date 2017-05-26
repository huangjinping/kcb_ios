//
//  TestNetworkViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/20.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "TestNetworkViewController.h"

@interface TestNetworkViewController ()
{
    UIProgressView *_pv;
}
@end

@implementation TestNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pv = [[UIProgressView alloc] initWithFrame:CGRectMake(-10, APP_VIEW_Y, APP_WIDTH + 20, 5)];
    [_pv setProgressViewStyle:UIProgressViewStyleDefault];
    [self.view addSubview:_pv];
    _pv.progressTintColor = COLOR_NAV;
    //[_pv setProgress:1.0 animated:YES];
    [self run];
}

- (void)run{
    if (_pv.progress == 1) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, APP_VIEW_Y + 10, APP_WIDTH, 20)];
        [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:l];
        if ([Helper netAvailible]) {
            l.text = @"网络已连接，点击返回自动刷新";
        }else{
            l.text = @"当前网络不可用";
        }
    }else{
        _pv.progress = _pv.progress + 0.001;
        [self performSelector:@selector(run) withObject:nil afterDelay:0.001];
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
