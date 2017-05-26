//
//  MessageViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-18.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MessageViewController.h"
#import "InformationCenterListViewController.h"
#import "DealingRecordViewController.h"
#import "PayRecordViewController.h"

@interface MessageViewController ()<
SegmentButtonViewDelegate,
UIScrollViewDelegate
>
{
    UIScrollView                    *_rootScrollView;
    SegmentButtonView               *_segButtonView;
    NSInteger                       _segButtonIndex;
    
    
    InformationCenterListViewController *_informationVC;
    PayRecordViewController             *_payVC;
    DealingRecordViewController         *_dealVC;
}
@end

@implementation MessageViewController


- (void)loadView_{
    CGRect contentFrame = CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT);
    _rootScrollView = [[UIScrollView alloc] initWithFrame:contentFrame];
    [_rootScrollView setPagingEnabled:YES];
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [_rootScrollView setContentSize:CGSizeMake(APP_WIDTH * 3, 1)];
    [_rootScrollView setDelegate:self];
    _rootScrollView.bounces = NO;
    [self.view addSubview:_rootScrollView];
    
    //系统消息
    _informationVC = [[InformationCenterListViewController alloc]init];
    [_informationVC.view setFrame:CGRectMake(0, 0, APP_WIDTH, _rootScrollView.height)];
    [_rootScrollView addSubview:_informationVC.view];
    
    //违法处理明细
    _dealVC = nil;
    //罚款缴纳明细
    _payVC = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadView_];
}

/*
 
 //违法处理明细响应
 NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
 if ([arr count] == 0) {
 [self.view showAlertText:@"当前未绑定任何车辆，故无法查询违法处理明细信息。"];
 return;
 }
 DealingRecordViewController *dealVC = [[DealingRecordViewController alloc] init];
 [self.navigationController pushViewController:dealVC animated:YES];
 
 
 
 //罚款缴纳明细响应
 PayRecordViewController *payVC = [[PayRecordViewController alloc] init];
 [self.navigationController pushViewController:payVC animated:YES];

 
 //信息中心响应
 InformationCenterListViewController *informationVC = [[InformationCenterListViewController alloc]init];
 [self.navigationController pushViewController:informationVC animated:YES];
 */

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //tabbar view
    if (_navigationImgView) {
        [_navigationImgView removeFromSuperview];
    }
    if (!_segButtonView) {
        _segButtonView = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_NAV_HEIGHT) backgroundColor:COLOR_NAV andLineColor:[UIColor whiteColor]];
        NSArray *titles = [NSArray arrayWithObjects:@"系统消息", @"违法处理", @"罚款缴纳", nil];
        [_segButtonView setTitles:titles withTitleNorColor:[UIColor whiteColor] andTitleSelColor:[UIColor whiteColor]];
        [_segButtonView setDelegate:self];
        [self.navigationController.navigationBar addSubview:_segButtonView];
        
        _segButtonView.selectedIndex = _segButtonIndex;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //nav remove
    _segButtonIndex = _segButtonView.selectedIndex;
    [_segButtonView removeFromSuperview];
    _segButtonView = nil;
}


#pragma mark- seg Delegate and DataSource
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //顶部蓝色button底线的动态切换
    NSInteger index = scrollView.contentOffset.x/APP_WIDTH;
    if (index < 0 || index > 2) {
        return;
    }
    [_segButtonView setSelectedIndex:index];
    
}

- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    
    [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * index, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    
    if (index == 1){
        if (_dealVC == nil) {
            //违法处理明细
            _dealVC = [[DealingRecordViewController alloc] init];
            [_dealVC.view setFrame:CGRectMake(APP_WIDTH, 0, APP_WIDTH, _rootScrollView.height)];
            [_rootScrollView addSubview:_dealVC.view];
        }
        
        
        
    }else if (index == 2){
        if (_payVC == nil) {
            //罚款缴纳明细
            _payVC = [[PayRecordViewController alloc] init];
            [_payVC.view setFrame:CGRectMake(APP_WIDTH*2, 0, APP_WIDTH, _rootScrollView.height)];
            [_rootScrollView addSubview:_payVC.view];
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
