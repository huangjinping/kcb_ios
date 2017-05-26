//
//  SelectCarTypeViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/21.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SelectCarTypeViewController.h"

@interface SelectCarTypeViewController ()<
SegmentButtonViewDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{

    NSDictionary    *_qicheDict;
    NSArray         *_qicheNameArr;
    NSDictionary    *_otherDict;
    NSArray         *_otherNameArr;

    NSArray         *_carTypeNameArr;
    
    SegmentButtonView   *_segb;
    UITableView *_rootTableView;
}
@end

@implementation SelectCarTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _qicheDict = @{@"01":@"大型汽车",@"02":@"小型汽车",@"03":@"使馆汽车",@"04":@"领馆汽车",@"05":@"境外汽车",@"06":@"外籍汽车",@"16":@"教练汽车",@"18":@"试验汽车",@"20":@"临时入境汽车",@"23":@"警用汽车"};
    _qicheNameArr = [_qicheDict allValues];

    _otherDict = @{@"07":@"两、三轮摩托车",@"08":@"轻便摩托车",@"09":@"使馆摩托车",@"10":@"领馆摩托车",@"11":@"境外摩托车",@"12":@"外籍摩托车",@"13":@"农用运输车",@"14":@"拖拉机",@"15":@"挂车",@"17":@"教练摩托车",@"19":@"试验摩托车",@"21":@"临时入境摩托车",@"22":@"临时行驶车",@"24":@"警用摩托",@"25":@"非机动车"};
    _otherNameArr = [_otherDict allValues];
    

    self.view.backgroundColor = [UIColor whiteColor];
    _segb = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_NAV_HEIGHT) backgroundColor:COLOR_VIEW_CONTROLLER_BG andLineColor:COLOR_NAV];
    [_segb setTitles:[NSArray arrayWithObjects:@"汽车", @"其他", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_NAV];
    _segb.delegate = self;
    [self.view addSubview:_segb];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _segb.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT*2)];
    _rootTableView.showsVerticalScrollIndicator = NO;
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"选择车辆类型"];
}




- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    [_rootTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_segb.selectedIndex == 0) {//汽车
        return [_qicheNameArr count];
    }else{
        return [_otherNameArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30*3*PX_X_SCALE;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cartypecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = FONT_NOMAL;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if (_segb.selectedIndex == 0) {//汽车
        cell.textLabel.text = [_qicheNameArr objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text =  [_otherNameArr objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cartype = @"";
    NSString *cartypeCode = @"";
    if (_segb.selectedIndex == 0) {//汽车
        cartype = [_qicheNameArr objectAtIndex:indexPath.row];
        for (NSString *key in [_qicheDict allKeys]) {
            if([[_qicheDict objectForKey:key] isEqualToString:cartype]){
                cartypeCode = key;
                break;
            }
        }
    }else{
        cartype = [_otherNameArr objectAtIndex:indexPath.row];
        for (NSString *key in [_otherDict allKeys]) {
            if([[_otherDict objectForKey:key] isEqualToString:cartype]){
                cartypeCode = key;
                break;
            }
        }

    }
    if ([self.delegate_ respondsToSelector:@selector(selectCarTypeViewController:selectCarType:andCarTypeCode:)]) {
        [self.delegate_ selectCarTypeViewController:self selectCarType:cartype andCarTypeCode:cartypeCode];
    }
    
    [self gobackPage];
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

@end
