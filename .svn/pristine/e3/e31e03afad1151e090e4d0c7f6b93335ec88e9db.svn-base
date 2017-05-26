//
//  AboutViewController.m
//  Merchant
//
//  Created by Wendy on 16/1/26.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "AboutViewController.h"
#import <UIImageView+WebCache.h>
#import "ChangePasswordController.h"
#import "XMLDictionary.h"

#define kAppStore @"http://itunes.apple.com/cn/lookup?id=com.tranPlat.Merchant"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorBackgroud;
    [self setNavTitle:@"设置"];
    // Do any additional setup after loading the view.
//    [self createHeaderView];
    [self createFooterView];
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
- (void)createHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 133, 60)];
    logoImg.image = [UIImage imageNamed:@"admin logo"];
    logoImg.centerX = headerView.centerX;
    [headerView addSubview:logoImg];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImg.bottom+5, APP_WIDTH, 60)];
    versionLabel.text = [NSString stringWithFormat:@"版本号：%@",version];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = V3_42PX_FONT;
    [headerView addSubview:versionLabel];
    self.tableView.tableHeaderView = headerView;
}
- (void)createFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, PX_Y_SCALE*120)];
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(0, PX_Y_SCALE*50, 300, PX_Y_SCALE*50);
    [exitBtn setTitle:@"退出当前账号"];
    [exitBtn setTitleColor:kColor0X39B44A];
    exitBtn.centerX = footerView.centerX;
    [exitBtn addTarget:self action:@selector(btnAction:)];
    [exitBtn addBorderWithWidth:2 color:kColor0X39B44A corner:10];
    [footerView addSubview:exitBtn];
    self.tableView.tableFooterView = footerView;
}
- (void)btnAction:(UIButton *)sender{
    [ApplicationDelegate setLoginViewController];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginUserAccount];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginUserPassword];
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PX_Y_SCALE*60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = V3_42PX_FONT;
        cell.textLabel.textColor = kColor0X666666;
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"清除缓存"];
        cell.textLabel.text = @"清除缓存";
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        CGFloat sizeFloat = size/1024;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fk",sizeFloat];
        
    }else if(indexPath.section == 1){
        cell.imageView.image = [UIImage imageNamed:@"版本更新"];
        cell.textLabel.text = @"版本更新";
        
    }if(indexPath.section == 2){
        cell.imageView.image = [UIImage imageNamed:@"修改密码"];
        cell.textLabel.text = @"修改密码";
        
    }
    return cell;
}

- (void)backEvent:(UIBarButtonItem *)paramItem
{
    [ApplicationDelegate goBackHomeView];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        //清除缓存
        [UIHelper alertWithTitle:@"温馨提示"
                             msg:@"即将对缓存图片及临时文件进行清理"
                  viewController:self
                   confirmAction:^{
                       [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                           [UIHelper alertWithMsg:@"清除缓存成功"];
                           [self.tableView reloadData];
                       }];
                   } cancelAction:nil];
        
    }else if(indexPath.section == 1){
//        [UIHelper alertWithMsg:@"该版本已是最新版本"];
//        return;
        NSURL *url=[NSURL URLWithString:kHttpAppUpdate];
        NSString *str4 = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithXMLString:str4];
        [self dealCheckAppUpdate:dict];
    }else{
        ChangePasswordController *pass = [[ChangePasswordController alloc] init];
        pass.from = 1;
        [self.navigationController pushViewController:pass animated:YES];
    }
}


- (void)dealCheckAppUpdate:(id)responseObject{
    if (responseObject) {
        NSString *vnum = responseObject[@"version"];
        NSString *appstoreUrl = responseObject[@"appurl_ios"];
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (![vnum compare:currentVersion] == NSOrderedSame) {
                //非强制
                RIButtonItem *cancleItem = [RIButtonItem itemWithLabel:@"取消"
                                                                  type:RIButtonItemType_Cancel
                                                                action:^{
                                                                    //
                                                                }];
                RIButtonItem *confirmItem = [RIButtonItem itemWithLabel:@"升级"
                                                                   type:RIButtonItemType_Destructive
                                                                 action:^{
                                                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl]];
                                                                 }];
                BOAlertController *alert = [[BOAlertController alloc] initWithTitle:@"温馨提示"
                                                                            message:@"有新的版本，是否升级"
                                                                     viewController:self];
                [alert addButtons:@[cancleItem,confirmItem]];
                [alert show];
        }else{
            //没升级
            [UIHelper alertWithMsg:@"该版本已是最新版本"];
        }

    }else{
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    }
}
@end
