//
//  TabBarViewController.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-9-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ChatViewController.h"
#import "MineViewController.h"
#import "FaxianViewController.h"


#define TAG_BUTTON_BASIC            400

#define TAG_BUTTON_SHOUYE           400
#define TAG_BUTTON_HUDONG           401
#define TAG_BUTTON_FAXIAN           402
#define TAG_BUTTON_MINE             403


@interface TabBarViewController : UITabBarController<UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *tabBarView;

@end
