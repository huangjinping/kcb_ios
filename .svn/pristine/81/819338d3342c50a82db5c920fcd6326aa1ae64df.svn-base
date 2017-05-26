//
//  OrderStateController.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/3.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderStateController.h"
#import "OrderStateCell.h"

@interface OrderStateController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

static NSString *cellId = @"cellId";

@implementation OrderStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self request];
}

-(UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 70*y_6_plus)];
    _tableView.tableHeaderView = headerV;
    [_tableView registerClass:[OrderStateCell class] forCellReuseIdentifier:cellId];
//    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    return _tableView;
}

//- (void)headerRefreshing{
//    [self request];
//}

- (void)request{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    [_dataSource removeAllObjects];
    [UITools showIndicatorToView:self.view];
    [[NetworkEngine sharedNetwork] postBody:@{@"orderId":_orderId,@"orderNo":_orderNo} apiPath:kOrderDetailURL hasHeader:YES finish:^(ResultState state, id resObj) {
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        if (state == StateSucceed) {
            [_dataSource addObjectsFromArray:resObj[@"body"][0][@"orderstatusList"]];
            [self.tableView reloadData];
        }
//        if (_commplete) {
//            _commplete(_dataSource);
//        }
    } failed:^(NSError *error) {
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 230*y_6_plus;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[OrderStateCell alloc]init];
    }
    if (indexPath.row == 0) {
        cell.icon.selected = YES;
        if (_dataSource.count>1) {
            cell.line.hidden = NO;
        }
    }else{
        cell.icon.selected = NO;
        cell.line.hidden = NO;
    }
    if (indexPath.row == _dataSource.count-1) {
        cell.line.hidden = YES;
    }
    [cell configWithDic:_dataSource[indexPath.row]];
    
    return cell;
}
@end
