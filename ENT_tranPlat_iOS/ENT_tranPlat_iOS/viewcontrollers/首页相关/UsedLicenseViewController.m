//
//  UsedLicenseViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedLicenseViewController.h"
#import "UsedMonthChoseViewController.h"
@interface UsedLicenseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *datas;

@property (nonatomic,strong)UITableView *rootTableView;

@end

@implementation UsedLicenseViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    NSInteger oldYear=[_years integerValue];

    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    NSString* date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSString *strNum = [timeNow substringToIndex:4];
    NSInteger nowYear=[strNum integerValue];
    if (!_datas) {
        _datas = [NSMutableArray array];
        for (int i = 0; i<(nowYear-oldYear+1); i++) {
            NSString *string=[NSString stringWithFormat:@"%ld",(oldYear +i)];
            [_datas addObject:string];
        }
    }
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"chooseCarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = FONT_NOMAL;
        cell.textLabel.textColor = COLOR_FONT_NOMAL;
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSString *cityName = [_datas objectAtIndex:indexPath.row];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    UsedMonthChoseViewController *vc=[[UsedMonthChoseViewController alloc]init];
    NSString *pname = [_datas objectAtIndex:indexPath.row];
    vc.year=pname;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"上牌时间"];
   
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
