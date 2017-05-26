//
//  EiddtingViewController.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/14.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"

@interface EiddtingViewController : BasicViewController

@property (nonatomic, assign)BOOL faxian;
@property (nonatomic, assign)BOOL res;
@property (nonatomic, strong)CarInfo *carInfo;
@property (nonatomic, copy)void(^commplete)(void);

@end
