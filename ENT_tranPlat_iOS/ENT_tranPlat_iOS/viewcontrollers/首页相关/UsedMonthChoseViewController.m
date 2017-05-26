//
//  UsedMonthChoseViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedMonthChoseViewController.h"
#import "UserCarViewController.h"
@interface UsedMonthChoseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSArray *dates;

@property (nonatomic,strong)UITableView *rootTableView;

@end

@implementation UsedMonthChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger nowmonth=1;
    
    
    if (!_datas) {
        
        _datas = [NSMutableArray array];
        
        for (int i = 0; i<12; i++) {
            NSString *string=[NSString stringWithFormat:@"%ld",(nowmonth +i)];
            
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
    static NSString *cellId = @"chooseTimeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = FONT_NOMAL;
        cell.textLabel.textColor = COLOR_FONT_NOMAL;
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSString *cityName = [NSString stringWithFormat:@"%@",[_datas objectAtIndex:indexPath.row]];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *month = [_datas objectAtIndex:indexPath.row];
    NSString *year = _year;
    
    NSString *AllName=[[NSString alloc]init];
    
    
    AllName=[NSString stringWithFormat:@"%@-%@",year,month];
    
    NSMutableDictionary *dicBook = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicBook setObject:AllName forKey:@"time"];
    

    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"shangpai" object:self userInfo:dicBook];
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[UserCarViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
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
