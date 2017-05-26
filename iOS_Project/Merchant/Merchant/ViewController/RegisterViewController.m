//
//  RegisterViewController.m
//  Merchant
//
//  Created by xinpenghe on 15/12/22.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSelectViewController.h"
#import "RegisterInfoCell.h"
#import "RegisterDescribeCell.h"
#import "RegisterPhotoCell.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISegmentedControl *segmet;
@property (nonatomic, strong)UIButton *registerBtn;
@property (nonatomic, strong)NSArray *dataSources;
@property (nonatomic, assign)BOOL disappar;

@end

static NSString *InfoCell = @"Infocell";
static NSString *describeCell = @"describeCell";
static NSString *photoCell = @"photoCell";

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSources = @[@{@"name":@"全称",@"select":@"0"},
                     @{@"name":@"地址",@"select":@"0"},
                     @{@"name":@"联系人",@"select":@"0"},
                     @{@"name":@"电话号",@"select":@"0"},
                     @{@"name":@"手机号",@"select":@"0"},
                     @{@"name":@"支付账号类型",@"select":@"1"},
                     @{@"name":@"支付账号",@"select":@"0"},
                     @{@"name":@"所属城市",@"select":@"1"},
                     ];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    if (_disappar) {
        _segmet.hidden = _registerBtn.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if (_disappar) {
        _segmet.hidden = _registerBtn.hidden = YES;
    }else{
        [_segmet removeFromSuperview];
        [_registerBtn removeFromSuperview];
    }
}

- (void)configUI{
    //segment
    _segmet = [[UISegmentedControl alloc]initWithItems:@[@"企业",@"个人"]];
    _segmet.frame = LGRectMake(0, 0, 192, 24);
    _segmet.selectedSegmentIndex = 0;
    _segmet.center = self.navigationController.navigationBar.boundsCenter;
    _segmet.tintColor = [UIColor orangeColor];
    [_segmet addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:_segmet];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn addTarget:self action:@selector(nextRegister)];
    [_registerBtn addBorderWithWidth:1 color:[UIColor lightGrayColor] corner:8];
    _registerBtn.frame = LGRectMake(0, 0, 50, 24);
    _registerBtn.titleLabel.font = SYS_FONT_SIZE(15);
    [_registerBtn setTitle:@"注册"];
    [_registerBtn setTitleColor:[UIColor lightGrayColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_registerBtn];
    
    //tableView
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:LGRectMake(0, 0, self.view.width/PX_X_SCALE, (self.view.height-APP_TAB_HEIGHT-APP_NAV_HEIGHT)/PX_X_SCALE) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[RegisterInfoCell class] forCellReuseIdentifier:InfoCell];
    [_tableView registerClass:[RegisterDescribeCell class] forCellReuseIdentifier:describeCell];
    [_tableView registerClass:[RegisterPhotoCell class] forCellReuseIdentifier:photoCell];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    return _tableView;
}

#pragma mark - event method

- (void)selectSegment:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        _dataSources = @[@{@"name":@"全称",@"select":@"0"},
                         @{@"name":@"地址",@"select":@"0"},
                         @{@"name":@"联系人",@"select":@"0"},
                         @{@"name":@"电话号",@"select":@"0"},
                         @{@"name":@"手机号",@"select":@"0"},
                         @{@"name":@"支付账号类型",@"select":@"1"},
                         @{@"name":@"支付账号",@"select":@"0"},
                         @{@"name":@"所属城市",@"select":@"1"},
                         ];
        [self.tableView reloadData];
    }else{
        _dataSources = @[@{@"name":@"姓名",@"select":@"0"},
                         @{@"name":@"手机号",@"select":@"0"},
                         @{@"name":@"支付账号类型",@"select":@"1"},
                         @{@"name":@"支付账号",@"select":@"0"},
                         @{@"name":@"所属省市",@"select":@"1"},
                         ];
        [self.tableView reloadData];
    }
}

- (void)nextRegister{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate & UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_segmet.selectedSegmentIndex == 0) {
        return _dataSources.count+1;
    }
    return _dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_segmet.selectedSegmentIndex == 0) {
        if (indexPath.section < 8) {
            return 31*PX_Y_SCALE;
        }else if (indexPath.section == 8){
            return 66*PX_Y_SCALE;
        }
        
        return 200*PX_Y_SCALE;
    }else{
        if (indexPath.section < 5) {
            return 31*PX_Y_SCALE;
        }
        
        return 200*PX_Y_SCALE;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_segmet.selectedSegmentIndex == 0) {
        if (indexPath.section < 8) {
            RegisterInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCell];
            if (!cell) {
                cell = [[RegisterInfoCell alloc]init];
            }
            [cell configInfoWithDic:_dataSources[indexPath.section]];
            __block typeof(self) weakSelf = self;
            cell.commplete = ^(NSString *title){
                RegisterSelectViewController *svc = [[RegisterSelectViewController alloc]init];
                _disappar = YES;
                [weakSelf.navigationController pushViewController:svc animated:YES];
            };
            
            return cell;
        }else if (indexPath.section == 8){
            RegisterDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:describeCell];
            if (!cell) {
                cell = [[RegisterDescribeCell alloc]init];
            }
            
            return cell;
        }
        
        return nil;
    }else{
        if (indexPath.section < 5) {
            RegisterInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCell];
            if (!cell) {
                cell = [[RegisterInfoCell alloc]init];
            }
            [cell configInfoWithDic:_dataSources[indexPath.section]];
            __block typeof(self) weakSelf = self;
            cell.commplete = ^(NSString *title){
                RegisterSelectViewController *svc = [[RegisterSelectViewController alloc]init];
                _disappar = YES;
                [weakSelf.navigationController pushViewController:svc animated:YES];
            };
            
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell addBorderWithWidth:1 color:[UIColor lightGrayColor] corner:8];
}

@end
