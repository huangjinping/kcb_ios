//
//  OrderRefoundController.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/28.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderRefoundController.h"
#import "InputTextView.h"

@implementation RefoundHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(80*x_6_plus, 65*y_6_plus, self.width-80*x_6_plus, 72*y_6_plus)];
        l.textColor = [UIColor colorWithHex:0x666666];
        l.font = V3_48PX_FONT;
        l.text = @"退款原因";
        
        [self addSubview:l];
        [self addLineWithFrame:CGRectMake(30*x_6_plus, self.height-1, self.width-60*x_6_plus, 1) lineColor:kLineGrayColor];
    }
    
    return self;
}

@end
@implementation RefoundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_icon setImage:[UIImage imageNamed:@"car_default hover"] forState:UIControlStateNormal];
        [_icon setImage:[UIImage imageNamed:@"car_default"] forState:UIControlStateSelected];
        [_icon addActionBlock:^(id weakSender) {
            if (_commplete) {
                _commplete();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        _icon.frame = CGRectMake(0, 0, 49*x_6_plus, 49*x_6_plus);
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800*x_6_plus, 48*y_6_plus)];
        _contentLabel.textColor = [UIColor colorWithHex:0x666666];
        _contentLabel.font = V3_38PX_FONT;
        
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_contentLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _icon.origin = CGPointMake(85*x_6_plus, 0);
    _icon.centerY = self.contentView.boundsCenter.y;
    _contentLabel.origin = CGPointMake(_icon.right+20*x_6_plus, 0);
    _contentLabel.centerY = self.contentView.boundsCenter.y;
}

@end

@interface OrderRefoundController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;

@end

static NSString *defaultCell = @"defaultCell";
static NSString *selectRow = @"selectRow";

@implementation OrderRefoundController
{
    NSArray *_ItemArr;
    NSMutableDictionary *_selectItem;
    InputTextView *_InputView;
    
    NSString *_remarks;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"退款申请"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ItemArr = @[@{@"name":@"我改变主意了"},
                 @{@"name":@"服务问题"},
                 @{@"name":@"配件质量问题"},
                 @{@"name":@"物流问题"},
                 @{@"name":@"其他"},
                 ];
    
    _selectItem = [@{selectRow:@(0)} mutableCopy];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_NAV_HEIGHT-self.footerView.height)
                                             style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kWhiteColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    return _tableView;
}

- (UIView *)footerView{
    if (_footerView) {
        return _footerView;
    }
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-144*y_6_plus, APP_WIDTH, 144*y_6_plus)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addActionBlock:^(id weakSender) {
        if (![self vertify]) {
            return ;
        }
        [self initPostData];
        [[NetworkEngine sharedNetwork] postBody:@{@"orderNo":_orderNo,@"orderId":_orderId,@"remarks":_remarks} apiPath:korderBackURL hasHeader:YES finish:^(ResultState state, id resObj) {
            [self.navigationController popViewControllerAnimated:YES];
            if (state == StateSucceed) {
                if (_commplete) {
                    _commplete();
                }
            }
        } failed:^(NSError *error) {
            
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, _footerView.width, _footerView.height);
    btn.backgroundColor = COLOR_NAV;
    [btn setTitle:@"提交申请"];
    [btn setTitleColor:kWhiteColor];
    btn.titleLabel.font = V3_40PX_FONT;
    [_footerView addSubview:btn];
    
    return _footerView;
}

- (void)initPostData{
    if ([_selectItem[selectRow] integerValue] < 4) {
        NSInteger row = [_selectItem[selectRow] integerValue];
        _remarks = _ItemArr[row][@"name"];
    }else{
        _remarks = _InputView.inputView.text;
    }
}

- (BOOL)vertify{
    if ([_selectItem[selectRow] integerValue] == 4) {
        if (![_InputView.inputView.text isLegal]) {
            [UITools alertWithMsg:@"请您填写退款理由"];
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - UItableViewDataSource && UItableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 147*y_6_plus;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 300*y_6_plus;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103*y_6_plus;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RefoundHeaderView *headerView = [[RefoundHeaderView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 145*y_6_plus)];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 260*y_6_plus)];
    footerView.backgroundColor = kWhiteColor;
    _InputView = [[InputTextView alloc] initWithFrame:CGRectMake(167*x_6_plus, 10, 810*x_6_plus, 300*y_6_plus)];
    _InputView.placeholder = @"请您填写退款理由";
    _InputView.textViewMaxLength = 150;
    [footerView addSubview:_InputView];
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RefoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[RefoundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.contentLabel.text = _ItemArr[indexPath.row][@"name"];
    if (![_selectItem.allKeys containsObject:defaultCell]) {
        if (indexPath.row == 0) {
            [_selectItem setObject:cell forKey:defaultCell];
        }
    }
    cell.icon.selected = NO;
    if (indexPath.row == [_selectItem[selectRow] integerValue]) {
        cell.icon.selected = YES;
    }
    __block __typeof(cell) weakCell = cell;
    cell.commplete = ^{
        weakCell.icon.selected = YES;
        RefoundCell *cell0 = _selectItem[defaultCell];
        if (![cell0 isEqual:weakCell]) {
            cell0.icon.selected = NO;
        }
        [_selectItem setObject:@(indexPath.row) forKey:selectRow];
        [_selectItem setObject:weakCell forKey:defaultCell];
    };
    
    return cell;
}

@end
