//
//  MineViewController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/14.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MineViewController.h"
#import "OrderMessController.h"
#import "SettingViewController.h"
#import "MineOrderSortView.h"
#import "MineDetailCell.h"
#import "MinePersonCell.h"
#import "ScanViewController.h"
//#import "DealingRecordViewController.h"
//#import "NewDealingRecordViewController.h"
#import "NewDealingViewController.h"
#import "UserInfoViewController.h"
#import "NewSetViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MineOrderSortViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *itemArr;

@end

static NSString *personCellId = @"personCellId";
static NSString *detailCellId = @"detailCellId";

@implementation MineViewController
{
    UILabel *_nameLabel;
    UIImageView *_userPhoto;
    UILabel *_phoneLabel;
    UILabel *_addressLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rightHidden = NO;
    [self requestCount];
    [self setCustomNavigationTitle:@"个人中心"];
    [self setBackButtonHidden:YES];
    
    if (!APP_DELEGATE.loginSuss && APP_DELEGATE.firstTimeOnUserPage) {
        APP_DELEGATE.firstTimeOnUserPage = NO;
        [self goToLoginPage];
    }else{
        [self.tableView reloadData];
    }

}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"%@",GetCachesPath());
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:kRefreshOrderCount object:nil];
    [self initData];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MinePersonCell class] forCellReuseIdentifier:personCellId];
    [self.tableView registerClass:[MineDetailCell class] forCellReuseIdentifier:detailCellId];
}

- (void)initData{
    _itemArr = @[@{@"name":@"全部订单",@"icon":@"grzx_01"},
                 @{@"name":@"违章处理历史查询",@"icon":@"grzx_02"},
                 @{@"name":@"决定书编号缴款",@"icon":@"grzx_03"},
                 @{@"name":@"我的优惠券",@"icon":@"grzx_04"},
                 @{@"name":@"客服协助",@"icon":@"grzx_05"},
                 @{@"name":@"用户反馈",@"icon":@"grzx_06"}];
}

- (void)requestCount{
    [[NetworkEngine sharedNetwork] postBody:@{@"account":APP_DELEGATE.userName} apiPath:kOrderCount hasHeader:YES finish:^(ResultState state, id resObj) {
        if (state == StateSucceed) {
            NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
            
            [u setObject:resObj[@"body"][0][@"noPaySum"] forKey:WATTINGFORPAY];
            [u setObject:resObj[@"body"][0][@"noServiceSum"] forKey:WATTINGFORSERVICE];
            [u setObject:resObj[@"body"][0][@"noEvaluationSum"] forKey:WATTINGFORCOMMNET];
            [u setObject:resObj[@"body"][0][@"backSum"] forKey:WATTINGFORREFOUND];
            
            [u synchronize];
            [self.tableView reloadData];
        }
    } failed:^(NSError *error) {
        
    }];
}

- (void)refreshView{
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, self.view.width, APP_HEIGHT-APP_VIEW_Y)
                                             style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    return _tableView;
}

- (void)initPersonMess{
    if (APP_DELEGATE.loginSuss) {
        UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
        if (!user.photoLocalPath || [user.photoLocalPath isEqualToString:@""]) {
            [_userPhoto setImage:[UIImage imageNamed:@"chat_portrait_photo"]];
        }else{
            if ([UIImage imageWithContentsOfFile:user.photoLocalPath]) {
                [_userPhoto setImage:[UIImage imageWithContentsOfFile:user.photoLocalPath]];
            }else{//丢失？？
                [NETHelper asynchronousDownloadPhotoImage];
            }
            
        }
        [_nameLabel setText:user.userName];
        [_phoneLabel setText:[NSString stringWithFormat:@"%@", user.contactNum]];
    }else{
        [_userPhoto setImage:[UIImage imageNamed:@"chat_portrait_photo"]];
        [_nameLabel setText:@"请先登录"];
        [_phoneLabel setText:@""];
    }
}

#pragma mark - MineOrderSortViewDelegate
- (void)didSelectItem:(MineOrderSortView *)sortView atIndex:(NSInteger)path{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        
        return;
    }
    OrderMessController *ovc = [[OrderMessController alloc]init];
    switch (path) {
        case 0:
            ovc.demandType = DemandWaittingForPay;
            break;
        case 1:
            ovc.demandType = DemandWaittingForService;
            break;
        case 2:
            ovc.demandType = DemandWaittingForComment;
            break;
        case 3:
            ovc.demandType = DemandRefund;
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:ovc animated:YES];
}

- (void)rightAction{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        
        return;
    }
    NewSetViewController *svc = [[NewSetViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section != 2 ? CGFLOAT_MIN : 20*y_6_plus;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 1){
        return 232*y_6_plus;
    }
    
    return 20*y_6_plus;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1 || section == 2 || section == 3){
        return 1;
    }
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 260*y_6_plus;
    }else if (indexPath.section == 1){
        return 110*y_6_plus;
    }
    
    return 120*y_6_plus;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        MineOrderSortView *mv = [[MineOrderSortView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 232*y_6_plus)];
        mv.dataSource = @[@{@"name":@"待付款",@"icon":@"grzx_A"},
                          @{@"name":@"待服务",@"icon":@"grzx_B"},
                          @{@"name":@"待评价",@"icon":@"grzx_C"},
                          @{@"name":@"退款",@"icon":@"grzx_D"}];
        mv.delegate = self;
        
        return mv;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MinePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:personCellId];
        if (!cell) {
            cell = [[MinePersonCell alloc]init];
        }
        _userPhoto = cell.icon;
        _nameLabel = cell.nameLabel;
        _phoneLabel = cell.phoneLabel;
        _addressLabel = cell.addressLabel;
        
        [self initPersonMess];
        
        return cell;
    }
    
    MineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
    if (!cell) {
        cell = [[MineDetailCell alloc]init];
    }
    
    if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3){
        [cell configCellWithDic:_itemArr[indexPath.section-1]];
        
    }else{
        [cell configCellWithDic:_itemArr[indexPath.row+3]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!APP_DELEGATE.loginSuss) {
            [self goToLoginPage];
            
            return;
        }
  
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }else if (indexPath.section == 1){
        if (!APP_DELEGATE.loginSuss) {
            [self goToLoginPage];
            
            return;
        }
        OrderMessController *ovc = [[OrderMessController alloc]init];
        [self.navigationController pushViewController:ovc animated:YES];
    }else if(indexPath.section == 2){
       
            if (!APP_DELEGATE.loginSuss) {
                [self goToLoginPage];
                
                return;
            }
        NewDealingViewController *drvc = [[NewDealingViewController alloc] init];
        [self.navigationController pushViewController:drvc animated:YES];
    }else if(indexPath.section == 3){
        
        if (!APP_DELEGATE.loginSuss) {
            [self goToLoginPage];
            
            return;
        }//决定书编号
        ScanViewController *scanVC = [[ScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
//        JDSBHSearchPayViewController *jdsbhSearchPayVC = [[JDSBHSearchPayViewController alloc] init];
//        [self.navigationController pushViewController:jdsbhSearchPayVC animated:YES];
    }else if(indexPath.section == 4){
        if (indexPath.row == 1) {
            [UITools alertWithMsg:@"是否拨打客服电话 4000956122" viewController:self confirmAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://4000956122"]]];
            } cancelAction:nil];
            
        }
        
    }
}

@end
