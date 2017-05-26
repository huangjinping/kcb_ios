//
//  UIHelper.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    //截取red部分
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    //截取green部分
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    //截取blue部分
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    return color;
}

/***********************************************************************
 *功能：   创建压缩剪裁后的图片
 *参数：   原图片，剪裁尺寸，压缩比，存储路径，回调
 *返回值：  无
 ***********************************************************************/
+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent onCompletion:(createThumbImgesCompletion)completion{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    else {
        scaleFactor = heightFactor;
    }
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [image drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    
    completion(thumbImageData);
}

+ (void)addArrowOnView:(UIView*)v{
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(v.w - 30 - 30, (v.h - 30)/2, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [v addSubview:arrowImgView];
}
//+ (UIFont *)sysFontOfSize:(CGFloat)fontSize{
//    return [UIFont systemFontOfSize:(fontSize*PX_SCALE)];
//}
//
//+ (UIFont *)boldSysFontOfSize:(CGFloat)fontSize{
//    return [UIFont boldSystemFontOfSize:(fontSize*PX_SCALE)];
//
//}
//
//+ (UIFont *)italicSysFontOfSize:(CGFloat)fontSize{
//    return [UIFont italicSystemFontOfSize:(fontSize*PX_SCALE)];
//
//}


@end
