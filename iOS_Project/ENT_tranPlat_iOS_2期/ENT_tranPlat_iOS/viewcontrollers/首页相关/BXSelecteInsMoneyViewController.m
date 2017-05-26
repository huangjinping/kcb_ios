//
//  BXSelecteInsMoneyViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXSelecteInsMoneyViewController.h"

@interface BXSelecteInsMoneyViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic) NSMutableArray        *datasourceArr;
@end

@implementation BXSelecteInsMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITableView *rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [rootTableView setDelegate:self];
    [rootTableView setDataSource:self];
    [self.view addSubview:rootTableView];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    switch (self.ins_type_tag) {
        case TAG_BUTTON_SELECTED_INS_BOLI://    "boli":"1",			    //玻璃 0  不投保  1  国产  2 进口
            
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"不投保" forKey:@"0"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"国产" forKey:@"1"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"进口" forKey:@"2"]];
            
            break;
        case TAG_BUTTON_SELECTED_INS_CHENGKE://    "c_zuo":"10000",                //乘客座位 0  10000  20000  30000  40000  50000  100000
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"不投保" forKey:@"0"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"1万" forKey:@"10000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"2万" forKey:@"20000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"3万" forKey:@"30000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"4万" forKey:@"40000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"5万" forKey:@"50000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"10万" forKey:@"100000"]];
            
            break;
        case TAG_BUTTON_SELECTED_INS_SIJI://    "s_zuo":"10000",	            //司机座位 0  10000  20000  30000  40000  50000  100000
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"不投保" forKey:@"0"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"1万" forKey:@"10000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"2万" forKey:@"20000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"3万" forKey:@"30000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"4万" forKey:@"40000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"5万" forKey:@"50000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"10万" forKey:@"100000"]];
            
            
            break;
        case TAG_BUTTON_SELECTED_INS_SANZHE://    "sanze":"300000",               //第三者 0  50000  100000  150000   200000  300000  500000  1000000 描述时为: 不投保  5万  10万 ......
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"不投保" forKey:@"0"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"5万" forKey:@"50000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"10万" forKey:@"100000"]];
            //[dataArr addObject:[NSDictionary dictionaryWithObject:@"15万" forKey:@"150000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"20万" forKey:@"200000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"30万" forKey:@"300000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"50万" forKey:@"500000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"100万" forKey:@"1000000"]];
            
            break;
        case TAG_BUTTON_SELECTED_INS_HUAHEN://    "huahen":"1",                   //划痕 0  2000  5000  10000
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"不投保" forKey:@"0"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"2千" forKey:@"2000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"5千" forKey:@"5000"]];
            [dataArr addObject:[NSDictionary dictionaryWithObject:@"1万" forKey:@"10000"]];
            
            
            break;
            
        default:
            break;
    }
    
    
    self.datasourceArr = dataArr;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"选择保额"];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datasourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_Y_SCALE;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"particularCartypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = FONT_NOTICE;
        cell.textLabel.textColor = COLOR_FONT_INFO_SHOW;
    }
    cell.textLabel.text = [[[self.datasourceArr objectAtIndex:indexPath.row] allValues] lastObject];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *value = [[[self.datasourceArr objectAtIndex:indexPath.row] allValues] lastObject];
    NSString *key = [[[self.datasourceArr objectAtIndex:indexPath.row] allKeys] lastObject];

    switch (self.ins_type_tag) {
        case TAG_BUTTON_SELECTED_INS_BOLI:
            self.baoxian.ins_boli = value;
            self.baoxian.ins_boli_code = key;
            break;
        case TAG_BUTTON_SELECTED_INS_CHENGKE:
            self.baoxian.ins_c_zuo = value;
            self.baoxian.ins_c_zuo_code = key;
            break;
        case TAG_BUTTON_SELECTED_INS_SIJI:
            self.baoxian.ins_s_zuo = value;
            self.baoxian.ins_s_zuo_code = key;
            break;
        case TAG_BUTTON_SELECTED_INS_SANZHE:
            self.baoxian.ins_sanze = value;
            self.baoxian.ins_sanze_code = key;
            break;
        case TAG_BUTTON_SELECTED_INS_HUAHEN:
            self.baoxian.ins_huahen = value;
            self.baoxian.ins_huahen_code = key;
            break;
            
        default:
            break;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
