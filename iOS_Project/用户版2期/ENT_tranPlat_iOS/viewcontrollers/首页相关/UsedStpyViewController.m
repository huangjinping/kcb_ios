//
//  UsedStpyViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedStpyViewController.h"
#import "UsedYearViewController.h"

@interface UsedStpyViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic,strong)NSMutableArray* datas;
@property (nonatomic,strong)UITableView *rootTableView;
@property (nonatomic,assign)NSInteger number;


@end

@implementation UsedStpyViewController

- (void)viewDidLoad {
    _datas=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self download];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_Y_SCALE;
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
        cell.textLabel.font = V3_32PX_FONT;
        cell.textLabel.textColor = COLOR_FONT_NOMAL;
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *cityDict = [_datas objectAtIndex:indexPath.row];
    NSString *cityName = [cityDict objectForKey:@"seriesName"];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsedYearViewController *vc=[[UsedYearViewController alloc]init];
    NSDictionary *cityDict = [_datas objectAtIndex:indexPath.row];
    NSString *string = [cityDict objectForKey:@"seriesId"];
    vc.numStr =string;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//视图已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_datas.count){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }
    
    
}

-(void)download{
    //与安卓配合转化毫秒数
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    //  NSString *stringTime =[NSString stringWithFormat:@"%llu",recordTime];
    
    NSString *url=[NSString stringWithFormat:@"http://buss.956122.com/eval/carseries/%@/1.do?callback=handler&_=%llu",_numStr ,recordTime];
    
    MyAFNetWorkingRequest  * myAF=[MyAFNetWorkingRequest alloc];
    myAF =[[MyAFNetWorkingRequest alloc]initWithRequest:url andParams:nil andBlock:^(NSData *requestData) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSMutableString *mutString=[[NSMutableString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
  
        NSRange range=[mutString rangeOfString:@"])"];
        [mutString deleteCharactersInRange:range];
        [mutString deleteCharactersInRange:NSMakeRange(0, 9)];
      
        NSData *jsonData = [mutString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        _datas= [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
        [_rootTableView reloadData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"选择车型"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
