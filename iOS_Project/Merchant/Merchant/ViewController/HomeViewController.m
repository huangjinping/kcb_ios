//
//  HomeViewController.m
//  Merchant
//
//  Created by Wendy on 15/12/18.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeOrderCell.h"
//#import "ZBarSDK.h"
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MEOrderList.h"
#import "OrderDetailController.h"
#import "QRCodeViewController.h"
#import "CustomMJRefreshGifHeader.h"
#import "CustomMJRefreshGifFooter.h"

#define ROWS_PER_PAGE_ORDER @"10"
#define TimeInterval 5*60
#import "ZbarViewController.h"

@interface HomeViewController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_codeTextField;
    NSMutableArray *dataArray;
    NSMutableArray *newOrderArray;
    
    NSString *currentServerStatus;
    NSInteger currentPagesSectionOne;//代办订单的计数
    NSInteger currentPagesSectionTwo;//新订单的计数
    NSInteger currentRefreshType;
    
    UILabel *badgeView;
    
    NSTimer *timer;
    
}
@property (nonatomic, strong) HTHorizontalSelectionList *segment;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self buildData:@"2"];//默认是待办订单
    
    self.tableView.mj_header = [CustomMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshOrderListHeader)];
    //下拉加载更多
    self.tableView.mj_footer = [CustomMJRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshOrderListFooter)];
    
    //注册通知，用于在详情中验证消费码之后，重新刷新列表是否验证的状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderList:) name:@"refreshOrderList" object:nil];
}
- (void)refreshOrderList:(NSNotification *)sender{
    NSString *status = (NSString *)sender.object;
    currentServerStatus = status;
    [self refreshOrderListHeader];
}
- (void)refreshOrderListHeader{
    currentRefreshType = RefreshTypeHeader;
    if (currentServerStatus.integerValue == 2) {//当前是待办
        currentPagesSectionOne = 1;
        [self requetOrderList:@"2" pages:currentPagesSectionOne];

    }else{
        currentPagesSectionTwo = 1;
        [self requetOrderList:@"1" pages:currentPagesSectionTwo];
    }
}

- (void)refreshOrderListFooter{
    currentRefreshType = RefreshTypeFooter;
    if (currentServerStatus.integerValue == 2) {//当前是待办
        currentPagesSectionOne ++;
        [self requetOrderList:@"2" pages:currentPagesSectionOne];
        
    }else{
        currentPagesSectionTwo ++;
        [self requetOrderList:@"1" pages:currentPagesSectionTwo];
    }
}
- (void)buildUI{
    [self resetNavigationBar];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - APP_NAV_HEIGHT - APP_STATUS_BAR_HEIGHT-APP_TAB_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGB(234, 234, 234);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self createHeaderView];
}
- (void)buildData:(NSString *)status{
//    self.segment.selectedButtonIndex = 0;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    newOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
    currentServerStatus = status; //@"2";
    currentPagesSectionOne = 1;
    currentPagesSectionTwo = 1;
    [self requetOrderList:@"2" pages:currentPagesSectionOne];
    [self requetOrderList:@"1" pages:currentPagesSectionTwo];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ApplicationDelegate.menuController setPanGestureRecognizerEnable:YES];
    timer =  [NSTimer scheduledTimerWithTimeInterval:TimeInterval target:self selector:@selector(requestNewOrderByTimer) userInfo:nil repeats:YES];
}
- (void)requestNewOrderByTimer{
    NSLog(@"定时器自动刷新");
    currentPagesSectionTwo = 1;
    [self requetOrderList:@"1" pages:currentPagesSectionTwo];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ApplicationDelegate.menuController setPanGestureRecognizerEnable:NO];
    [timer invalidate];
}
- (void)resetNavigationBar{
    self.segment = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH*0.5, 40)];
    self.segment.backgroundColor = [UIColor clearColor];
    self.segment.delegate = self;
    self.segment.dataSource = self;
    self.segment.bottomTrimHidden = YES;
    self.segment.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeNoBounce;
    
    self.segment.selectionIndicatorColor = [UIColor whiteColor];
    [self.segment setTitleColor:[UIColor colorWithHex:0xc0e3c4] forState:UIControlStateNormal];
    [self.segment setTitleFont:V3_38PX_FONT forState:UIControlStateNormal];
    [self.segment setTitleFont:V3_38PX_FONT forState:UIControlStateSelected];
    
    self.navigationItem.titleView = self.segment;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dd01"] style:UIBarButtonItemStylePlain target:self action:@selector(backEvent:)];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    
    UIBarButtonItem *msg = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dd02"] style:UIBarButtonItemStylePlain target:self action:@selector(message)];//dd02
    [msg setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    space.width = 5;
    
    UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dd03"] style:UIBarButtonItemStylePlain target:self action:@selector(customMessage)];//dd03
    [custom setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = msg;


}

- (UIView *)createHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(10, 18, 30, 24);
    scanBtn.showsTouchWhenHighlighted = YES;
    [scanBtn setImage:[UIImage imageNamed:@"saoma"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanBtnAction)];
    [view addSubview:scanBtn];
    
    UIButton *validateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    validateBtn.frame = CGRectMake(view.width-60, 18, 50, 25);
    validateBtn.titleLabel.font = V3_36PX_FONT;
    [validateBtn setTitle:@"验证" forState:UIControlStateNormal];
    validateBtn.showsTouchWhenHighlighted = YES;
    [validateBtn addBorderWithWidth:0.8 color:kColor0X39B44A corner:2];
    [validateBtn setTintColor:kColor0X39B44A];
    [validateBtn addTarget:self action:@selector(validateBtnAction)];
    [view addSubview:validateBtn];

    _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(scanBtn.right+5, 15, 0, 30)];
    _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码或使用扫一扫" attributes:@{NSFontAttributeName: V3_36PX_FONT}];

    [view addSubview:_codeTextField];
    _codeTextField.right = validateBtn.left - 5;
    
    [view addLineWithFrame:CGRectMake(0, 59, APP_WIDTH, 1) lineColor:kLineColor];
    return view;
}
- (void)message{
}
- (void)scanBtnAction{
//    ZbarViewController * view = [[ZbarViewController alloc] init];
//    [self presentViewController:view animated:YES completion:^{
//        
//    }];
    
    QRCodeViewController * vc = [[QRCodeViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.commplete = ^(NSString *code){
            [self requestValidata:code];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#if 0
- (void)scanBtnAction1{
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.readerView.torchMode = 0;
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    UIView  *view = [[UIView alloc]  initWithFrame : self.view.bounds];
    view. backgroundColor  = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    imageView.size = CGSizeMake(280, 280);
    imageView.center = self.view.center;
    [view addSubview:imageView];
    reader.cameraOverlayView  = view;
    reader.tracksSymbols = YES;
    reader.showsZBarControls = YES;
    reader.showsHelpOnFail = NO;
    [self presentViewController:reader animated:YES completion:nil];
}
- (void)scanBtnAction2{
    ZBarReaderView *readerView = [[ZBarReaderView alloc]init];
    readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(readerView.frame) - 126, 200, 200);
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator= [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    [self.view addSubview:readerView];
    //扫描区域计算
    readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:readerView.bounds];
    
    [readerView start];
}
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    
    [readerView stop];
    [readerView removeFromSuperview];
    [self requestValidata:symbol.data];
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
#endif
- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSLog(@"===%@",symbol.data);
    [reader dismissViewControllerAnimated:YES completion:nil];
    [self requestValidata:symbol.data];
    
}
- (void)requestValidata:(NSString *)code{
    
    NSInteger merchantId = ApplicationDelegate.shareLoginData.userdata.mid;
    NSDictionary *param = @{@"consumerCode":code,@"merchantId":[NSNumber numberWithInteger:merchantId].stringValue,@"type":@"0"};
    [AFNHttpRequest afnHttpRequestUrl:kHttpDealConsumer param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            _codeTextField.text = nil;
            //验证合法性之后，进入订单详情  用消费码查询订单详情接口
            OrderDetailController *orderDetail = [[OrderDetailController alloc] init];
            orderDetail.consumerCode = code;
            orderDetail.hidesBottomBarWhenPushed = YES;
            orderDetail.commplete = ^(NSString * orderId){
                [self buildData:@"2"];
            };
            [self.navigationController pushViewController:orderDetail animated:YES];
        }else{
            [UIHelper alertWithMsg:kRspMsg(responseObject)];
        }
    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];

}
- (void)validateBtnAction{
    [self.view endEditing:YES];
    if (_codeTextField.text.length==0) {
        
        [UIHelper alertWithMsg:@"请输入消费码"];
        return;
    }
    [self requestValidata:_codeTextField.text];
}
- (void)customMessage{
    if (ApplicationDelegate.showingRootController == YES) {
        [ApplicationDelegate.menuController showRightController:YES];
    } else{
        [ApplicationDelegate.menuController showRootController:YES];
    }
    ApplicationDelegate.showingRootController = !ApplicationDelegate.showingRootController;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 请求接口
- (void)requetOrderList:(NSString *)status pages:(NSInteger)page{
    
    NSInteger merchantId = ApplicationDelegate.shareLoginData.userdata.mid;
    NSDictionary *param = @{@"merchantId":[NSNumber numberWithInteger:merchantId].stringValue,
                            @"status":status,
                            @"page":[NSNumber numberWithInteger:page].stringValue,
                            @"rows":ROWS_PER_PAGE_ORDER,
                            @"role":@"1",
                            @"account":ApplicationDelegate.accountId
                            };
    [AFNHttpRequest afnHttpRequestUrlNonHub:kHttpOrderList param:param success:^(id responseObject) {
        
        [self endRefresh];
        
        if (currentPagesSectionOne == 1 && status.integerValue == 2) {
            [dataArray removeAllObjects];
        }else if(currentPagesSectionTwo == 1 && status.integerValue == 1){
            [newOrderArray removeAllObjects];
        }
        
        if (kRspCode(responseObject) == 0) {
            NSDictionary *pBizCustomDict = responseObject[@"body"][0];
            NSArray * orderList  = pBizCustomDict[@"orderList"];
            NSArray *tmpList = [MEOrderList mj_objectArrayWithKeyValuesArray:orderList];
            
            //返回数据为0
            if (tmpList.count == 0) {
                if (status.integerValue == 2 && currentPagesSectionOne>0) {
                    currentPagesSectionOne --;
                }else if (status.integerValue == 1  && currentPagesSectionTwo>0){
                    currentPagesSectionTwo --;
                }
            }else{
                if (status.intValue == 2) {
                    [dataArray addObjectsFromArray:tmpList];
                }else{
                    [newOrderArray addObjectsFromArray:tmpList];
                    badgeView.text = [NSNumber numberWithInteger:newOrderArray.count].stringValue;
                    badgeView.hidden = NO;
                }
            }
            

            [self addEmptyView:currentServerStatus];
            
            [self.tableView reloadData];
            
        }else{
            [self dealServerError: kRspMsg(responseObject) status:status];
        }
        
    } failure:^(NSError *error) {
        [self dealServerError: kNetworkErrorDesp status:status];
        [self endRefresh];

    } view:self.view];
}
- (void)endRefresh{
    if (currentRefreshType == RefreshTypeHeader) {
        [self.tableView.mj_header endRefreshing];
    }else if(currentRefreshType == RefreshTypeFooter){
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)showEmptyView:(BOOL)show tip:(NSString *)text{
    if (show) {
        UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 129, 100)];
        imgView.centerX = view.centerX;
        imgView.centerY = view.centerY - 40;
        imgView.image = [UIImage imageNamed:@"noOrder"];
        UILabel *emptyView = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom + 20, view.width, 40)];
        emptyView.backgroundColor = kColorBackgroud;
        emptyView.text = text;
        emptyView.textAlignment = NSTextAlignmentCenter;
        emptyView.textColor = kColorOX555555;
        
        [view addSubview:imgView];
        [view addSubview:emptyView];

        self.tableView.tableFooterView = view;
    }else{
        self.tableView.tableFooterView = nil;
    }
}
- (void)addEmptyView:(NSString *)status{
    if (status.integerValue == 2) {
        if (dataArray.count > 0) {
            [self showEmptyView:NO tip:nil];
            [self.tableView reloadData];
        }else{
            [self showEmptyView:YES tip:@"没有相关订单哦，亲"];
        }
    }else{
        if (newOrderArray.count > 0) {
            [self showEmptyView:NO tip:nil];
            [self.tableView reloadData];
            badgeView.text = [NSNumber numberWithInteger:newOrderArray.count].stringValue;
            badgeView.hidden = NO;
        }else{
            badgeView.hidden = YES;
            
            [self showEmptyView:YES tip:@"没有新订单哦，亲"];
        }
    }
}
#pragma mark - 服务器响应异常处理
//status:2:待办  1:新订单  error:提示文字
- (void)dealServerError:(NSString *)error status:(NSString *)status{
    [UIHelper alertWithMsg:error];
    if (currentRefreshType == RefreshTypeFooter) {
        if (status.intValue == 2 && currentPagesSectionOne > 1) {
            currentPagesSectionOne --;
        }else if (status.intValue == 1 && currentPagesSectionTwo > 1){
            currentPagesSectionTwo --;
        }
    }
    
}

#pragma mark - UITableViewDelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (currentServerStatus.integerValue == 2) {
        return dataArray.count;
    }
    return newOrderArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HomeOrderCell";
    HomeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HomeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MEOrderList *item;
    if (currentServerStatus.integerValue == 2) {
        item = dataArray[indexPath.section];
    }else{
        item = newOrderArray[indexPath.section];
    }
    
    [cell setCellModelsLab:item.carName];
    [cell setCellMobileLab:item.phoneNo];
    [cell setCellAmountLab:[NSString stringWithFormat:@"%.2f",item.payPrice]];
    [cell setCellAppointmentLab:item.bookingTime];
    cell.orderTimeLab.text = item.submitTime;
    [cell setCellStatusLab:item.status];
    if (item.status.intValue == 2) {
        [cell setCellComsumerLab:item.comsumerStatus];
    }else{
        cell.comsumerLabel.hidden = YES;
    }
    
    if (item.status.intValue == 1) {
        cell.tag = indexPath.section;
        [cell.actionBtn addTarget:self action:@selector(confirmOrder:)];
    }
    return cell;
}

- (void)confirmOrder:(UIButton *)sender{
    MEOrderList *item = newOrderArray[sender.tag];
    NSDictionary *param = @{@"orderNo":item.orderNo,@"orderId":[NSNumber numberWithInteger:item.ids].stringValue};
    [AFNHttpRequest afnHttpRequestUrl:kHttpSummitRecOrder param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            currentPagesSectionTwo = 1;
            currentPagesSectionOne = 1;
            //处理
            [self requetOrderList:@"2" pages:currentPagesSectionOne];
            [self requetOrderList:@"1" pages:currentPagesSectionTwo];
        }
    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MEOrderList *item;
    if(currentServerStatus.integerValue == 2){
        item = dataArray[indexPath.section];
    }else{
        item = newOrderArray[indexPath.section];
    }
    
    OrderDetailController *orderDetail = [[OrderDetailController alloc] init];
    orderDetail.orderId = [NSNumber numberWithInteger:item.ids].stringValue;
    orderDetail.orderNo = item.orderNo;
    orderDetail.hidesBottomBarWhenPushed = YES;
    orderDetail.commplete = ^(NSString * orderId){
        [self buildData:orderId];
    };

    [self.navigationController pushViewController:orderDetail animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return 2;
}

//- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
//    if (index == 0) {
//        return @"待办订单";
//    }else{
//        return @"新订单";
//    }
//}
- (UIView *)selectionList:(HTHorizontalSelectionList *)selectionList viewForItemWithIndex:(NSInteger)index{
    if (index == 0) {
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/4, 40)];
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/5, 30)];
        view.text = @"待办订单";
        view.textAlignment = NSTextAlignmentCenter;
        view.font = V3_38PX_FONT;
        view.textColor = [UIColor whiteColor];
        [back addSubview:view];
        return back;
    }else{
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/4, 40)];
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/5, 30)];
        view.text = @"新订单";
        view.textAlignment = NSTextAlignmentCenter;
        view.font = V3_38PX_FONT;
        view.textColor = [UIColor whiteColor];
        [back addSubview:view];
        if (!badgeView) {
            badgeView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
            badgeView.layer.cornerRadius = 8;
            badgeView.layer.borderWidth = 1;
            badgeView.layer.backgroundColor = [UIColor colorWithHex:0xff9418].CGColor;
            badgeView.layer.borderColor = [UIColor whiteColor].CGColor;
            badgeView.hidden = YES;
            badgeView.textColor = [UIColor whiteColor];
            badgeView.font = V3_28PX_FONT;
            badgeView.layer.masksToBounds = YES;
            badgeView.textAlignment = NSTextAlignmentCenter;
            badgeView.centerX = view.right-5;
            badgeView.centerY = view.top+10;
        }
        
        [back addSubview:badgeView];
        return back;
    }
}
#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        self.tableView.tableHeaderView = [self createHeaderView];
        currentServerStatus = @"2";
    }else{
        
        self.tableView.tableHeaderView = nil;
        currentServerStatus = @"1";
    }
    
    [self addEmptyView:currentServerStatus];
    [self.tableView reloadData];
}
#pragma mark -侧滑出个人中心页面
- (void)backEvent:(UIBarButtonItem *)paramItem
{
    if (ApplicationDelegate.showingRootController == YES) {
        [ApplicationDelegate.menuController showLeftController:YES];
    } else{
        [ApplicationDelegate.menuController showRootController:YES];
    }
    ApplicationDelegate.showingRootController = !ApplicationDelegate.showingRootController;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end