//
//  BillManageController.m
//  Merchant
//
//  Created by Wendy on 15/12/18.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "BillManageController.h"
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
#import "SARProcessView.h"
#import "BillTableCell.h"

@interface BillManageController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HTHorizontalSelectionList *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *historyTableView;
@end

@implementation BillManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"账单管理"];
    self.navigationItem.leftBarButtonItem = nil;

    // Do any additional setup after loading the view.
    self.segment = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH*0.70, 40)];
    self.segment.backgroundColor = [UIColor clearColor];
    self.segment.delegate = self;
    self.segment.dataSource = self;
    self.segment.bottomTrimHidden = YES;
    self.segment.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeLightBounce;
    
    self.segment.selectionIndicatorColor = [UIColor whiteColor];
    [self.segment setTitleColor:[UIColor colorWithHex:0xc0e3c4] forState:UIControlStateNormal];
    [self.segment setTitleFont:[UIFont systemFontOfSize:16] forState:UIControlStateNormal];
    [self.segment setTitleFont:[UIFont boldSystemFontOfSize:16] forState:UIControlStateSelected];
    self.navigationItem.titleView = self.segment;
    
    
    [self createBillTableView];
    

}

- (void)createHistoryBillTableView{
    if(!_historyTableView){
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_historyTableView];

}
- (void)createBillTableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 50)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22, 18, 16)];
    imageView.image = [UIImage imageNamed:@"More-产品介绍"];
    [headerView addSubview:imageView];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right +5, 10, 200, 40)];
    dateLabel.text = @"2015/12/1~2015/12/15";
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = kColor0X666666;
    [headerView addSubview:dateLabel];
    _tableView.tableHeaderView = headerView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 60)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(15, 15, view.width-30, 45);
    [btn setTitle:@"立即提现"];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:RGB(38, 166, 32)];
    [btn addTarget:self action:@selector(withdrawalAction)];
    [btn addBorderWithWidth:.5f color:RGB(175, 209, 176) corner:2];
    [view addSubview:btn];
    _tableView.tableFooterView = view;
}
- (void)withdrawalAction{
    
}
- (void)createBillProgressView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT- APP_NAV_HEIGHT+10)];
    _scrollView.backgroundColor = RGB(183, 183, 183);
    [self.view addSubview:_scrollView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 90)];
    topView.backgroundColor = [UIColor whiteColor];
    
    CGFloat marginLeft = 20;
    CGFloat marginTop = 20;
    CGFloat lableHeight = 35;
    
    UILabel *billNoLab = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, marginTop, topView.width-marginLeft, lableHeight)];
    NSString *string = [NSString stringWithFormat:@"结算单号：%@", @"JS201601061245"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: kColor0X666666 } range:NSMakeRange(0, 5)];
    
    [attributedString addAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:22], NSForegroundColorAttributeName: [UIColor blackColor] } range:NSMakeRange(5, string.length - 5)];
    billNoLab.attributedText = attributedString;
    [topView addSubview:billNoLab];
    
    
    UILabel *billAmountLab = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, billNoLab.bottom, topView.width-marginLeft, lableHeight)];
    
    NSString *string1 = [NSString stringWithFormat:@"结算金额：%@", @"2100元"];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1];
    [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: kColor0X666666 } range:NSMakeRange(0, 5)];
    
    [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:22], NSForegroundColorAttributeName: [UIColor blackColor] } range:NSMakeRange(5, string1.length - 5)];
    
    billAmountLab.attributedText = attributedString1;
    [topView addSubview:billAmountLab];
    [_scrollView addSubview:topView];
    
    //bottomview
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom+10, APP_WIDTH, 0)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.bottom = self.view.bottom;
    
    NSArray *array = @[
                       @"", @"", @""
                       ];
    SARProcessView *process = [[SARProcessView alloc] initWithFrame:CGRectMake(0,  30, APP_WIDTH, 270) listItem:array];
    [bottomView addSubview:process];

    [_scrollView addSubview:bottomView];
    [_scrollView autoContentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return 3;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    if (index == 0) {
        return @"对账单";
    }else if(index == 1){
        return @"结算进度";
    }else{
        return @"历史账单";
    }
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        [self.view removeAllSubviews];
        [self createBillTableView];

    }else if(index == 1){
        [self.view removeAllSubviews];
        [self createBillProgressView];
    }else{
        [self.view removeAllSubviews];
        [self createHistoryBillTableView];

    }
}

#pragma mark - UITableViewDelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableView) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return 0;
    }
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 90)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22, 18, 16)];
    imageView.image = [UIImage imageNamed:@"More-产品介绍"];
    [headerView addSubview:imageView];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right +5, 10, 200, 40)];
    dateLabel.text = @"2015/12/1~2015/12/15";
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = kColor0X666666;
    [headerView addSubview:dateLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(8, dateLabel.bottom, headerView.width-16, 40)];
    bottomView.layer.borderColor = [UIColor grayColor].CGColor;
    bottomView.layer.borderWidth = .5f;
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, bottomView.height)];
    leftLabel.textColor = kColor0X666666;
    leftLabel.text = @"结算单号：JS20150000000";
    leftLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.right, 0, bottomView.width-leftLabel.right-8, bottomView.height)];
    rightLabel.textColor = [UIColor redColor];
    rightLabel.text = @"结算中";
    rightLabel.font = [UIFont systemFontOfSize:14];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:rightLabel];
    [headerView addSubview:bottomView];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    footerView.backgroundColor = [UIColor whiteColor];
    [footerView addLineWithFrame:CGRectMake(0, footerView.height-1, APP_WIDTH, 1) lineColor:kLineColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APP_WIDTH-30, 40)];
    label.textAlignment = NSTextAlignmentRight;
    [footerView addSubview:label];

    if (tableView == _tableView) {
        NSString *string1 = [NSString stringWithFormat:@"可提现金额：%@", @"2100元"];
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1];
        [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: kColor0X666666 } range:NSMakeRange(0, string1.length)];
        
        [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor redColor] } range:NSMakeRange(6, string1.length - 7)];
        
        label.attributedText = attributedString1;

    }else{
        NSString *string1 = [NSString stringWithFormat:@"提现金额：%@", @"2100元"];
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1];
        [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: kColor0X666666 } range:NSMakeRange(0, string1.length)];
        
        [attributedString1 addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor blackColor] } range:NSMakeRange(5, string1.length - 6)];
        
        label.attributedText = attributedString1;

    }

    return footerView;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BillTableCell";
    BillTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[BillTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.typeLabel.text = @"服务项目";
        cell.typeLabel.backgroundColor = RGB(238, 247, 241);
        
        cell.orderCountLable.text = @"订单数";
        cell.orderCountLable.backgroundColor = RGB(238, 247, 241);
        cell.orderCountLable.textColor = kColor0X666666;

        cell.imcomeLabel.text = @"收入数";
        cell.imcomeLabel.textColor = kColor0X666666;
        cell.imcomeLabel.backgroundColor = RGB(238, 247, 241);

    }else if(indexPath.row == 2){
        cell.typeLabel.text = @"总计";
        cell.typeLabel.backgroundColor = [UIColor whiteColor];

        cell.orderCountLable.text = @"20";
        cell.orderCountLable.backgroundColor = [UIColor whiteColor];
        cell.orderCountLable.textColor = [UIColor orangeColor];
        
        cell.imcomeLabel.text = @"2100元";
        cell.imcomeLabel.textColor = [UIColor orangeColor];
        cell.imcomeLabel.backgroundColor = [UIColor whiteColor];

    }else{
        cell.typeLabel.text = @"保养";
        cell.typeLabel.backgroundColor = [UIColor whiteColor];

        cell.orderCountLable.text = @"20";
        cell.orderCountLable.backgroundColor = [UIColor whiteColor];
        cell.orderCountLable.textColor = kColor0X666666;

        cell.imcomeLabel.text = @"2100元";
        cell.imcomeLabel.textColor = kColor0X666666;
        cell.imcomeLabel.backgroundColor = [UIColor whiteColor];

    }
    return cell;
}

#pragma mark -
@end
