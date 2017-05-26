


//
//  BaseTableViewController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _page = 1;
        _style = UITableViewStylePlain;
        _dataSource = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self requestData:MJRefreshTypeNone];
}

- (void)setStyle:(UITableViewStyle)style{
    if (style == UITableViewStyleGrouped) {
        [_tableView removeFromSuperview];
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
    }
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
    
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    if (_style == UITableViewStylePlain) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT)];
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT) style:UITableViewStyleGrouped];
    }
    _tableView.backgroundColor = kWhiteColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
//    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    _tableView.header.updatedTimeHidden = YES;
    _tableView.footer.hidden = YES;
    
    return _tableView;
}

- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath*)index{

}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32*y_6_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    [self configCell:cell indexPath:indexPath];
    
    return cell;
}

@end
