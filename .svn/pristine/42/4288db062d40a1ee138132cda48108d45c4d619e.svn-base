//
//  TabBarController.m
//  Merchant_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/11.
//  Copyright © 2015年 xinpenghe. All rights reserved.
//

#import "TabBarController.h"
#import "BarItem.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent     = NO;
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [self createCustomTabBarVC];
//    [self requestServiceSetting];
}
//- (void)requestServiceSetting{
//    NSInteger merid = ApplicationDelegate.shareLoginData.userdata.mid;
//    NSDictionary *param = @{@"merid":[NSNumber numberWithInteger:merid].stringValue};
//    [AFNHttpRequest afnHttpRequestUrl:kHttpSettingList param:param success:^(id responseObject){
//        if (kRspCode(responseObject) == 0) {
//            NSArray *settingList = responseObject[@"body"][@"settingList"];
//            NSArray   * settingArray =[MESettingList mj_objectArrayWithKeyValuesArray:settingList];
//            if ([self unSettingService:settingArray]) {
//                [UIHelper alertWithTitle:@"温馨提示" msg:@"请设置您的服务项目及其工时费" viewController:self confirmAction:^{
//                    self.selectedIndex=3;
//                } cancelAction:^{
//                    
//                }];
//            }
//        }
//    } failure:^(NSError *error) {
//        [UIHelper alertWithMsg:kNetworkErrorDesp];
//    } view:self.view];
//}
//
// -(BOOL)unSettingService:(NSArray   *)settingArray{
//     if (settingArray==nil) {
//         return false;
//     }
//     for (MESettingList *msg in settingArray) {
//         if (msg.lm==nil) {
//             return false;
//         }
//         for (Lm  *lm in msg.lm) {
//             if (lm.mid!=nil&&lm.mid.length!=0) {
//                 return false;
//             }
//         }
//     }
//     return true;
// }
- (void)createCustomTabBarVC
{
    //设置选中状态和非选中的字体大小和颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#3d4245"], NSForegroundColorAttributeName, V3_28PX_FONT, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#e7e7e7"], NSForegroundColorAttributeName, V3_28PX_FONT, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    
    CATransition *animation = [CATransition animation];
    animation.duration            = 0.25;
    animation.timingFunction      = UIViewAnimationCurveEaseInOut;
    animation.type                = kCATransitionFade;
    animation.removedOnCompletion = YES;
    
    CGFloat offset = 3;
    //首页
    HomeViewController *homeV = [[HomeViewController alloc] init];
    UINavigationController *homeNa = [[UINavigationController alloc] initWithRootViewController:homeV];
    homeNa.tabBarItem.title = @"首页";
    [homeNa.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -offset)];
    homeNa.tabBarItem.imageInsets = UIEdgeInsetsMake(-offset, 0, offset, 0);
    homeNa.tabBarItem.image = [[UIImage imageNamed:@"home-默认"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNa.tabBarItem.selectedImage = [[UIImage imageNamed:@"home-交互"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //订单管理
    FaxianViewController *orderMc = [[FaxianViewController alloc] init];
    UINavigationController *orderMVN = [[UINavigationController alloc] initWithRootViewController:orderMc];
    [orderMVN.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -offset)];
    orderMVN.tabBarItem.imageInsets = UIEdgeInsetsMake(-offset, 0, offset, 0);
    orderMVN.tabBarItem.title = @"专属服务";
    orderMVN.tabBarItem.image = [[UIImage imageNamed:@"专属服务-默认"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderMVN.tabBarItem.selectedImage = [[UIImage imageNamed:@"专属服务-交互"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //账单
    ChatViewController *billMc = [[ChatViewController alloc] init];
    UINavigationController *purchaseVN = [[UINavigationController alloc] initWithRootViewController:billMc];
    purchaseVN.tabBarItem.title = @"邦邦车友";
    [purchaseVN.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -offset)];
    purchaseVN.tabBarItem.imageInsets = UIEdgeInsetsMake(-offset, 0, offset, 0);
    purchaseVN.tabBarItem.image = [[UIImage imageNamed:@"邦邦车友-默认"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    purchaseVN.tabBarItem.selectedImage = [[UIImage imageNamed:@"邦邦车友-交互"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //服务设置
    MineViewController *AccessoriesPc = [[MineViewController alloc] init];
    UINavigationController *clientVN = [[UINavigationController alloc] initWithRootViewController:AccessoriesPc];
    clientVN.tabBarItem.title = @"个人中心";
    [clientVN.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -offset)];
    clientVN.tabBarItem.imageInsets = UIEdgeInsetsMake(-offset, 0, offset, 0);
    clientVN.tabBarItem.image = [[UIImage imageNamed:@"个人中心-默认"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    clientVN.tabBarItem.selectedImage = [[UIImage imageNamed:@"个人中心-交互"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
        NSArray *viewControllers = @[homeNa, orderMVN, purchaseVN, clientVN];
    self.viewControllers = viewControllers;
}

@end
