//
//  OutDetailViewController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OutDetailViewController.h"
#import "MaintenanceController.h"
#import "MapViewController.h"
#import "OutStarView.h"
#import "OutMessView.h"
#import "OrderDetailInfoCell.h"
#import "OrderDeletailCell.h"
#import "OrderCommentCell.h"

@interface OutDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *headerView;
@property (nonatomic, strong)UIButton *footerView;

@property (nonatomic, strong)NSMutableDictionary *dataSource;
@property (nonatomic, strong)NSMutableArray *countArr;
@property (nonatomic, strong)UILabel *dz;

@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)CWStarRateView *star;
@property (nonatomic, strong)UILabel *socre;

@end

static NSString *cellId1 = @"cellId1";
static NSString *cellId2 = @"cellId2";
static NSString *cellId3 = @"cellId3";

@implementation OutDetailViewController
{
    OutStarView *_starView;
    OutMessView *_phoneView;
    OutMessView *_locView;
    UIView *serviewView;
    UIView *commentView;
    
    BOOL _folding;
    NSInteger _page;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavTitle:@"门店详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _folding = YES;
    _page = 1;
    _countArr = [NSMutableArray array];
    [self configUI];
    [UITools showIndicatorToView:self.view];
    [self requestData:MJRefreshTypeNone];
}

- (void)requestData:(MJRefreshType)refreshType{
    [[NetworkEngine sharedNetwork] postBody:@{@"merid":_merid,@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"rows":@"10"} apiPath:kOutDetailURL hasHeader:YES finish:^(ResultState state, id resObj) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [UITools hideHUDForView:self.view];
        
        if (state == StateSucceed) {
            if (!self.dataSource) {
                self.dataSource = [NSMutableDictionary dictionary];
            }
            if (refreshType != MJRefreshTypeFooter) {
                [_countArr removeAllObjects];
            }
            self.dataSource = [NSMutableDictionary dictionaryWithDictionary:resObj[@"body"]];
            self.tableView.footer.hidden = [[resObj[@"body"][@"evList"] analysisConvertToArray] count] < 10;
            [_countArr addObjectsFromArray:self.dataSource[@"evList"]];

            [self refreshHeaderV];
            [self.tableView reloadData];
        }
    } failed:^(NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [UITools hideHUDForView:self.view];
    }];
}

- (void)configUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    self.footerView.hidden = self.hiddenFooter;
    if (self.hiddenFooter) {
        self.tableView.height = APP_HEIGHT-APP_NAV_HEIGHT+(1080-640)*y_6_plus;
    }else{
        self.tableView.height = APP_HEIGHT-APP_NAV_HEIGHT-self.footerView.height+(1080-640)*y_6_plus;
    }
}

- (void)refreshHeaderV{
    NSURL *url = [NSURL URLWithString:self.dataSource[@"info"][@"logo_pic"]];
    [_headerView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    _dz.text = self.dataSource[@"info"][@"name"];
    _time.text = [NSString stringWithFormat:@"营业时间：%@-%@",self.dataSource[@"info"][@"open_time"],self.dataSource[@"info"][@"close_time"]];
    _star.scorePercent = [self.dataSource[@"info"][@"level"] floatValue]/5;
    _socre.text = [NSString stringWithFormat:@"%.1f分",[self.dataSource[@"info"][@"level"] floatValue]];
    NSString *strTime=[NSString stringWithFormat:@"营业时间:%@-%@",[_dataSource[@"info"]valueForKey:@"open_time"],[_dataSource[@"info"]valueForKey:@"close_time"]];
    _time.text=strTime;
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y-(1080-640)*y_6_plus, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT-self.footerView.height+(1080-640)*y_6_plus) style:UITableViewStyleGrouped];
    [_tableView registerClass:[OrderDetailInfoCell class] forCellReuseIdentifier:cellId1];
    [_tableView registerClass:[OrderDeletailCell class] forCellReuseIdentifier:cellId2];
    
    _tableView.tableHeaderView = self.headerView;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    _tableView.header.updatedTimeHidden = YES;
    _tableView.footer.hidden = YES;
    
    return _tableView;
}

- (void)headerRefreshing{
    _page = 1;
    [self requestData:MJRefreshTypeHeader];
}

- (void)footerRefreshing{
    _page += 1;
    [self requestData:MJRefreshTypeFooter];
}

- (UIView *)headerView{
    if (_headerView) {
        return _headerView;
    }
    _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_WIDTH)];
    CGFloat y = (1080-640)*y_6_plus;
    UIView *clearView=[[UIView alloc]initWithFrame:CGRectMake(0, (640-190)*y_6_plus+y, APP_WIDTH, 190*y_6_plus)];

    clearView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [_headerView addSubview:clearView];
    

    _dz=[[UILabel alloc]initWithFrame:CGRectMake(40*x_6_plus , 0, APP_WIDTH, 95*y_6_plus)];
    _dz.textColor=[UIColor whiteColor];
    _dz.font=WY_FONT_SIZE(50);

   
    _time=[[UILabel alloc]initWithFrame:CGRectMake(40*x_6_plus , 95*y_6_plus, APP_WIDTH, 95*y_6_plus)];
    _time.textColor=[UIColor whiteColor];
    _time.font=WY_FONT_SIZE(38);
  //   _time.text=@"营业时间 : 08:00-19:00";
    _star=[[CWStarRateView alloc]initWithFrame:CGRectMake(APP_WIDTH- 500*y_6_plus,_time.top,300*x_6_plus, 60*y_6_plus) numberOfStars:5];
    _star.userInteractionEnabled = NO;
    _socre=[[UILabel alloc]initWithFrame:CGRectMake(APP_WIDTH- 180*y_6_plus,_time.top,150*x_6_plus, 95*y_6_plus)];
    _socre.centerY=_star.centerY;
    _socre.textColor=kTextOrangeColor;
    _socre.font=WY_FONT_SIZE(50);
    [clearView addSubview:_dz];
    [clearView addSubview:_time];
     [clearView addSubview:_star];
    [clearView addSubview:_socre];
    

    return _headerView;
}

- (UIButton *)footerView{
    if (_footerView) {
        return _footerView;
    }
    _footerView = [UIButton buttonWithType:UIButtonTypeCustom];
    _footerView.frame = CGRectMake(0, self.view.height-136*y_6_plus, APP_WIDTH, 136*y_6_plus);
    _footerView.backgroundColor = COLOR_NAV;
    [_footerView setTitle:@"选择门店"];
    [_footerView setTitleColor:kWhiteColor];
    __block __typeof(self)weakSelf = self;
    [_footerView addActionBlock:^(id weakSender) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:weakSelf.dataSource[@"info"]];
        [dic setObject:_distancce ? _distancce : @"" forKey:@"distance"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostOutlet object:nil userInfo:dic];
        for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
            if ([vc isKindOfClass:[MaintenanceController class]]) {
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    return _footerView;
}

- (void)setScore:(NSNumber *)score{
    _star.scorePercent = [score floatValue]/5;
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return !_countArr.count?3:4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }else if(section == 2){
        return 1;
    }
    if (_countArr.count>2) {
        return _folding ? 2 : _countArr.count;
    }else{
        return _countArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 || section == 3) {
        return 85*y_6_plus;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 3) {
        return 20*y_6_plus;
    }
    
    return _folding ? 60*y_6_plus : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 120*y_6_plus;
    }
    if (indexPath.section == 2) {

        return [OrderDeletailCell getRowHeight:self.dataSource[@"info"][@"describe_m"]];
    }
    
    return 150*y_6_plus;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return nil;
    }
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 85*y_6_plus)];
    v.backgroundColor = kWhiteColor;
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(40*x_6_plus, 0, v.width, v.height)];
    l.font = WY_FONT_SIZE(38);
    l.textColor = [UIColor colorWithHex:0x666666];
    l.centerY = v.boundsCenter.y;
    if (section == 2) {
        l.text = @"服务范围";
    }else{
        l.text = @"客户评价";
    }
    [v addSubview:l];
    
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section != 3) {
        return nil;
    }
    if (_countArr.count>2 && _folding) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, tableView.width, 60*y_6_plus);
        btn.backgroundColor = kWhiteColor;
        btn.titleLabel.font = V3_30PX_FONT;
        [btn setTitle:@"更多评价"];
        [btn setTitleColor:kTextGrayColor];
        [btn setImage:[UIImage imageNamed:@"sj"] forState:UIControlStateNormal];
        
        [btn addActionBlock:^(id weakSender) {
            _folding = NO;
            [tableView reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
        
        return btn;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        OrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (!cell) {
            cell = [[OrderDetailInfoCell alloc]init];
        }
        if (indexPath.section == 0) {
            cell.name = [NSString stringWithFormat:@"联系电话:%@",self.dataSource[@"info"][@"phone_no"]];
            cell.img = [UIImage imageNamed:@"tel"];
        }else{
            cell.name = self.dataSource[@"info"][@"address"];
            cell.img = [UIImage imageNamed:@"zb"];
        }

        return cell;
    }else if (indexPath.section == 2){
        OrderDeletailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell) {
            cell = [[OrderDeletailCell alloc]init];
        }
        cell.contentLabel.text = self.dataSource[@"info"][@"describe_m"];
        
        return cell;
    }
    
    OrderCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
    if (!cell) {
        cell = [[OrderCommentCell alloc]init];
    }
    [cell configCellWithDic:_countArr[indexPath.row]];
    
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [UITools alertWithMsg:[NSString stringWithFormat:@"您要联系商户 %@",self.dataSource[@"info"][@"phone_no"]] viewController:self confirmAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.dataSource[@"info"][@"phone_no"]]]];
        } cancelAction:nil];
    }else if (indexPath.section == 1){
        MapViewController *mvc = [[MapViewController alloc] init];
        mvc.merName = self.dataSource[@"info"][@"name"];
        mvc.address = self.dataSource[@"info"][@"address"];
        mvc.jwd = self.jwd;
        [self.navigationController pushViewController:mvc animated:YES];
    }
}

@end
