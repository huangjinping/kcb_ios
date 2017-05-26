//
//  SetCityViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/6.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SetCityViewController.h"
#import "BXPerfectCarinfoViewController.h"
#import "BYSelectServiceViewController.h"

@interface SetCityViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView     *_rootTableView;
}

@end

@implementation SetCityViewController

- (void)goBackToBX{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[BXPerfectCarinfoViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }else if ([vc isKindOfClass:[BYSelectServiceViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
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
    return 100*PX_Y_SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cityArr count];
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
    NSDictionary *cityDict = [self.cityArr objectAtIndex:indexPath.row];
    NSString *cityName = [cityDict objectForKey:@"name"];
    //NSString *cityCode = [cityDict objectForKey:@"code"];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cityDict = [self.cityArr objectAtIndex:indexPath.row];
    NSString *cityName = [cityDict objectForKey:@"name"];
    NSString *cityCode = [cityDict objectForKey:@"code"];
    
//    UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
//    user.citySet = cityName;
//    [user update];
    
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:KEY_CITY_NAME_IN_USERDEFAULTBX];
    [[NSUserDefaults standardUserDefaults] setObject:cityCode forKey:KEY_CITY_CODE_IN_USERDEFAULTBX];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY_SET_CHANGEDBX object:self userInfo:cityDict];
    [self performSelector:@selector(goBackToBX) withObject:nil afterDelay:0.3f];
    

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
