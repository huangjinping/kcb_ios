//
//  RecommendMer.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/23.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "RecommendMer.h"
#import "ServiceCell.h"
#import "OutDetailViewController.h"

@implementation RecommendMer
{
    NSInteger _page;
    UIImageView *_icon;
    UILabel *_alertLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"推荐商户"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/2, APP_WIDTH/378*300/2)];
    _icon.center = self.view.boundsCenter;
    _icon.image = [UIImage imageNamed:@"没有新订单图标"];
    _icon.hidden = YES;
    _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _icon.bottom+50*y_6_plus, APP_WIDTH, 34*y_6_plus)];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.font = V3_38PX_FONT;
    _alertLabel.textColor = kTextGrayColor;
    _alertLabel.text = @"没有推荐的商户哦，亲";
    _alertLabel.hidden = YES;
    _page = 1;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.footer.hidden = YES;
    self.tableView.rowHeight = 300*y_6_plus;
    
    [self.view addSubview:_icon];
    [self.view addSubview:_alertLabel];
    [UITools showIndicatorToView:self.view];
    [self prepareData:MJRefreshTypeNone];
}

- (void)prepareData:(MJRefreshType)refreshType{
    _icon.hidden = _alertLabel.hidden = YES;
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    NSString *code = [u objectForKey:KEY_CITY_ADCODE_IN_USERDEFAULT];
    [[NetworkEngine sharedNetwork] postBody:@{@"cityCode":code,@"order":@"h",@"page":@(_page),@"rows":@"10"} apiPath:kRecommnedMerURL hasHeader:YES finish:^(ResultState state, id resObj) {
        
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (state == StateSucceed) {
            if (!self.dataSource) {
                self.dataSource = [NSMutableArray array];
            }
            if (refreshType != MJRefreshTypeFooter) {
                [self.dataSource removeAllObjects];
            }
            
            [self.dataSource addObjectsFromArray:[resObj[@"body"][@"merList"] analysisConvertToArray]];
            
            self.tableView.footer.hidden = [[resObj[@"body"][@"merList"] analysisConvertToArray] count] < 10;
            if (!self.dataSource.count) {
                _icon.hidden = _alertLabel.hidden = NO;
            }else{
                _icon.hidden = _alertLabel.hidden = YES;
            }
            [self.tableView reloadData];
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

- (void)headerRefreshing{
    _page = 1;
    [self prepareData:MJRefreshTypeHeader];
}

- (void)footerRefreshing{
    _page += 1;
    [self prepareData:MJRefreshTypeFooter];
}


//- (void)requestData:(MJRefreshType)refreshType{
//    _icon.hidden = _alertLabel.hidden = YES;
//    [UITools showIndicatorToView:self.view];
//    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
//    NSString *code = [u objectForKey:KEY_CITY_ADCODE_IN_USERDEFAULT];
//    [[NetworkEngine sharedNetwork] postBody:@{@"cityCode":code,@"order":@"h",@"page":@(_page),@"rows":@"10"} apiPath:kRecommnedMerURL hasHeader:YES finish:^(ResultState state, id resObj) {
//        [UITools hideHUDForView:self.view];
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
//        if (state == StateSucceed) {
//            if (self.dataSource) {
//                self.dataSource = [NSMutableArray array];
//            }
//            if (refreshType != MJRefreshTypeFooter) {
//                [self.dataSource removeAllObjects];
//            }
//
//            [self.dataSource addObjectsFromArray:[resObj[@"body"][@"merList"] analysisConvertToArray]];
//            
//            self.tableView.footer.hidden = [[resObj[@"body"][@"merList"] analysisConvertToArray] count] < 10;
//            if (!self.dataSource.count) {
//                _icon.hidden = _alertLabel.hidden = NO;
//            }else{
//                _icon.hidden = _alertLabel.hidden = YES;
//            }
//            [self.tableView reloadData];
//        }
//    } failed:^(NSError *error) {
//        if (!self.dataSource.count) {
//            _icon.hidden = _alertLabel.hidden = NO;
//        }else{
//            _icon.hidden = _alertLabel.hidden = YES;
//        }
//        [UITools hideHUDForView:self.view];
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
//    }];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"servieCellId"];
    if (!cell) {
        cell = [[ServiceCell alloc] init];
    }
    [cell configCellWithDic:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OutDetailViewController *ovc = [[OutDetailViewController alloc]init];
    
    ovc.jwd = self.dataSource[indexPath.row][@"jwd"];
    ovc.merid = self.dataSource[indexPath.row][@"id"];
    ovc.hiddenFooter = YES;

    [self.navigationController pushViewController:ovc animated:YES];
}

@end
