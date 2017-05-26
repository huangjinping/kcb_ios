//
//  BaseTableViewController.m
//  RongChuang
//
//  Created by yzk on 15/4/8.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
@end
