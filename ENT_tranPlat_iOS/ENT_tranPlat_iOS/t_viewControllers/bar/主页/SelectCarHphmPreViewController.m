//
//  SelectCarHphmPreViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/21.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SelectCarHphmPreViewController.h"
#import "SelectCarHphmPreView.h"

@interface SelectCarHphmPreViewController ()<
SelectCarHphmPreViewDelegate,
UIScrollViewDelegate
>
{
    NSDictionary    *_dataDict;
    NSArray         *_keys;

}
@end

@implementation SelectCarHphmPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataDict = @{@"京":@"北京", @"津":@"天津", @"冀":@"河北", @"晋":@"山西", @"蒙":@"内蒙", @"辽":@"辽宁", @"吉":@"吉林", @"黑":@"黑龙江", @"沪":@"上海", @"苏":@"江苏", @"浙":@"浙江", @"皖":@"安徽", @"闽":@"福建", @"赣":@"江西", @"鲁":@"山东", @"豫":@"河南", @"鄂":@"湖北", @"湘":@"湖南", @"粤":@"广东", @"桂":@"广西", @"琼":@"海南", @"渝":@"重庆", @"川":@"四川", @"贵":@"贵州", @"云":@"云南", @"藏":@"西藏", @"陕":@"陕西", @"甘":@"甘肃", @"青":@"青海", @"宁":@"宁夏", @"新":@"新疆", };
    _keys = [_dataDict allKeys];
    
    
    [self loadView_];
    
}

- (void)loadView_{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
//    scrollV.delegate = self;
//    [self.view addSubview:scrollV];
    
    
    CGFloat width = (APP_PX_WIDTH - 10)/4;
    CGFloat height = 30*3;
    //[scrollV setContentSize:CGSizeMake(APP_WIDTH, height*8)];

    UILabel *vlineL = [[UILabel alloc] initWithFrame:YYRectMake(5, APP_VIEW_Y/APP_PX_WIDTH, 2, height*8)];
    [vlineL setBackgroundColor:COLOR_FRAME_LINE];
    [self.view addSubview:vlineL];
    
    for (int i = 0; i < 31; i++) {
        NSString *key = [_keys objectAtIndex:i];
        SelectCarHphmPreView *v = [[SelectCarHphmPreView alloc] initWithFrame:YYRectMake(5 + width*(i%4), APP_VIEW_Y/PX_X_SCALE + height*(i/4), width, height) jiancheng:key quancheng:[_dataDict objectForKey:key]];
        v.delegate_ = self;
        [self.view addSubview:v];
    }
    
}

- (void)selectCarHphmPreView:(SelectCarHphmPreView *)v tapJiancheng:(NSString *)jiancheng{
    if ([self.delegate_ respondsToSelector:@selector(selectCarHphmPreViewController:selectHphmPre:)]) {
        [self.delegate_ selectCarHphmPreViewController:self selectHphmPre:jiancheng];
    }
    [self gobackPage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"选择车牌号"];
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
