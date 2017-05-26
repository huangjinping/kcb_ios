//
//  UITools.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BOAlertController.h"
#import "RIButtonItem.h"

@interface UITools : NSObject

/**
 *  显示UIActivityIndicatorView
 *
 *  @param v 在view中显示
 *
 *  @return 对应的HUD
 */
+ (MBProgressHUD *)showIndicatorToView:(UIView*)v;

/**
 *  显示UIActivityIndicatorView
 *
 *  @param text 显示的文字信息
 *  @param v    在view中显示
 *
 *  @return 对应的HUD
 */
+ (MBProgressHUD *)showIndicatorWithText:(NSString*)text ToView:(UIView*)v;

/**
 *  显示纯文字信息，不是提示框，会自动消失
 *
 *  @param text 显示的文字信息
 *  @param v    在view中显示
 *
 *  @return 对应的HUD
 */
+ (MBProgressHUD *)showText:(NSString*)text ToView:(UIView*)v;

/**
 *  隐藏HUD框
 *
 *  @param v HUD在view中显示
 */
+ (void)hideHUDForView:(UIView *)v;
+ (void)hideSingleHUDForView:(UIView *)view;

/**
 *  显示完成图片及文字信息，1秒后 隐藏HUD框
 *
 *  @param text 显示的文字信息
 *  @param v    HUD在view中显示
 */
+ (void)hideHUDWithCompletedText:(NSString *)text forView:(UIView *)v;

/**
 *  弹出提示框信息
 *
 *  @param msg 内容
 */
+ (UIAlertView *)alertWithMsg:(NSString*)msg;

/**
 *  弹出提示框信息
 *
 *  @param title 标题
 *  @param msg   内容
 */
+ (UIAlertView *)alertWithTitle:(NSString*)title andMsg:(NSString*)msg;

/**
 *  弹出带有一个确定按钮的提示框信息
 *
 *  @param msg            提示内容
 *  @param viewController 显示在哪个viewController
 *  @param action         点击确定按钮触发的事件
 *
 *  @return BOAlertController
 */
+ (BOAlertController *)alertWithMsg:(NSString*)msg viewController:(UIViewController *)viewController action:(void (^)(void))action;

/**
 *  弹出带有一个确定，一个取消，共两个按钮的提示框信息
 *
 *  @param msg            提示内容
 *  @param viewController 显示在哪个viewController
 *  @param confirmAction  点击确定按钮触发的事件
 *  @param cancelAction   点击取消按钮触发的事件
 *
 *  @return BOAlertController
 */
+ (BOAlertController *)alertWithMsg:(NSString*)msg viewController:(UIViewController *)viewController confirmAction:(void (^)(void))confirmAction cancelAction:(void (^)(void))cancelAction;

/**
 *  弹出带有一个确定按钮的提示框信息
 *
 *  @param title          提示标题
 *  @param msg            提示内容
 *  @param viewController 显示在哪个viewController
 *  @param action         点击确定按钮触发的事件
 *
 *  @return BOAlertController
 */
+ (BOAlertController *)alertWithTitle:(NSString*)title msg:(NSString*)msg viewController:(UIViewController *)viewController action:(void (^)(void))action;

/**
 *  弹出带有一个确定，一个取消，共两个按钮的提示框信息
 *
 *  @param title          提示标题
 *  @param msg            提示内容
 *  @param viewController 显示在哪个viewController
 *  @param confirmAction  点击确定按钮触发的事件
 *  @param cancelAction   点击取消按钮触发的事件
 *
 *  @return BOAlertController
 */
+ (BOAlertController *)alertWithTitle:(NSString*)title msg:(NSString*)msg viewController:(UIViewController *)viewController confirmAction:(void (^)(void))confirmAction cancelAction:(void (^)(void))cancelAction;


@end
