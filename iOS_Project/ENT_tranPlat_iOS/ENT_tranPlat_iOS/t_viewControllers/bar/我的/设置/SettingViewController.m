//
//  SettingViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-5.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "SettingViewController.h"
#import "ShareSetViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgimgV = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:APP_VIEW_Y/PX_X_SCALE + 30 width:APP_PX_WIDTH height:30*3];
    [self.view addSubview:bgimgV];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:YYRectMake(bgimgV.w - 30 - 24, 30, 24, 24)];
    [imgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgimgV addSubview:imgView];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 500, 30)];
    [textLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [textLabel setText:@"告诉朋友"];
    [bgimgV addSubview:textLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToShare)];
    [bgimgV addGestureRecognizer:tap];

    bgimgV = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgimgV.b + 30 width:APP_PX_WIDTH height:30*3 * 3];
    [self.view addSubview:bgimgV];
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, bgimgV.width, bgimgV.height - 2) style:UITableViewStylePlain];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    _rootTableView.showsVerticalScrollIndicator = NO;
    _rootTableView.scrollEnabled = YES;
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _rootTableView.scrollEnabled = NO;
    [bgimgV addSubview:_rootTableView];
    if ([_rootTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_rootTableView setSeparatorInset:UIEdgeInsetsMake(0, 30*PX_X_SCALE, 0, 0)];
    }
    
    bgimgV = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgimgV.b + 30 width:APP_PX_WIDTH height:30*3];
    [self.view addSubview:bgimgV];
    imgView = [[UIImageView alloc] initWithFrame:YYRectMake(bgimgV.w - 30 - 24, 30, 24, 24)];
    [imgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgimgV addSubview:imgView];
    textLabel = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 500, 30)];
    [textLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [textLabel setText:@"关于开车邦"];
    [bgimgV addSubview:textLabel];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToGuangyu)];
    [bgimgV addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self setCustomNavigationTitle:@"通用设置"];
    [_rootTableView reloadData];
}


//- (void)logOut:(UIButton*)button{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注销用户" message:@"是否确认注销当前用户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//    [alert show];
//    
//}


#pragma mark- tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30*3*PX_X_SCALE;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"setting_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:YYRectMake(tableView.w - 30 - 24, 30, 24, 24)];
        [imgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
        [cell.contentView addSubview:imgView];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 500, 30)];
        [textLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:textLabel];
        
    }
    NSString *string = @"";
    switch (indexPath.row) {
        case 0:
            string = @"用户协议";
            break;
        case 1:
            string = @"交通违法网上自助处理使用协议";
            break;
        case 2:
            string = @"车友互动使用协议";
            break;
        default:
            
            break;
    }
    UILabel *textLabel = [cell.contentView.subviews lastObject];
    textLabel.text = string;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//用户协议
        DriverServicePlatDealViewController *dspdVC = [[DriverServicePlatDealViewController alloc] init];
        [self.navigationController pushViewController:dspdVC animated:YES];
    }else if (indexPath.row == 1) {//交通违法网上自助处理使用协议
        SelfHelpDealViewController *selfhelpVC = [[SelfHelpDealViewController alloc] init];
        [self.navigationController pushViewController:selfhelpVC animated:YES];
    }else if (indexPath.row == 2) {//车友互动使用协议
        RidersInteractionViewController *ridersVC = [[RidersInteractionViewController alloc] init];
        [self.navigationController pushViewController:ridersVC animated:YES];
    }
    
}

- (void)tapToShare{
    ShareSetViewController *shareVC = [[ShareSetViewController alloc] init];
    [self.navigationController pushViewController:shareVC animated:YES];

}

- (void)tapToGuangyu{
    AboutSetViewController *aboutVC = [[AboutSetViewController alloc] init];
    [self.navigationController pushViewController:aboutVC animated:YES];

}


//#pragma mark- alertview delegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == alertView.cancelButtonIndex) {
//        
//    }else{
//        
//        NSArray *activeusers = [[DataBase sharedDataBase] selectActiveUser];
//        UserInfo *user = [activeusers lastObject];
//        user.isActive = ACTIVE_USER_NO;
//        [user update];
//        
//        APP_DELEGATE.loginSuss = NO;
//        APP_DELEGATE.userId = @"";
//        APP_DELEGATE.userName = @"";
//        
//    }
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
