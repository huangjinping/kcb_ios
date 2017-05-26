//
//  CarBindViewController.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@class CarInfoViewController;

@class CarInfoViewController;

#define TAG_ALERT_BIND_SUCC         101
#define TAG_ALERT_BIND_FAILED       102
#define TAG_ALERT_GO_TO_DRIVER_BIND       103

#define TAG_BUTTON_START_PICKE_HPZL             103
#define TAG_BUTTON_START_PICKE_HPHM_PREFIX       104

#define TAG_PICKER_PICK_HPZL             105
#define TAG_PICKER_PICK_HPHM_PREFIX       106

#define PICKER_VIEW_HEIGHT              200
#define PICKER_HEIGHT                   170


@interface CarBindViewController : BasicViewController<
UITextFieldDelegate,
UIAlertViewDelegate
>
{
    
    //UIPickerView        *_picker;
    //UIView              *_pickerView;
    
    
    //UILabel             *_hpzlNameLabel;
    //UILabel             *_hphmPrefixLabel;
    //UITextField         *_hphmTF;
    //UITextField         *_recognizerTextField;
    
    
    //NSArray                 *_hpzlNameArr;//号牌种类名称码表
    //NSArray                 *_hphmPrefixArr;//号牌前缀码表
    
    //NSArray                 *_pickerDatasourceArr;
}

//@property (nonatomic, retain)   NSString    *hphmStr;
//@property (nonatomic, retain)   NSString    *sbmStr;

//@property(nonatomic,strong)NSString *hpzlCode;


//当响应重新绑定时，对car赋值
@property (nonatomic, retain)   NSString    *reBindHphm;
- (id)initWithRebindHphm:(NSString*)hphm;

@end
