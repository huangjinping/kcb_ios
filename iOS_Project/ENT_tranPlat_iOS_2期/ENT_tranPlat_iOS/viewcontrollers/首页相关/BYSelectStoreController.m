//
//  BYSelectStoreController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/9/1.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BYSelectStoreController.h"
#import "MyAFNetWorkingRequest.h"
#import "BaoYangModel.h"
#import "storesCell.h"
#import "ZKButton.h"
#import "ChoesPackgeController.h"
#import "InfoViewController.h"
@interface BYSelectStoreController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    UIView      *_bgView;
    int         _typeId;
    CGFloat     _Coordinate_X;
    CGFloat     _Coordinate_Y;
    
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSMutableArray *datas;
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) MyAFNetWorkingRequest *manager;
@end

@implementation BYSelectStoreController

- (void)viewDidLoad {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [super viewDidLoad];
    //
    //创建顶部视图
    [self createTopView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //请求数据
    _datas = [NSMutableArray array];
    _typeId = 17;
    [self downloadData];
    
    //建表
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame)+10, APP_WIDTH, APP_HEIGHT-64-49) style:UITableViewStylePlain];
    [self.view  addSubview:_tabView];
    //表的注册
    [_tabView registerClass:[storesCell class] forCellReuseIdentifier:@"cell"];
    
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    storesCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    BaoYangModel *model = _datas[indexPath.row];
    //给cell添加内容
    cell.model = model;
    //取消cell的点击事件(动画)
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //自定义附属控件
    ZKButton *dealBtn = [ZKButton blockButtonWithFrame:CGRectMake(screenSize.width/2, 90, screenSize.width/2, 30) type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        ChoesPackgeController *choesVC = [[ChoesPackgeController alloc]init];
        choesVC.car = self.car;
        choesVC.baoyang = model;
        choesVC.baoyang.xxlc = self.baoyang.xxlc;
        choesVC.baoyang.hphm = self.baoyang.hphm;
        choesVC.baoyang.vin  = self.baoyang.vin;
        choesVC.baoyang.zcrq = self.baoyang.zcrq;
        choesVC.baoyang.fdjh = self.baoyang.fdjh;
        choesVC.baoyang.sczd = self.baoyang.sczd;
        choesVC.baoyang.city = self.baoyang.city;
        
        [self.navigationController pushViewController:choesVC animated:YES];
        
    }];
    dealBtn.backgroundColor = [UIColor clearColor];
    [cell addSubview:dealBtn];
    
    //自定义附属控件
    ZKButton *detailBtn = [ZKButton blockButtonWithFrame:CGRectMake(0, 0, APP_WIDTH, 80) type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        
        InfoViewController *deta=[[InfoViewController alloc]init];
        
        BaoYangModel *model = _datas[indexPath.row];
        deta.model = model;
        [self.navigationController pushViewController:deta animated:YES];
        
        
    }];
    detailBtn.backgroundColor = [UIColor clearColor];
    [cell addSubview:detailBtn];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark downloadData
-(void)downloadData
{
    
    // example
    // 实例化一个位置管理器
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 设置定位精度
    // kCLLocationAccuracyNearestTenMeters:精度10米
    // kCLLocationAccuracyHundredMeters:精度100 米
    // kCLLocationAccuracyKilometer:精度1000 米
    // kCLLocationAccuracyThreeKilometers:精度3000米
    // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    }
    else {
        ENTLog(@"请开启定位功能！");
    }
    
    // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    self.locationManager.distanceFilter = 1000.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    
    
    //请求数据
    NSString *urlString = [NSString stringWithFormat:@"http://%@/getShopInfo.do?typeId=%d&x=116.357557&y=39.715513&city=昆明",NET_ADDR_BUSS_956122,_typeId];
    
    
    NSString *path = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _manager = [[MyAFNetWorkingRequest alloc]initWithRequest:path andParams:nil  andBlock:^(NSData *requestData) {
        
        
       // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"msg"];
        _datas = [BaoYangModel arrayOfModelsFromDictionaries:dataArr];
        
        [_tabView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    }];
    
}
#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    _Coordinate_X = newLocation.coordinate.longitude;//经度
    _Coordinate_Y = newLocation.coordinate.latitude;//纬度
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}
#pragma mark 创建顶部视图
-(void)createTopView
{
    
    self.view.backgroundColor = COLOR_FRAME_LINE;
    CGFloat buttonBgHeight = 60 + 20 +10 ;
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH,buttonBgHeight*PX_Y_SCALE)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    //*********************************选择服务*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 300, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"服务形式："];
    [_bgView addSubview:label];
    
    UILabel *carLabel = [[UILabel alloc] initWithFrame:QGRectMake(APP_WIDTH-90,30, 180, 40)];
    [carLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [carLabel setText:@"驾车到店"];
    [_bgView  addSubview:carLabel];
    
 
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"选择商户"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
