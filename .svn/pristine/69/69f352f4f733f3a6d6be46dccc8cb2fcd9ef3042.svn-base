//
//  UserViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-30.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "UserViewController.h"
#import "PayRecordViewController.h"
#import "DealingRecordViewController.h"
#import "UserInfoViewController.h"
#import "InformationCenterListViewController.h"

@interface UserViewController ()
{
    UIImageView         *_userPhotoImgView;
    UILabel             *_userNameL;
    UILabel             *_userTelL;
    NSIndexPath          *_numNoticeIndex;
    NSArray  *_dataArray;
    UILabel *_txTLabel;
}
@end

@implementation UserViewController


- (void)reloadUserView{
    
    if (APP_DELEGATE.loginSuss) {
        UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
        if (!user.photoLocalPath || [user.photoLocalPath isEqualToString:@""]) {
            [_userPhotoImgView setImage:[UIImage imageNamed:@"chat_portrait_photo"]];
        }else{
            if ([UIImage imageWithContentsOfFile:user.photoLocalPath]) {
                [_userPhotoImgView setImage:[UIImage imageWithContentsOfFile:user.photoLocalPath]];
            }else{//丢失？？
                [NETHelper asynchronousDownloadPhotoImage];
            }
            
        }
        [_userNameL setText:user.userName];
        _userNameL.textColor = COLOR_FONT_NOMAL;
        [_userTelL setText:[NSString stringWithFormat:@"手机号：%@", user.contactNum]];
    }else{
        [_userPhotoImgView setImage:[UIImage imageNamed:@"chat_portrait_photo"]];
        [_userNameL setText:@"请先登录"];
        _userNameL.textColor = COLOR_FONT_NOTICE;
        [_userTelL setText:@""];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray =[[NSArray alloc]init];
    _dataArray = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
    [_rootTableView reloadData];
    [NETHelper fetchNotifycations];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserView) name:NOTIFICATION_FINISH_DOWNLOAD_PHOTO object:nil];
    
    UIScrollView *rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT)];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    //用户信息部分
    UIImageView *userBgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:(80 + 30*2)];
    [rootScrollView addSubview:userBgImgView];
    _userPhotoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 80, 80)];
    [userBgImgView addSubview:_userPhotoImgView];
    _userNameL = [[UILabel alloc] initWithFrame:LGRectMake(_userPhotoImgView.r + 20, 40, 400, 30)];
    [_userNameL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [userBgImgView addSubview:_userNameL];
    _userTelL = [[UILabel alloc] initWithFrame:LGRectMake(_userNameL.l, _userNameL.b + 15, 500, 24)];
    [_userTelL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [userBgImgView addSubview:_userTelL];
    [UIHelper addArrowOnView:userBgImgView];
    //    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(userBgImgView.w - 30 - 30, (userBgImgView.h - 30)/2, 30, 30)];
    //    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    //    [userBgImgView addSubview:arrowImgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserInfo)];
    [userBgImgView addGestureRecognizer:tap];
    
    //我的车辆等部分
    UIImageView *mineComponentsBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:userBgImgView.b + 30 width:APP_PX_WIDTH height:(90 * 6)];
    [rootScrollView addSubview:mineComponentsBgView];
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mineComponentsBgView.width, mineComponentsBgView.height)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    _rootTableView.showsVerticalScrollIndicator = NO;
    _rootTableView.scrollEnabled = NO;
    if ([_rootTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_rootTableView setSeparatorInset:UIEdgeInsetsMake(0, 30*PX_X_SCALE, 0, 0)];
    }
    [mineComponentsBgView addSubview:_rootTableView];
    
    //设置部分
    UIImageView *setttingBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:mineComponentsBgView.b + 30 width:APP_PX_WIDTH height:(90 * 1)];
    [rootScrollView addSubview:setttingBgView];
    [UIHelper addArrowOnView:setttingBgView];
    
    
    CGFloat width = 44;
    CGFloat height = 44;
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, 25, width, height)];
    [logoImgView setImage:[UIImage imageNamed:@"mine_setting"]];
    [setttingBgView addSubview:logoImgView];
    
    width = 400;
    height = 30;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:LGRectMake(logoImgView.r + 30, 30, width, height)];
    [textLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [textLabel setText:@"设置"];
    [setttingBgView addSubview:textLabel];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSetting)];
    [setttingBgView addGestureRecognizer:tap];
    
    CGFloat contentSizeHeight = setttingBgView.bottom + 10;
    if (contentSizeHeight > rootScrollView.height) {
        [rootScrollView setContentSize:CGSizeMake(APP_WIDTH, contentSizeHeight)];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    
    [self setCustomNavigationTitle:@"我的开车邦"];
    [self setBackButtonHidden:YES];
    
    [self reloadUserView];
    if (!APP_DELEGATE.loginSuss && APP_DELEGATE.firstTimeOnUserPage) {
        APP_DELEGATE.firstTimeOnUserPage = NO;
        [self goToLoginPage];
        
       
    }else{
        
        _dataArray =[[NSArray alloc]init];
        _dataArray = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
        [_rootTableView reloadData];
        [NETHelper fetchNotifycations];
    }
    //    _dataArray =[[NSArray alloc]init];
    //    _dataArray = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
    //    [_rootTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark- tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 30*3*PX_Y_SCALE;
    return height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"mmineComponentsCellCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(tableView.w - 30 - 30, (30*3 - 30)/2, 30, 30)];
        [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
        [cell.contentView addSubview:arrowImgView];
        
        CGFloat width = 44;
        CGFloat height = 44;
        UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, 25, width, height)];
        [cell.contentView addSubview:logoImgView];
        
        width = 400;
        height = 30;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:LGRectMake(logoImgView.r + 30, 30, width, height)];
        [textLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:textLabel];
        
        if (_dataArray.count) {
            if(indexPath.row==5){
                
                
                
                _txTLabel = [[UILabel alloc] initWithFrame:LGRectMake( 380, 30, 40  , 40)];
                _txTLabel.layer.masksToBounds = YES;
                _txTLabel.layer.cornerRadius = 10.0;
                
                
                NSString *string=[NSString stringWithFormat:@"%lu",(unsigned long)_dataArray.count];
                _txTLabel.text=string;
                _txTLabel.textColor=COLOR_FONT_NOMAL;
                _txTLabel.font=FONT_NOTICE;
                _txTLabel.backgroundColor=[UIColor redColor];
                _txTLabel.textAlignment = NSTextAlignmentCenter;
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:@"xiaoxi" object:nil];
                
                [cell.contentView addSubview:_txTLabel];
                
                
            }
        }
        
    }
    
    UIImageView *logoImgView = [cell.contentView.subviews objectAtIndex:1];
    UILabel *textLabel = [cell.contentView.subviews objectAtIndex:2];
    NSString *string = @"";
    
    switch (indexPath.row) {
        case 0:
            string = @"我的缴款单";
            [logoImgView setImage:[UIImage imageNamed:@"mine_wdjkdd"]];
            
            break;
        case 1:
            string = @"我的车辆";
            [logoImgView setImage:[UIImage imageNamed:@"mine_car"]];
            
            break;
        case 2:
            string = @"我的驾驶证";
            [logoImgView setImage:[UIImage imageNamed:@"mine_drivelicense"]];
            
            break;
        case 3:
            string = @"决定书编号缴款";
            [logoImgView setImage:[UIImage imageNamed:@"mine_jdsbhjk"]];
            
            break;
        case 4:
            string = @"违法处理明细";
            [logoImgView setImage:[UIImage imageNamed:@"mine_wfclmx"]];
            
            break;
        case 5:
            string = @"我的系统消息提醒";
            [logoImgView setImage:[UIImage imageNamed:@"message"]];
            
            break;
        default:
            break;
    }
    textLabel.text = string;
    
    return cell;
}

-(void)change{
    
    _txTLabel.backgroundColor=[UIColor clearColor];
    _txTLabel.text=@"";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4){
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    // }
    
    if (indexPath.row == 0) {//我的缴款单
        PayRecordViewController *prvc = [[PayRecordViewController alloc] init];
        [self.navigationController pushViewController:prvc animated:YES];
    }else if (indexPath.row == 1) {//我的车辆
        CarManagerViewController *carManaVC = [[CarManagerViewController alloc] init];
        [self.navigationController pushViewController:carManaVC animated:YES];
    }else if (indexPath.row == 2) {//我的驾驶证
        NSArray *drivers = [[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId];
        if ([drivers count]) {
            DriveLicenseManageViewController *driveLMVC = [[DriveLicenseManageViewController alloc] init];
            [self.navigationController pushViewController:driveLMVC animated:YES];
        }else{
            DriverBindViewController *dbvc = [[DriverBindViewController alloc] init];
            [self.navigationController pushViewController:dbvc animated:YES];
        }
        
    }else if (indexPath.row == 3) {//决定书编号缴款
        JDSBHSearchPayViewController *jdsbhSearchPayVC = [[JDSBHSearchPayViewController alloc] init];
        [self.navigationController pushViewController:jdsbhSearchPayVC animated:YES];
    }else if (indexPath.row == 4) {//违法处理明细
        DealingRecordViewController *drvc = [[DealingRecordViewController alloc] init];
        [self.navigationController pushViewController:drvc animated:YES];
    }else if (indexPath.row == 5) {//我的消息提醒
        InformationCenterListViewController *infoVC = [[InformationCenterListViewController alloc] init];
        
        [self.navigationController pushViewController:infoVC animated:YES];
        //   [_rootTableView reloadData];
    }
}

- (void)tapUserInfo{
    if (!APP_DELEGATE.loginSuss) {
        [self goToLoginPage];
        return;
    }
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

- (void)tapSetting{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
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
