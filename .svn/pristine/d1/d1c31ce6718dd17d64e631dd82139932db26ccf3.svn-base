//
//  SetCityViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/6.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ChooseViewController.h"
#import "UserCarViewController.h"
#import "AllCityModel.h"

@interface ChooseViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView     *_rootTableView;
}


@end

@implementation ChooseViewController

- (void)goBackToBXE{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[UserCarViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:self.pname];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*PX_X_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cityArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"chooseCityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = V3_32PX_FONT;
        cell.textLabel.textColor = COLOR_FONT_NOMAL;
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   AllCityModel *cityModel = _cityArr[indexPath.row];

    cell.textLabel.text =  cityModel.cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllCityModel *cityModel = _cityArr[indexPath.row];
    

    NSString *cityName =  cityModel.cityName;
    NSString *cityCode = cityModel.cityId;
    NSString *panme=self.pname;
    NSString *AllName=[[NSString alloc]init];
    if([panme isEqualToString:cityName]){
    AllName=[NSString stringWithFormat:@"%@",cityName];

    
    }else{
    AllName=[NSString stringWithFormat:@"%@ %@",panme,cityName];
    }
    NSMutableDictionary *dicBook = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicBook setObject:AllName forKey:@"name"];
    
    
    
     [[NSUserDefaults standardUserDefaults] setObject:cityCode forKey:KEY_CITY_CODE_IN_USERDEFAULTUSE];
    
    //NSLog(@"%@",cityCode);
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"shengfen" object:self userInfo:dicBook];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choose" object:nil];
    [self performSelector:@selector(goBackToBXE) withObject:nil afterDelay:0.3f];
//
    
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
