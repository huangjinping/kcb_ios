//
//  SetProvinceViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/6.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SetProvinceViewController.h"
#import "SetCityViewController.h"

@interface SetProvinceViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView     *_rootTableView;
}

@property (nonatomic)   NSMutableArray          *pnameArr;
@property (nonatomic)   NSMutableDictionary      *dataDict;



@end

@implementation SetProvinceViewController
//
//- (void)gobackPage{
//    [self dismissModalViewControllerAnimated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //read
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *resourceDict = [parser objectWithData:resourceData];
    
    NSArray *resourceArr = [resourceDict objectForKey:@"pl"];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray *pnameArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in resourceArr) {
        NSArray *cityListArr = [dict objectForKey:@"list"];
        NSString *pname = [dict objectForKey:@"pname"];
        [dataDict setObject:cityListArr forKey:pname];
        [pnameArr addObject:pname];
    }
    self.pnameArr = pnameArr;
    self.dataDict = dataDict;
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"选择省"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.pnameArr count];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *pname = [self.pnameArr objectAtIndex:indexPath.row];
    cell.textLabel.text = pname;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *pname = [self.pnameArr objectAtIndex:indexPath.row];
    NSArray *cityArr = [self.dataDict objectForKey:pname];
    SetCityViewController *vc = [[SetCityViewController alloc] init];
    vc.pname = pname;
    vc.cityArr = cityArr;
    [self.navigationController pushViewController:vc animated:YES];
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
