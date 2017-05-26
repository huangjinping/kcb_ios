//
//  CarPartListController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/8.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "CarPartListController.h"
#import "FittingsCell.h"
#import "ChangWaresCell.h"
#import "CarPartListView.h"

@interface CarPartListController ()

@end

static NSString *cellId = @"cellId";
static const CGFloat tag = 999;

@implementation CarPartListController
{
    CarPartListView *_cv;
    UIImageView *_icon;
    UILabel *_alertLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"零件列表"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _cv = [CarPartListView sharePartListView];
    __weak __typeof(_cv) weakCV = _cv;
    __block __typeof(self) weakSelf = self;
    _cv.commplete = ^{
        [weakCV showInView:weakSelf.view];
    };
    _cv.block = ^(NSString *brandId){
        NSMutableArray *dataSource = [weakSelf.dataSource mutableCopy];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"brandId == %@",brandId];
        NSMutableArray *arr = [[weakSelf.dataSource filteredArrayUsingPredicate:predicate] mutableCopy];
        weakSelf.dataSource = arr;
        [weakSelf.tableView reloadData];                                //注意UITableView是异步刷新
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            weakSelf.dataSource = dataSource;
        });
    };
    _cv.origin = CGPointMake(0, APP_VIEW_Y);
    [self.view addSubview:_cv];
    self.tableView.tag = tag;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y = _cv.bottom;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.height -= _cv.height;
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH/2, APP_WIDTH/378*300/2)];
    _icon.center = self.view.boundsCenter;
    _icon.image = [UIImage imageNamed:@"没有新订单图标"];
    _icon.hidden = YES;
    _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _icon.bottom+50*y_6_plus, APP_WIDTH, 34*y_6_plus)];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.font = V3_38PX_FONT;
    _alertLabel.textColor = kTextGrayColor;
    _alertLabel.text = @"没有相关配件哦，亲";
    _alertLabel.hidden = YES;
    
    [self.view addSubview:_icon];
    [self.view addSubview:_alertLabel];
}

- (void)requestData:(MJRefreshType)refreshType{
    _icon.hidden = _alertLabel.hidden = YES;
    [UITools showIndicatorToView:self.view];
    [[NetworkEngine sharedNetwork] postBody:@{@"page":@(self.page),@"rows":@"10",@"carid":_carid,@"volume":_volume,@"merid":_merid,@"groupid":_groupid} apiPath:kCarPortListURL hasHeader:YES finish:^(ResultState state, id resObj) {
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        if (state == StateSucceed) {
            if (refreshType != MJRefreshTypeFooter) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:resObj[@"body"][@"comList"]];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in self.dataSource) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"brandName == %@",dic[@"brandName"]];
                NSArray *arr = [mArr filteredArrayUsingPredicate:predicate];
                if (!arr.count) {
                    [mArr addObject:dic];
                }
            }
            _cv.dataSource = mArr;
            self.tableView.footer.hidden = [[resObj[@"body"][@"comList"] analysisConvertToArray] count] <= 10;
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
    }];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 245*y_6_plus;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChangWaresCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ChangWaresCell alloc]init];
    }
    [cell configCellWithDic:self.dataSource[indexPath.row]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_commplete) {
        _commplete(self.dataSource[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
