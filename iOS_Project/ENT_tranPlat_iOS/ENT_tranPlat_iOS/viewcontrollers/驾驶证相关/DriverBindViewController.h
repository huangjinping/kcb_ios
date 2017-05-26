//
//  DriverBindViewController.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"

@class DriverInfoViewController;

@interface DriverBindViewController : BasicViewController<
UITextFieldDelegate,
UIAlertViewDelegate
>

{
    UITextField             *_xmTF;
    UITextField             *_sfzhmTF;
    UITextField             *_dabhTF;
    UITextField             *_zxbhTF;
}


@property(nonatomic,copy)NSString *xmStr;
@property(nonatomic,copy)NSString *sfzhmStr;
@property(nonatomic,copy)NSString *dabhStr;
@property(nonatomic,copy)NSString *zxbhStr;


//for rebind
@property(nonatomic,strong)DriverInfo       *reBindDriver;

@end
