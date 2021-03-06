//
//  OrderDetailController.m
//  Merchant
//
//  Created by Wendy on 16/1/12.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCell.h"
#import "MEOrderInfo.h"
#import <MJExtension.h>
#import "OrderManHourCell.h"
#import "CWStarRateView.h"
#import "OrderAppraiseCell.h"
#import <UIImageView+WebCache.h>
#import "BOAlertController.h"

#define SectionTwoHeaderHeight 175
#define SectionTwoHeaderTopHeight 50
#define SectionTwoHeaderMarginLeft 15
#define SectionTwoHeaderLabelWidth 120

#define BottomViewHeight 50

typedef enum : NSUInteger {
    FooterButtonConfirm = 0,
    FooterButtonReceive,
    FooterButtonContact,
} FooterButtonTag;


@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    UIView *tableFooterView;
}
@property (nonatomic,strong)UILabel *headerViewLabel;
@property (nonatomic,strong)NSArray *orderInfoList;
@property (nonatomic,strong)NSArray *customInfoList;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)MEOrderInfo *orderInfo;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"订单详情"];
    // Do any additional setup after loading the view.
    [self buildUI];
    
    [self requestOrderDetail];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [tableFooterView removeFromSuperview];
}
- (void)buildUI{
    
    self.orderInfoList = @[@{@"订单号":@""},
                           @{@"车型":@""},
                           @{@"订单状态":@""}
                           ];
    self.customInfoList = @[@{@"客户昵称":@""},
                            @{@"联系电话":@""},
                            @{@"预约时间":@""},
                            @{@"下单时间":@""},
                            @{@"支付时间":@""},
                            @{@"服务完成时间":@""},
                            @{@"服务方式":@""}
                            ];


    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - APP_NAV_HEIGHT - APP_STATUS_BAR_HEIGHT-BottomViewHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = RGB(234, 234, 234);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    _headerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 45)];
    _headerViewLabel.backgroundColor = [UIColor colorWithHex:0xfdf7d6];
    _headerViewLabel.textColor = [UIColor colorWithHex:0xff9419];
    _headerViewLabel.textAlignment = NSTextAlignmentCenter;
    _headerViewLabel.text = @"消费未验证";
    _headerViewLabel.font = V3_36PX_FONT;
    self.tableView.tableHeaderView = _headerViewLabel;
    
    tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHT-BottomViewHeight, APP_WIDTH, BottomViewHeight)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:tableFooterView];
    
}
- (void)requestOrderDetail{
    
    NSDictionary *param = @{@"orderNo":_orderNo?_orderNo:@"",
                            @"orderId":_orderId?_orderId:@"",
                            @"consumerCode":_consumerCode?_consumerCode:@""};
    [AFNHttpRequest afnHttpRequestUrl:kHttpOrderInfo param:param success:^(id responseObject) {
        if (kRspCode(responseObject) != 0) {
            [UIHelper alertWithMsg:kRspMsg(responseObject)];
            return ;
        }
        NSDictionary *dict = responseObject[@"body"][0];
        self.orderInfo  = [MEOrderInfo mj_objectWithKeyValues:dict];
        [self buildData:self.orderInfo];
        
        if (_consumerCode.length > 0) {//消费验证流程进入详情
            RIButtonItem *cancleItem = [RIButtonItem itemWithLabel:@"取消"
                                                                  type:RIButtonItemType_Cancel
                                                                action:^{
                                                                    //??????
                                                                }];
            RIButtonItem *confirmItem = [RIButtonItem itemWithLabel:@"验证"
                                                                       type:RIButtonItemType_Destructive
                                                                     action:^{
                                                                         [self dealConsumerCode];
                                                                     }];
            BOAlertController *alert = [[BOAlertController alloc] initWithTitle:@"温馨提示"
                                                                            message:@"是否验证消费"
                                                                     viewController:self];
            [alert addButtons:@[cancleItem,confirmItem]];
            [alert show];

        }

    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}
#pragma mark - 消费码验证
- (void)dealConsumerCode{
    NSInteger merchantId = ApplicationDelegate.shareLoginData.userdata.mid;
    
    NSDictionary *param = @{@"consumerCode":BLANK(_consumerCode),@"merchantId":[NSNumber numberWithInteger:merchantId].stringValue,@"type":@"1"};
    
    [AFNHttpRequest afnHttpRequestUrlNonHub:kHttpDealConsumer param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            _headerViewLabel.text = @"消费已验证";
            [self reConfirmOrderRequest];
            [UIHelper alertWithMsg:@"消费验证成功"];
        }else{
            [UIHelper alertWithMsg:kRspMsg(responseObject)];
        }
    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}

#pragma mark - 订单验证完之后，刷新界面
- (void)reConfirmOrderRequest{
    NSDictionary *param = @{@"orderNo":_orderNo?_orderNo:@"",
                            @"orderId":_orderId?_orderId:@"",
                            @"consumerCode":_consumerCode?_consumerCode:@""};
    [AFNHttpRequest afnHttpRequestUrlNonHub:kHttpOrderInfo param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            NSDictionary *dict = responseObject[@"body"][0];
            self.orderInfo  = [MEOrderInfo mj_objectWithKeyValues:dict];
            [self buildData:self.orderInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderList" object:@"2"];//传入参数2，重新刷新首页中的代办订单
        }else{
            [UIHelper alertWithMsg:kRspMsg(responseObject)];
        }

    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}
- (void)buildData:(MEOrderInfo *)orderInfo{

    self.orderInfoList = @[@{@"订单号":orderInfo.order.orderNo?orderInfo.order.orderNo:@""},
                           @{@"车型":orderInfo.order.carName?orderInfo.order.carName:@""},
                           @{@"订单状态":[Utils getStatusNameType:2 statusId:orderInfo.order.status]}
                           ];
    self.customInfoList = @[@{@"客户昵称":BLANK(orderInfo.order.name)},
                            @{@"联系电话":BLANK(orderInfo.order.phoneNo)},
                            @{@"预约时间":BLANK(orderInfo.order.bookingTime)},
                            @{@"下单时间":BLANK(orderInfo.order.submitTime)},
                            @{@"支付时间":BLANK(orderInfo.order.payTime)},
                            @{@"服务完成时间":BLANK(orderInfo.order.successTime)},
                            @{@"服务方式":BLANK(@"驾车到店")}
                            ];
    
    NSString *value = @"1";
    if (orderInfo.order.consumer.count > 0) {
        Consumer * item = orderInfo.order.consumer[0];
        value = item.status;
    }
    
    _headerViewLabel.text = value.intValue == 1?@"消费未验证":@"消费已验证";
    
    [self createFooterView];

    [self.tableView reloadData];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 88;
    }else if(indexPath.section == 4){
        CGFloat margin = 25;
        CGFloat width = (APP_WIDTH - margin*5)/4;

        return width + 2*margin;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }else if (section == 2) {
        return 0.01f;
    }else if(section == 3){
        return 70;
    }
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return  [self createManHourFooterView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }else if(section == 2){
        return 175;
    }else if(section == 3){
        return 2;
    }else if(section == 4){
        NSArray *list = _orderInfo.evaluationList;
        if (list.count == 0) {
            return 0.01f;
        }
        Evaluationlist *evaluation = _orderInfo.evaluationList[0];
        CGFloat contentHeight = [Utils getHeightByTextContent:evaluation.text fontSize:18 space:25];
        return contentHeight+80;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return [self createPartsHeaderView];
    }else if(section == 3)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 2)];
        view.backgroundColor = kColor0X39B44A;
        return view;
    }else if(section == 4){
        if ( _orderInfo.evaluationList.count > 0) {
            return [self createAppraiseHeaderView];
        }
    }

    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.orderInfoList.count;
    }else if(section == 1){
        return self.customInfoList.count;
    }else if(section == 2){
        return _orderInfo.suborderdetailList.count;
    }else if(section == 3){
        return _orderInfo.serviceList.count;
    }else if(section == 4){
        if (_orderInfo.evaluationList.count > 0) {
            Evaluationlist * obj = _orderInfo.evaluationList[0];
            return obj.evaluationpicList.count ? 1: 0;
        }else{
            return 0;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *identifier = @"OrderDetailCell";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        Suborderdetaillist *item = _orderInfo.suborderdetailList[indexPath.row];
        NSString *allUrl = item.url;
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:allUrl] placeholderImage:[UIImage imageNamed:@"shopDefault_small"]];
        [cell setRightLabelPrice:item.salePrice amount:item.componentNum];
        cell.mainLabel.text = item.componentName;
        cell.subTitleLabel.text = item.componetBrand;
        return cell;

    }else if(indexPath.section == 3){
        static NSString *identifier = @"OrderManHourCell";
        OrderManHourCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[OrderManHourCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        Servicelist *item = _orderInfo.serviceList[indexPath.row];
        cell.titleLabel.text = item.serviceName;
        cell.manHourLabel.text = [NSString stringWithFormat:@"¥%.2f",item.workHoursPrice];
        
        return cell;

    }else if(indexPath.section == 4){
        static NSString *identifier = @"OrderAppraiseCell";
        OrderAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[OrderAppraiseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //????????????????
        Evaluationlist * obj = _orderInfo.evaluationList[0];
        if(obj.evaluationpicList.count ==  1){
            cell.image1.image = [UIImage imageNamed:@"增加照片"];
        }else if(obj.evaluationpicList.count ==  2){
            cell.image1.image = [UIImage imageNamed:@"增加照片"];
            cell.image2.image = [UIImage imageNamed:@"增加照片"];

        }else if(obj.evaluationpicList.count ==  3){
            cell.image1.image = [UIImage imageNamed:@"增加照片"];
            cell.image2.image = [UIImage imageNamed:@"增加照片"];
            cell.image3.image = [UIImage imageNamed:@"增加照片"];
        }else if(obj.evaluationpicList.count ==  4){
            cell.image1.image = [UIImage imageNamed:@"增加照片"];
            cell.image2.image = [UIImage imageNamed:@"增加照片"];
            cell.image3.image = [UIImage imageNamed:@"增加照片"];
            cell.image4.image = [UIImage imageNamed:@"增加照片"];
        }

        return cell;

    }
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        cell.textLabel.textColor = kColor0X949694;
        cell.detailTextLabel.textColor = kColor0X666666;
        cell.textLabel.font = V3_36PX_FONT;
        cell.detailTextLabel.font = V3_36PX_FONT;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.orderInfoList[indexPath.row] allKeys].lastObject;
        cell.detailTextLabel.text = [self.orderInfoList[indexPath.row] allValues].lastObject;;
        
    }else if(indexPath.section == 1){
        cell.textLabel.text = [self.customInfoList[indexPath.row] allKeys].lastObject;
        cell.detailTextLabel.text = [self.customInfoList[indexPath.row] allValues].lastObject;;

    }
    return cell;
}
#pragma mark -配件heaerview
- (UIView *)createPartsHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, SectionTwoHeaderHeight)];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SectionTwoHeaderMarginLeft, 0, SectionTwoHeaderLabelWidth, SectionTwoHeaderTopHeight)];
    leftLabel.text = @"自助保养";
    leftLabel.font = V3_38PX_FONT;
    leftLabel.textColor = kColor0X39B44A;
    [view addSubview:leftLabel];
    
    [view addLineWithFrame:CGRectMake(0, SectionTwoHeaderTopHeight-1, APP_WIDTH, 1) lineColor:RGB(163, 208, 165)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SectionTwoHeaderMarginLeft, leftLabel.bottom+15, 20, 20)];
    imageView.image = [UIImage imageNamed:@"shop"];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+5, leftLabel.bottom, 170, 50)];
    Suborder *subOrder = nil;
    if (_orderInfo.suborder.count > 0) {
        subOrder = _orderInfo.suborder[0];
    }
    nameLabel.text = subOrder.channelName;
    nameLabel.font = V3_36PX_FONT;
    [view addSubview:nameLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.width - SectionTwoHeaderLabelWidth-SectionTwoHeaderMarginLeft, nameLabel.top, SectionTwoHeaderLabelWidth, 50)];
    phoneLabel.text = subOrder.channelMobile;
    phoneLabel.font = V3_36PX_FONT;
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:phoneLabel];
    
    //发货状态
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, phoneLabel.bottom, SectionTwoHeaderLabelWidth, 35)];
    statusLabel.text = @"发货状态";
    statusLabel.font = V3_32PX_FONT;
    statusLabel.textColor = kColor0X666666;
    [view addSubview:statusLabel];
    
    UILabel *statusValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.left, phoneLabel.bottom, SectionTwoHeaderLabelWidth, 35)];
    //1：新订单 2：已接单、未发货 3：已发货、未收货4：已收货
    statusValueLabel.text = [Utils getStatusNameType:1 statusId:subOrder.status];
    statusValueLabel.textAlignment = NSTextAlignmentRight;
    statusValueLabel.font = V3_32PX_FONT;
    statusValueLabel.textColor = kColor0X39B44A;
    [view addSubview:statusValueLabel];
    
    //发货时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, statusLabel.bottom, SectionTwoHeaderLabelWidth, 35)];
    timeLabel.text = @"发货时间";
    timeLabel.font = V3_32PX_FONT;
    timeLabel.textColor = kColor0X666666;
    [view addSubview:timeLabel];
    
    UILabel *timeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusValueLabel.left-10, statusLabel.bottom, SectionTwoHeaderLabelWidth+25, 35)];
    timeValueLabel.text = subOrder.sendTime;
    timeValueLabel.textAlignment = NSTextAlignmentRight;
    timeValueLabel.font = V3_32PX_FONT;
    timeValueLabel.textColor = kColor0X666666;
    [view addSubview:timeValueLabel];
    return view;
}
#pragma mark - 评价headerview
- (UIView *)createAppraiseHeaderView{
    Evaluationlist *evaluation = _orderInfo.evaluationList[0];
    CGFloat topMargin = 0;
    CGFloat leftMargin = 25;
    CGFloat firstLineHeigth = 50;
    CGFloat lastLineHeight = 30;
    CGFloat contentHeight = [Utils getHeightByTextContent:evaluation.text fontSize:18 space:leftMargin];
    CGFloat heigth = topMargin + firstLineHeigth + contentHeight + lastLineHeight;
    
    //头像
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, heigth)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, topMargin+10, 30, 30)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:evaluation.headImage] placeholderImage:[UIImage imageNamed:@"menu_icon04"]];
    [view addSubview:headImage];
    
    //名字
    UILabel *nameLabel =[[UILabel alloc] initWithFrame:CGRectMake(headImage.right+10, 0, 140, firstLineHeigth)];
    nameLabel.text = _orderInfo.order.name;
    nameLabel.textColor = kColor0X949694;
    nameLabel.font = V3_32PX_FONT;
    [view addSubview:nameLabel];
    //好评
    UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.right - 130, nameLabel.top, 30, firstLineHeigth)];
    goodLabel.text = [self getAppraiseLevel:evaluation.type];
    goodLabel.textColor = kColor0XFF9418;
    goodLabel.font = V3_32PX_FONT;
    [view addSubview:goodLabel];
    
    //星级
    CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(goodLabel.right, goodLabel.top, 60, goodLabel.height) numberOfStars:5];
    starRateView.scorePercent = evaluation.level.floatValue/5;
    starRateView.allowIncompleteStar = YES;
    
    UILabel *gradeLab = [[UILabel alloc] initWithFrame:CGRectMake(starRateView.right+5, starRateView.top, 30, starRateView.height)];
    gradeLab.text = [NSString stringWithFormat:@"%@分",evaluation.level];
    gradeLab.font = V3_32PX_FONT;
    gradeLab.textColor = [UIColor colorWithHex:0xfac225];
    [view addSubview:gradeLab];
    [view addSubview:starRateView];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, goodLabel.bottom, APP_WIDTH-2*leftMargin, contentHeight)];
    contentLabel.text = evaluation.text;
    contentLabel.numberOfLines = 0;
    contentLabel.font = V3_36PX_FONT;
    contentLabel.textColor = kColor0X949694;
    [view addSubview:contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, contentLabel.bottom, APP_WIDTH-leftMargin, lastLineHeight)];
    timeLabel.textColor = RGB(193, 193, 193);
    timeLabel.text = evaluation.time;
    timeLabel.font = V3_28PX_FONT;
    [view addSubview:timeLabel];
    
    return view;
}
- (NSString *)getAppraiseLevel:(NSInteger)type{
    NSString *retValue;
    if (type == 2) {
        retValue = @"好评";
    }else if(type == 1){
        retValue = @"中评";
    }else{
        retValue = @"差评";
    }
    return retValue;
}
#pragma mark - 工时footerview
- (UIView *)createManHourFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 70)];
    footerView.backgroundColor = RGB(234, 234, 234);
    
    [footerView addLineWithFrame: CGRectMake(0, 0, APP_WIDTH, 1) lineColor:kLineColor];
    
    UIView *labelBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, APP_WIDTH, 59)];
    labelBackView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelBackView.width-10, labelBackView.height)];
    label.textAlignment = NSTextAlignmentRight;
    CGFloat price = _orderInfo.order.orderTotalPrice;
    NSString *string = [NSString stringWithFormat:@"实付：%.2f", price];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributedString addAttributes:@{ NSFontAttributeName: V3_36PX_FONT, NSForegroundColorAttributeName: kColor0XFF9418 } range:NSMakeRange(0, string.length)];
    
    [attributedString addAttributes:@{ NSFontAttributeName: V3_36PX_FONT, NSForegroundColorAttributeName: kColor0X949694 } range:NSMakeRange(0, 3)];
    
    label.attributedText = attributedString;
    [labelBackView addSubview:label];
    
    [footerView addSubview:labelBackView];
    [footerView addLineWithFrame:CGRectMake(0, label.bottom, footerView.width, 1) lineColor:kLineColor];
    return footerView;
}

#pragma mark - 根据订单状态、子订单状态显示footerview的按钮
- (void)createFooterView{
    [tableFooterView removeAllSubviews];
    NSString *orderStatus = _orderInfo.order.status;
    Suborder *subOrder = nil;
    if (_orderInfo.suborder.count > 0) {
        subOrder = _orderInfo.suborder[0];
    }
    NSString *subOrderStatus = subOrder.status;
    
    //确认接单
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = RGB(49, 169, 57);
    [confirmBtn setTitle:@"确认接单"];
    confirmBtn.tag = FooterButtonConfirm;
    [confirmBtn addTarget:self action:@selector(btnAction:)];
    [tableFooterView addSubview:confirmBtn];
    //收货
    UIButton *receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    receiveBtn.backgroundColor = RGB(49, 169, 57);
    [receiveBtn setTitle:@"收货"];
    receiveBtn.tag = FooterButtonReceive;
    [receiveBtn addTarget:self action:@selector(btnAction:)];
    [tableFooterView addSubview:receiveBtn];
    //联系买家
    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contactBtn.backgroundColor = RGB(49, 169, 57);
    [contactBtn setTitle:@"联系买家"];
    contactBtn.tag = FooterButtonContact;
    [contactBtn addTarget:self action:@selector(btnAction:)];
    [tableFooterView addSubview:contactBtn];
    
    CGFloat margin = 10.0f;
    CGFloat topMargin = 0;
    CGFloat btnHeight = 40;
    CGFloat btnWidth = 0;
    NSInteger btnCount = 0;
    
    if (orderStatus.integerValue == 1) {//有确认接单按钮
        if (subOrderStatus.integerValue == 3) {
            btnCount = 3;
            btnWidth = (APP_WIDTH-(btnCount+1)*margin)/btnCount;
            confirmBtn.frame = CGRectMake(margin, topMargin, btnWidth, btnHeight);
            receiveBtn.frame = CGRectMake(confirmBtn.right + margin, topMargin, btnWidth, btnHeight);
            contactBtn.frame = CGRectMake(receiveBtn.right + margin, topMargin, btnWidth, btnHeight);
            [tableFooterView addSubview:receiveBtn];

        }else{
            btnCount = 2;
            btnWidth = (APP_WIDTH-(btnCount+1)*margin)/btnCount;
            confirmBtn.frame = CGRectMake(margin, topMargin, btnWidth, btnHeight);
            contactBtn.frame = CGRectMake(confirmBtn.right + margin, topMargin, btnWidth, btnHeight);
        }
        
        [tableFooterView addSubview:confirmBtn];
        [tableFooterView addSubview:contactBtn];
        
    }else {//没有确认接单
        if (subOrderStatus.integerValue == 3) {
            btnCount = 2;
            btnWidth = (APP_WIDTH-(btnCount+1)*margin)/btnCount;
            receiveBtn.frame = CGRectMake(margin, topMargin, btnWidth, btnHeight);
            contactBtn.frame = CGRectMake(receiveBtn.right + margin, topMargin, btnWidth, btnHeight);
            [tableFooterView addSubview:receiveBtn];

        }else{
            btnCount = 1;
            btnWidth = (APP_WIDTH-(btnCount+1)*margin)/btnCount;
            contactBtn.frame = CGRectMake(margin, topMargin, btnWidth, btnHeight);
        }
        
        [tableFooterView addSubview:contactBtn];
    }

}

- (void)btnAction:(UIButton *)sender{
    NSInteger orderId = _orderInfo.order.ids;
    NSDictionary *param = @{@"orderNo":_orderInfo.order.orderNo,@"orderId":[NSNumber numberWithInteger:orderId].stringValue};

    if (sender.tag == FooterButtonConfirm) {
        [AFNHttpRequest afnHttpRequestUrl:kHttpSummitRecOrder param:param success:^(id responseObject) {
            if (kRspCode(responseObject) == 0) {//确认订单成功后，更新状态，刷新ui，并通过block刷新订单列表
                _orderInfo.order.status = @"2";
                [self createFooterView];
                _commplete(@"1");
                
            }else{
                [UIHelper alertWithMsg:kRspMsg(responseObject)];
            }
        } failure:^(NSError *error) {
            [UIHelper alertWithMsg:kNetworkErrorDesp];
        } view:self.view];
        
    }else if(sender.tag == FooterButtonReceive){
        [AFNHttpRequest afnHttpRequestUrl:kHttpRecComponet param:param success:^(id responseObject) {
            if (kRspCode(responseObject) == 0) {
                if (_orderInfo.suborder.count > 0) {//设置为已收获状态，重新刷新ui
                    Suborder *subOrder = _orderInfo.suborder[0];
                    subOrder.status = @"4";
                    [self createFooterView];
                }

            }else{
                [UIHelper alertWithMsg:kRspMsg(responseObject)];
            }

        } failure:^(NSError *error) {
            [UIHelper alertWithMsg:kNetworkErrorDesp];
        } view:self.view];

        
    }else if(sender.tag == FooterButtonContact){//联系买家
        //拨打电话
//        Suborder *subOrder = _orderInfo.suborder[0];
//        UIWebView*callWebview =[[UIWebView alloc] init];
//        NSString *telUrl = [NSString stringWithFormat:@"tel:%@",subOrder.channelMobile];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telUrl]]];
//        [self.view addSubview:callWebview];
        [UIHelper showText:@"该功能正在开发中，敬请期待" ToView:self.view];
    }
}
@end
