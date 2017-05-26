//
//  ZKButton.h
//  bolock
//
//  Created by zhaokai on 15/5/28.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKButton;


//注意:这里最好传一个参数,而且这个参数最好是当前按钮自身,这样可以将按钮的所有属性都传出去
typedef void (^myBlock)(ZKButton *button);

@interface ZKButton : UIButton

@property (nonatomic,copy) myBlock tempBlock;

+(ZKButton *)normalButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel;

+(ZKButton *)easyButtonWithFrame:(CGRect)frame type:(UIButtonType )type title:(NSString *)title andBlock:(myBlock)block;
+(ZKButton *)blockButtonWithFrame:(CGRect)frame type:(UIButtonType )type title:(NSString *)title backgroundImage:(NSString *)image andBlock:(myBlock)block;

+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType )type title:(NSString *)title target:(id)target icon:(NSString *)icon andSel:(SEL)sel;
@end
