//
//  AppDelegate.h
//  Merchant
//
//  Created by Wendy on 15/12/16.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MELoginData.h"
#import <IQKeyboardManager.h>
#define APP_KEY_MAP @"04020b8673e6a3c6a8d0563748e0956a"

//@class TabBarController;
#import "TabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DDMenuController *menuController;
@property (nonatomic, strong) TabBarController *tabBarController;
@property (nonatomic, assign) BOOL showLeftController;
@property (nonatomic, assign) BOOL showingRootController;

@property (nonatomic, strong) MELoginData *shareLoginData;
@property (nonatomic, copy) NSString *accountId;
- (void)setLoginViewController;
- (void)pushViewController:(UIViewController *)viewController;
- (void)popViewController;
- (void)goBackHomeView;
- (void)loadHomeView;
@end

