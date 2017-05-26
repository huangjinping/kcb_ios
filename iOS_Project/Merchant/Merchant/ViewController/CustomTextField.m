//
//  CustomTextField.m
//  Merchant
//
//  Created by Wendy on 16/1/6.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "CustomTextField.h"

#define kTitle_Font [UIFont systemFontOfSize:16]
#define kTitle_TextColor [UIColor lightGrayColor]

@interface CustomTextField ()
{
    UIImageView *rightImageView;
}
@end

@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder
{
    if (self = [super initWithFrame:frame]) {

        UILabel *settingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, frame.size.height)];
        settingLab.text = title;
        settingLab.textColor = kTitle_TextColor;
        settingLab.font = kTitle_Font;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = settingLab;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

        self.rightViewMode = UITextFieldViewModeAlways;
        rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        rightImageView.image = [UIImage imageNamed:@"timeIcon_green"];
        rightImageView.userInteractionEnabled = YES;
        rightImageView.contentMode = UIViewContentModeCenter;
        self.rightView = rightImageView;
//        self.enabled = NO;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)];
        [rightImageView addGestureRecognizer:tapGesture];

    }
    
    return self;
}

- (void)headerTap:(id)sender{
    NSLog(@"点击");
}
- (void)setRightViewImage:(NSString *)string{
    rightImageView.image = [UIImage imageNamed:string];
}
@end
