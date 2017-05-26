//
//  BXSelecteInsMoneyViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baoxian.h"

#define TAG_BUTTON_SELECTED_INS_SANZHE          784//三者
#define TAG_BUTTON_SELECTED_INS_SIJI            785//司机
#define TAG_BUTTON_SELECTED_INS_CHENGKE         786//乘客
#define TAG_BUTTON_SELECTED_INS_BOLI            787//玻璃
#define TAG_BUTTON_SELECTED_INS_HUAHEN          788//划痕

@interface BXSelecteInsMoneyViewController : BasicViewController



@property (nonatomic, assign)       NSInteger       ins_type_tag;
@property (nonatomic)               Baoxian         *baoxian;


@end
