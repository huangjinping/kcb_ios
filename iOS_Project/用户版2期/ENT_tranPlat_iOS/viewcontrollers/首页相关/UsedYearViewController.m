//
//  UsedYearViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedYearViewController.h"
#import "UserCarViewController.h"

@interface UsedYearViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic,strong)NSMutableArray* datas;
@property (nonatomic,strong)UITableView *rootTableView;
@property (nonatomic,assign)NSInteger number;
@property (nonatomic, strong) NSMutableArray *yearDatas;


@end

@implementation UsedYearViewController

- (void)viewDidLoad {
    _datas=[[NSMutableArray alloc]init];
    _yearDatas=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self download];
    [self creatUI];
    
}
-(void)creatUI{
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"chooseCarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UILabel *wordLabel = [[UILabel alloc] initWithFrame:LGRectMake( 20, 10,150  , 40)];
        [wordLabel convertNewLabelWithFont: SYS_FONT_SIZE(30) textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:wordLabel];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:LGRectMake( 50, 50,APP_PX_WIDTH-60, 100)];
        [nameLabel convertNewLabelWithFont:V3_32PX_FONT textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        nameLabel.numberOfLines = 0;
        [cell.contentView addSubview:nameLabel];
        
    }
    UILabel *yearLabel = [cell.contentView.subviews objectAtIndex:0];
    UILabel *nameLabel = [cell.contentView.subviews objectAtIndex:1];
    
    yearLabel.text=[_yearDatas objectAtIndex:indexPath.row];
    
    NSDictionary *cityDict = [_datas objectAtIndex:indexPath.row];
    
    nameLabel.text = [cityDict objectForKey:@"modelName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *cityDict = [_datas objectAtIndex:indexPath.row];
    NSString *modelID=[cityDict valueForKey:@"modelId"];
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"chexing" object:self userInfo:cityDict];
    [[NSUserDefaults standardUserDefaults] setObject:modelID forKey:@"modelID"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Carinfo" object:nil];
    [self performSelector:@selector(goBackToUsed) withObject:nil afterDelay:0.3f];
}

- (void)goBackToUsed{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[UserCarViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
        
    }
}
-(void)download{
    //与安卓配合转化毫秒数
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    
    
    NSString *url=[NSString stringWithFormat:@"http://buss.956122.com/eval/carmodel/%@/1.do?callback=handler&_=%llu",_numStr ,recordTime];
    
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
        
        
        [_yearDatas addObject:[[_datas[0]valueForKey:@"modelName"] substringToIndex:5]];
        for(int i=1;i<_datas.count;i++){
            NSString *stringA =[[_datas[i]valueForKey:@"modelName"] substringToIndex:5];
            NSString *stringB=[[_datas[i-1]valueForKey:@"modelName"]substringToIndex:5];
            NSString * string;
            if ([stringA isEqualToString:stringB]) {
                string=@"";
            }else{
                
                
                string=stringA;
            }
            
            [_yearDatas addObject:string];
        }
        
        //  NSLog(@"%@",_yearDatas);
        
        [_rootTableView reloadData];
        
    }];
    
}
//视图已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_datas.count){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }
    
    
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
