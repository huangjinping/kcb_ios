//
//  UIHelper.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIHelper : NSObject


+ (UIColor *)getColor:(NSString *)hexColor;


typedef void (^createThumbImgesCompletion) (NSData *imgData);
/***********************************************************************
 *功能：   创建压缩剪裁后的图片
 *参数：   原图片，剪裁尺寸，压缩比，存储路径，回调
 *返回值：  无
 ***********************************************************************/
+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent onCompletion:(createThumbImgesCompletion)completion;

//+ (UIFont *)sysFontOfSize:(CGFloat)fontSize;
//+ (UIFont *)boldSysFontOfSize:(CGFloat)fontSize;
//+ (UIFont *)italicSysFontOfSize:(CGFloat)fontSize;

+ (void)addArrowOnView:(UIView*)v;
@end
