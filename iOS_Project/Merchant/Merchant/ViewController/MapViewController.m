//
//  MapViewController.m
//  Merchant
//
//  Created by Wendy on 16/1/20.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "MapViewController.h"
#import <MJRefresh.h>
#import "CustomMJRefreshGifFooter.h"

@interface MapViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listView;
    NSInteger currentPage;
    AMapPOI *selectMap;
    NSInteger selectIndex;
}
@property (atomic)NSMutableArray *arrayList;//搜索周边的地址列表
@property (nonatomic)UIImageView *imageView;//中心位置的坐标图片
@property (nonatomic)UIButton *setStoreAddressBtn;//设置为门店地址的按钮
@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMapView];
    [self initSearch];
    self.arrayList = [[NSMutableArray alloc] initWithCapacity:0];
    [self.view addSubview:[self createCenterView]];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        self.locationManager = [[CLLocationManager alloc] init];        
        [self.locationManager requestAlwaysAuthorization];
    }
}
- (UIView *)createCenterView{
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 63)];
    centerView.center = _mapView.center;
    centerView.centerY = _mapView.centerY-30;
    _setStoreAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _setStoreAddressBtn.backgroundColor = [UIColor whiteColor];
    [_setStoreAddressBtn addBorderWithWidth:0.8 color:kColor0XFF9418 corner:2];
    _setStoreAddressBtn.frame = CGRectMake(0, 0, 120, 30);
    [_setStoreAddressBtn setTitle:@"设置为门店地址"];
    _setStoreAddressBtn.titleLabel.font = V3_32PX_FONT;
    [_setStoreAddressBtn setTitleColor:kColor0XFF9418];
    _setStoreAddressBtn.hidden = YES;
    [_setStoreAddressBtn addTarget:self action:@selector(setStoreAddressBtnAction)];
    [centerView addSubview:_setStoreAddressBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(49, _setStoreAddressBtn.bottom, 23, 33)];
    imageView.image = [UIImage imageNamed:@"zuobiao_small"];
    [centerView addSubview:imageView];
    return centerView;
}
//设置门店地址
- (void)setStoreAddressBtnAction{
    NSInteger merid = ApplicationDelegate.shareLoginData.userdata.mid;
    NSString *lnglat = [NSString stringWithFormat:@"%f,%f",selectMap.location.longitude,selectMap.location.latitude];
    NSDictionary *param = @{@"merid":[NSNumber numberWithInteger:merid].stringValue,@"lnglat":lnglat};
    [AFNHttpRequest afnHttpRequestUrl:kHttpEditLngLat param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            _setStoreAddressBtn.hidden = YES;
            ApplicationDelegate.shareLoginData.userdata.jwd = lnglat;
        }
        [UIHelper alertWithMsg:kRspMsg(responseObject)];
        
    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMapView
{
    CGRect frame = CGRectMake(0, 0, self.view.width, self.view.height/2);
    self.mapView = [[MAMapView alloc] initWithFrame:frame];
    self.mapView.showsUserLocation = YES;
//    self.mapView.zoomLevel = 12;
    [self.mapView setZoomLevel:14 animated:YES];
    self.mapView.showsCompass = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.delegate = self;
    NSString *jwd = ApplicationDelegate.shareLoginData.userdata.jwd;
    NSArray * value = [jwd componentsSeparatedByString:@","];
    if (value.count == 2) {
        NSString *lat = value.lastObject;
        NSString *longt = value.firstObject;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, longt.doubleValue);
        [_mapView addAnnotation:pointAnnotation];
        self.mapView.centerCoordinate = CLLocationCoordinate2DMake(lat.doubleValue, longt.doubleValue);
    }
    [self.view addSubview:self.mapView];

    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mapView.height-APP_NAV_HEIGHT-APP_STATUS_BAR_HEIGHT, self.view.width, self.view.height - self.mapView.height+APP_NAV_HEIGHT) style:UITableViewStylePlain];
    listView.delegate = self;
    listView.dataSource = self;
    listView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    listView.mj_footer = [CustomMJRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshListFooter)];
    [self.view addSubview:listView];
}

- (void)initSearch
{
    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self searchPoiByCenterCoordinate];
}
- (void)refreshListFooter{
    currentPage ++;
    [self searchPoiByCenterCoordinate];
}
- (void)searchPoiByCenterCoordinate
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
    request.types               = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.offset = 10;
    request.page = currentPage;
    [self.search AMapPOIAroundSearch:request];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
    }
    
    AMapPOI *poi = self.arrayList[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.textLabel.font = V3_38PX_FONT;
    cell.detailTextLabel.text = poi.address;
    cell.detailTextLabel.font = V3_34PX_FONT;
    cell.imageView.image = [UIImage imageNamed:@"zuobiao_small hover"];
    cell.detailTextLabel.textColor = kColor0X949694;
    cell.textLabel.textColor = [UIColor blackColor];

    if (indexPath.row == selectIndex) {
        cell.imageView.image = [UIImage imageNamed:@"zuobiao_small"];
        cell.detailTextLabel.textColor = kColor0XFF9418;
        cell.textLabel.textColor = kColor0XFF9418;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectMap = self.arrayList[indexPath.row];
    _setStoreAddressBtn.hidden = NO;
    selectIndex = indexPath.row;
    
    [tableView reloadData];
    
    
}
- (void)backEvent:(UIBarButtonItem *)paramItem
{
    [ApplicationDelegate goBackHomeView];
}


#pragma mark - Map Delegate

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    if (wasUserAction) {
        NSLog(@"did move byUser:%d", wasUserAction);
        currentPage =1;
        selectIndex = -1;
        [self searchPoiByCenterCoordinate];
        _setStoreAddressBtn.hidden = YES;
    }
}

//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    if(response.pois.count == 0)
    {
        if (currentPage > 1) {
            currentPage--;
        }
        return;
    }
    if (currentPage == 1) {
        [self.arrayList removeAllObjects];
    }
    [self.arrayList addObjectsFromArray:response.pois];
    [listView reloadData];

    [listView.mj_footer endRefreshing];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.image = [UIImage imageNamed:@"zuobiao"];        
        return annotationView;
    }
    return nil;
}

@end