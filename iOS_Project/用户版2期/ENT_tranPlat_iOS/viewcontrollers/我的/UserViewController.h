//
//  UserViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-30.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserViewController : BasicViewController<
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate
>
{
    UITableView             *_rootTableView;
}


@end
