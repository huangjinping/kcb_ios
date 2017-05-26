//
//  CarInfoViewController.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"

@class CarBindViewController;

#define TAG_BUTTON_CANCEL_BIND     707
#define TAG_BUTTON_RE_BIND         708

#define TAG_ALERT_CANCEL_BIND         709

@interface CarInfoViewController : BasicViewController



- (id)initWithHphm:(NSString*)hphm;
@end
