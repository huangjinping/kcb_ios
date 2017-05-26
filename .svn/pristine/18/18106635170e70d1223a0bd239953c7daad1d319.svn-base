//
//  BaseTableViewController.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) UITableViewStyle style;
@property (nonatomic, assign) NSInteger page;

- (void)requestData:(MJRefreshType)refreshType;

- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath*)index;

@end
