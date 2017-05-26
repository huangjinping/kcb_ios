//
//  SettingViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-5.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitySetViewController.h"
#import "AdviceSetViewController.h"
#import "ShareSetViewController.h"
#import "DriverServicePlatDealViewController.h"
#import "SelfHelpDealViewController.h"
#import "AboutSetViewController.h"
#import "RidersInteractionViewController.h"

@interface SettingViewController : BasicViewController<
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate
>
{
    UITableView             *_rootTableView;
}
@end
