//
//  UsedCarViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/28.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedCarViewController.h"
#import "UsedStpyViewController.h"

@interface UsedCarViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic,strong)NSMutableArray* datas;
@property (nonatomic,strong)NSMutableArray* wordDatas;
@property (nonatomic,strong)UITableView *rootTableView;
@end

@implementation UsedCarViewController

- (void)viewDidLoad {
    
    _datas=[[NSMutableArray alloc]init];
    _wordDatas =[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self download];
    [self creatUI];
    
}
//视图已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_datas.count){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }
    
    
}
-(void)creatUI{
    
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UILabel *wordLabel = [[UILabel alloc] initWithFrame:LGRectMake( 20, 10, 40  , 40)];
        [wordLabel convertNewLabelWithFont: SYS_FONT_SIZE(35) textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:wordLabel];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:LGRectMake( 50, 80,APP_PX_WIDTH-30, 30)];
        [nameLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:nameLabel];
        
        
    }
    CarModel *model=[[CarModel alloc]init];
    model = [_datas objectAtIndex:indexPath.row];
    
    UILabel *wordLabel = [cell.contentView.subviews objectAtIndex:0];
    UILabel *nameLabel = [cell.contentView.subviews objectAtIndex:1];
    wordLabel.text=[_wordDatas objectAtIndex:indexPath.row];
    
    NSString *cityName = model.name;
    
    nameLabel.text = cityName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsedStpyViewController *vc=[[UsedStpyViewController alloc]init];
    CarModel *model=[[CarModel alloc]init];
    model = [_datas objectAtIndex:indexPath.row];
    
    NSString *string = model.id;
    vc.numStr =string;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


-(void)download{
    //与安卓配合转化毫秒数
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    //  NSString *stringTime =[NSString stringWithFormat:@"%llu",recordTime];
    
    NSString *url=[NSString stringWithFormat:@"http://buss.956122.com/eval/allBrand/1.do?callback=handler&_=%llu",recordTime];
    
    MyAFNetWorkingRequest  * myAF=[MyAFNetWorkingRequest alloc];
    myAF =[[MyAFNetWorkingRequest alloc]initWithRequest:url andParams:nil andBlock:^(NSData *requestData) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        NSMutableString *mutString=[[NSMutableString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        NSRange range=[mutString rangeOfString:@"])"];
        [mutString deleteCharactersInRange:range];
        [mutString deleteCharactersInRange:NSMakeRange(0, 9)];
        
        NSData *jsonData = [mutString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *arr= [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
        for (NSDictionary *dic in arr) {
            
            CarModel *model= [CarModel  modelWithDic:dic];
            
            [_datas addObject:model];
        }
        
        
        [_wordDatas addObject:@"A"];
        for(int i=1;i<arr.count;i++){
            NSString *stringA =[arr[i]valueForKey:@"initial"];
            NSString *stringB=[arr[i-1]valueForKey:@"initial"];
            NSString * string;
            if ([stringA isEqualToString:stringB]) {
                string=@"";
            }else{
                
                
                string=stringA;
            }
            
            [_wordDatas addObject:string];
        }
        
        
        
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
