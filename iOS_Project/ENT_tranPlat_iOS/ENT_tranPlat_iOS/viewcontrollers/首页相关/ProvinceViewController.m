//
//  SetProvinceViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/6.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ProvinceViewController.h"
#import "ChooseViewController.h"


@interface ProvinceViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView     *_rootTableView;
}

@property (nonatomic)   NSMutableArray          *provsArr;
@property (nonatomic)   NSMutableDictionary      *dataDict;
@property (nonatomic)   NSMutableArray          *provArr;
@property (nonatomic)   NSMutableArray          *OneCityArr;
@property (nonatomic, strong) NSMutableArray    *cityArr;
@property(nonatomic,strong)AllCityModel *citymodel;
@property(nonatomic,strong)ALLProvName *promodel;


@end

@implementation ProvinceViewController
//
//- (void)gobackPage{
//    [self dismissModalViewControllerAnimated:YES];
//}
//视图已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_cityArr.count){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _provsArr=[[NSMutableArray alloc]init];
    _provArr=[[NSMutableArray alloc]init];
    _OneCityArr=[[NSMutableArray alloc]init];
     [self download];
   

    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"选择省"];
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _provArr.count;
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
    _promodel = _provArr[indexPath.row];
    cell.textLabel.text = _promodel.provName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseViewController *vc=[[ChooseViewController alloc]init];
    _promodel = _provArr[indexPath.row];
    vc.pname= _promodel.provName;
    
    
    NSMutableArray *array=[[NSMutableArray array]init];
    
    for (AllCityModel *model in _OneCityArr) {
        if (model.provId==_promodel.provId) {
            [ array addObject:model];
        }
    }

    
    vc.cityArr=array;
    
    
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)download{
    //与安卓配合转化毫秒数
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
 
    NSString *url=[NSString stringWithFormat:@"http://buss.956122.com/eval/allCity/1.do?callback=handler&_=%llu",recordTime];
    
    [BLMHttpTool kcbgetWithURL:url params:nil success:^(id json) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSMutableString *mutString=[[NSMutableString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            NSRange range=[mutString rangeOfString:@"])"];
            [mutString deleteCharactersInRange:range];
            [mutString deleteCharactersInRange:NSMakeRange(0, 9)];

        
            NSData *jsonData = [mutString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
        _provsArr=[dic valueForKey:@"provs"];
        _cityArr=[dic valueForKey:@"datas"];

        for (NSDictionary * provsDic in _provsArr) {
    
            _promodel= [ALLProvName  modelWithDic:provsDic];
            
            [_provArr addObject:_promodel];
          
            
        }
        
        
        for (NSDictionary * datasDic in _cityArr) {
            
            _citymodel= [AllCityModel  modelWithDic:datasDic];
            
            [_OneCityArr addObject:_citymodel];
            
        }


    
         [_rootTableView reloadData];
        
     
    } failure:^(NSError *error) {
        
    }];


    
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
