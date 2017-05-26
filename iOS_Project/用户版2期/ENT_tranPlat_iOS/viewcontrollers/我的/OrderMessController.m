//
//  OrderMessController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/13.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderMessController.h"
#import "OrderDetailController.h"
#import "OrderContentController.h"
#import "OrderRefoundController.h"
#import "OrderCommentViewController.h"
#import "OrderPayViewController.h"
#import "OrderStateController.h"
#import "OrderCell.h"

@interface OrderMessController ()<UITableViewDataSource,UITableViewDelegate,OrderCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation OrderMessController
{
    NSInteger _page;
    UIImageView *_icon;
    UILabel *_alertLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self->_navImgView removeFromSuperview];
    [self.navigationController.navigationBar addSubview:self->_navImgView];
    NSString *title = @"全部订单";
    switch (_demandType) {
        case DemandWaittingForPay:
            title = @"待付款";
            break;
        case DemandWaittingForService:
            title = @"待服务";
            break;
        case DemandWaittingForComment:
            title = @"待评论";
            break;
        case DemandRefund:
            title = @"退款";
        default:
            break;
    }
    
    [self setNavTitle:title];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self->_navImgView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/2, APP_WIDTH/378*300/2)];
    _icon.center = self.view.boundsCenter;
    _icon.image = [UIImage imageNamed:@"没有新订单图标"];
    _icon.hidden = YES;
    _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _icon.bottom+50*y_6_plus, APP_WIDTH, 34*y_6_plus)];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.font = V3_38PX_FONT;
    _alertLabel.textColor = kTextGrayColor;
    _alertLabel.text = @"没有相关订单哦，亲";
    _alertLabel.hidden = YES;
    
    _page = 1;
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:_icon];
    [self.view addSubview:_alertLabel];
    [UITools showIndicatorToView:self.view];
    [self requestData:MJRefreshTypeNone];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    _tableView.header.updatedTimeHidden = YES;
    _tableView.footer.hidden = YES;
    
    return _tableView;
}

- (void)headerRefreshing{
    _page = 1;
    [self requestData:MJRefreshTypeHeader];
}

- (void)footerRefreshing{
    _page += 1;
    [self requestData:MJRefreshTypeFooter];
}

- (void)requestData:(MJRefreshType)refreshType{
    _icon.hidden = _alertLabel.hidden = YES;
    NSString *status = @"";
    switch (_demandType) {
        case DemandWaittingForPay:
            status = @"0";
            break;
        case DemandWaittingForService:
            status = @"1";
            break;
        case DemandWaittingForComment:
            status = @"3";
            break;
        case DemandRefund:
            status = @"-2";
            
        default:
            break;
    }
    [[NetworkEngine sharedNetwork] postBody:@{@"status":status,@"role":@"0",@"page":@(_page),@"rows":@"10",@"account":APP_DELEGATE.userName} apiPath:kOrderAllURL hasHeader:YES finish:^(ResultState state, id resObj) {
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (state == StateSucceed) {
            if (!self.dataSource) {
                self.dataSource = [@[] mutableCopy];
            }
            if (refreshType != MJRefreshTypeFooter) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:resObj[@"body"][0][@"orderList"]];
            self.tableView.footer.hidden = [[resObj[@"body"][0][@"orderList"] analysisConvertToArray] count] < 10;
            [self.tableView reloadData];
        }
        if (!self.dataSource.count) {
            _icon.hidden = _alertLabel.hidden = NO;
        }else{
            _icon.hidden = _alertLabel.hidden = YES;
        }
    } failed:^(NSError *error) {
        if (!self.dataSource.count) {
            _icon.hidden = _alertLabel.hidden = NO;
        }else{
            _icon.hidden = _alertLabel.hidden = YES;
        }
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - OrderCellDelegate
- (void)orderForPaying:(OrderCell *)cell{
    OrderPayViewController *ovc = [[OrderPayViewController alloc]init];
    ovc.commplete = ^{
        [self.tableView reloadData];
    };
//    ovc.consumerCode = _consumerCode;
    ovc.orderNo = cell.orderNo;
    ovc.orderId = cell.orderId;
    ovc.bookingTime = cell.bookingTime;
    ovc.merchant = cell.merchantName;
    ovc.merchantAddress = cell.merchantAddress;
    ovc.merchantPhone = cell.merchantPhone;
    
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)orderCancle:(OrderCell *)cell{
    [UITools alertWithMsg:@"是否确认取消订单" viewController:self confirmAction:^{
        [UITools showIndicatorToView:self.view];
        [[NetworkEngine sharedNetwork] postBody:@{@"orderNo":cell.orderNo,@"orderId":cell.orderId} apiPath:kOrderCancleURL hasHeader:YES finish:^(ResultState state, id resObj) {
            [UITools hideHUDForView:self.view];
            if (state == StateSucceed) {
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            }
        } failed:^(NSError *error) {
            [UITools hideHUDForView:self.view];
        }];
    } cancelAction:nil];
}

- (void)orderRefound:(OrderCell *)cell{
    OrderRefoundController *ovc = [[OrderRefoundController alloc]init];
    ovc.orderId = cell.orderId;
    ovc.orderNo = cell.orderNo;
    ovc.commplete = ^{
        [UITools showIndicatorToView:self.view];
        [self requestData:MJRefreshTypeNone];
    };
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)orderConfirmFininshed:(OrderCell *)cell{
    [UITools alertWithMsg:@"是否确认完成订单" viewController:self confirmAction:^{
        [UITools showIndicatorToView:self.view];
        [[NetworkEngine sharedNetwork] postBody:@{@"orderNo":cell.orderNo,@"orderId":cell.orderId} apiPath:kOrderFinishURL hasHeader:YES finish:^(ResultState state, id resObj) {
            [UITools hideHUDForView:self.view];
            if (state == StateSucceed) {
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            }else{
                
            }
        } failed:^(NSError *error) {
            [UITools hideHUDForView:self.view];
        }];
    } cancelAction:^{
        
    }];
}

- (void)orderWattingForComment:(OrderCell *)cell{
    OrderCommentViewController *ovc = [[OrderCommentViewController alloc]init];
    ovc.orderId = cell.orderId;
    ovc.commplete = ^{
        [UITools showIndicatorToView:self.view];
        [self requestData:MJRefreshTypeNone];
    };
    [self.navigationController pushViewController:ovc animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20*y_6_plus;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 502*y_6_plus;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.delegate = self;
    cell.merchantAddress = self.dataSource[indexPath.section][@"merchantAddress"];
    cell.merchantName = self.dataSource[indexPath.section][@"merchantName"];
    cell.merchantPhone = self.dataSource[indexPath.section][@"merchantPhone"];
    cell.bookingTime = self.dataSource[indexPath.section][@"bookingTime"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[indexPath.section]];
    [dic setObject:@(indexPath.section) forKey:@"section"];
    [cell configCellWithDic:dic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderContentController *cvc = [[OrderContentController alloc]init];
    cvc.orderNo = self.dataSource[indexPath.section][@"orderNo"];
    cvc.orderId = self.dataSource[indexPath.section][@"id"];
    NSString *status = self.dataSource[indexPath.section][@"status"];
    switch ([status integerValue]) {
        case 0:
        {
            cvc.commplete = ^{
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            };
            cvc.commplete0 = ^{
                [self.tableView reloadData];
            };
        }
            break;
        case 1:
        {
            cvc.commplete = ^{
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            };
        }
            break;
        case 2:
        {
            cvc.commplete = ^{
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            };
            cvc.commplete0 = ^{
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            };
        }
            break;
        case 3:
        {
            cvc.commplete = ^{
                [UITools showIndicatorToView:self.view];
                [self requestData:MJRefreshTypeNone];
            };
        }
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
