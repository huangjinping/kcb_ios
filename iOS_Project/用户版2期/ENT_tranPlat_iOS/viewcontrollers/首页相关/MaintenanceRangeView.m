//
//  MaintenanceRangeView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MaintenanceRangeView.h"

@implementation MaintenanceRangeView
{
    UITableView *_tableView;
}
+ (MaintenanceRangeView *)shareMainRangeView{
    MaintenanceRangeView *mv = [[MaintenanceRangeView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 0)];
    
    return mv;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self addSubview:_tableView];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _tableView.height = self.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
