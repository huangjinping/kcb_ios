//
//  DateSelectView.h
//  ywjk
//
//  Created by 李蒙 on 14-5-28.
//  Copyright (c) 2014年 picc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CompletionBlock)(NSDate *date);

@interface DateSelectView : UIView

    singleton_interface(DateSelectView)

@property (nonatomic, retain) UIDatePicker *datePicker;

/**
 *  回调block
 */
@property (nonatomic, copy) CompletionBlock okButtonClickBlock;

/**
 *  显示选择日期
 *
 *  @param okButtonClickBlock 点击确定回调日期
 */
- (void)showWithCompletion:(CompletionBlock)okButtonClickBlock;

@end
