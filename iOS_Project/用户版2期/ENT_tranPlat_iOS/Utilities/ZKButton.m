//
//  ZKButton.m
//  bolock
//
//  Created by zhaokai on 15/5/28.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKButton.h"
#import "UIImageView+WebCache.h"
@implementation ZKButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(ZKButton *)normalButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel{
    ZKButton *button = [ZKButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(ZKButton *)easyButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(myBlock)block{
    ZKButton *button = [ZKButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];

    [button addTarget:button action:@selector(blockButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //将参数接收过来,保存到成员变量中
    button.tempBlock = block;
    
    return button;
}
+(ZKButton *)blockButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title backgroundImage:(NSString *)image andBlock:(myBlock)block
{
    ZKButton *button = [ZKButton buttonWithType:type];
    button.frame = frame;
    [button addTarget:button action:@selector(blockButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];

    //创建上面的图片视图
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
//    [button addSubview:imageView];
//    //将参数接收过来,保存到成员变量中
    button.tempBlock = block;
    
    return button;
    
    
}
+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType )type title:(NSString *)title target:(id)target icon:(NSString *)icon andSel:(SEL)sel
{
    ZKButton *button = [ZKButton buttonWithType:type];
    button.frame = frame;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
   
    //创建下面的标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 50, 15)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    //创建上面的图片视图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:icon]];
    [button addSubview:imageView];
    
    return button;
}


-(void)blockButtonclicked:(ZKButton *)button{
    //执行block变量
    button.tempBlock(button);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
