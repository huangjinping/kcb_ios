//
//  BaseTableViewController.h
//  RongChuang
//
//  Created by yzk on 15/4/8.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableViewController :BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end
