//
//  BXSelectParticularCartypeViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXSelectParticularCartypeViewController.h"
#import "BXSelectInsuranceViewController.h"


@interface BXSelectParticularCartypeViewController ()<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation BXSelectParticularCartypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UITableView *rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [rootTableView setDelegate:self];
    [rootTableView setDataSource:self];
    //[rootTableView setBounces:NO];
    [self.view addSubview:rootTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"选择车型"];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.baoxian.pCartypeArr count];
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
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = [[self.baoxian.pCartypeArr objectAtIndex:indexPath.row] objectForKey:@"value"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Baoxian *baoxian = [[Baoxian alloc] init];
    baoxian.hphm = self.baoxian.hphm;
    baoxian.syr = self.baoxian.syr;
    baoxian.sfzhm = self.baoxian.sfzhm;
    baoxian.vin = self.baoxian.vin;
    baoxian.zcrq = self.baoxian.zcrq;
    baoxian.fdjh = self.baoxian.fdjh;
    baoxian.city = self.baoxian.city;
    baoxian.citycode = self.baoxian.citycode;
//    baoxian.syxToubaoDate = self.baoxian.syxToubaoDate;
//    baoxian.jqxToubaoDate = self.baoxian.jqxToubaoDate;
    baoxian.pCartypeArr = [NSArray arrayWithObjects:[self.baoxian.pCartypeArr objectAtIndex:indexPath.row], nil];;
    
    BXSelectInsuranceViewController *bxsiVC = [[BXSelectInsuranceViewController alloc] init];
    bxsiVC.baoxian = baoxian;
    [self.navigationController pushViewController:bxsiVC animated:YES];
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
