//
//  BXProvinceListViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/23.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXProvinceListViewController.h"

@interface BXProvinceListViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation BXProvinceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UITableView *rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [self.view addSubview:rootTableView];
    [rootTableView setDelegate:self];
    [rootTableView setDataSource:self];
    
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"地址选择"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listDataArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"chooseProvinceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = FONT_NOMAL;
        cell.textLabel.textColor = COLOR_FONT_NOMAL;
        cell.textLabel.numberOfLines = 0;
    }
    NSDictionary *dict = [self.listDataArr objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"TITLE"];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.listDataArr objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"TITLE"];
    NSString *code = [dict objectForKey:@"CODE"];
    if ([self.type isEqualToString:ADDR_TYPE_PROVINCE]) {
        [self.infoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:code, title, nil] forKey:KEY_INS_INFO_PROVINCE_DICT];
    }else if ([self.type isEqualToString:ADDR_TYPE_CITY]){
    [self.infoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:code, title, nil] forKey:KEY_INS_INFO_CITY_DICT];
    }else if ([self.type isEqualToString:ADDR_TYPE_REGION]){
        [self.infoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:code, title, nil] forKey:KEY_INS_INFO_REGION_DICT];
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
