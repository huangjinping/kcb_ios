//
//  UILabel+Custom.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor{
    
    self = [[UILabel alloc]initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.font = font;
    }
    
    return self;
}

@end
