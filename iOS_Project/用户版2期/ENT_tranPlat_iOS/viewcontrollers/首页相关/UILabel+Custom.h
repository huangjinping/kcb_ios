//
//  UILabel+Custom.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor;

@end
