//
//  ZhaohuiViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/20.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZhaohuiViewController.h"

@interface ZhaohuiViewController ()
{
    ZhaohuiMsg *_zhaohui;
}
@end

@implementation ZhaohuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:self.hphm];
    NSString *vin = @"";
    if ([arr count]) {
        CarInfo *car = [arr lastObject];
        vin = car.clsbdh;
    }
    arr = [[DataBase sharedDataBase] selectZhaohuiByClsbdh:vin];
    if ([arr count]) {
        _zhaohui = [arr lastObject];
    }
    
    if(_zhaohui){
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_STATUS_BAR_HEIGHT)];
        [self.view addSubview:scrollView];
    
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"品牌：%@",_zhaohui.brand];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(20, l.bottom + 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"款式：%@",_zhaohui.cartype];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(20, l.bottom + 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"召回方式：%@",_zhaohui.dealway];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(20, l.bottom + 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"召回日期：%@",_zhaohui.period];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
    
        l = [[UILabel alloc] initWithFrame:CGRectMake(20, l.bottom + 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"存在问题：%@",_zhaohui.reason];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(20, l.bottom + 20, (APP_WIDTH - 2*20), 0)];
        [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        l.numberOfLines = 0;
        l.text = [NSString stringWithFormat:@"处理方式：%@",_zhaohui.method];
        [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
        [scrollView addSubview:l];
        
        [scrollView setContentSize:CGSizeMake(scrollView.width, l.bottom + 30)];
        
    }
    
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"召回信息"];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
