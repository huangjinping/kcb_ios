//
//  CommentView.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/29.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "CommentView.h"

@interface CommentView()

@property (nonatomic, assign ,readwrite) NSInteger index;

@end

@implementation CommentView
{
    UIButton *_tempBtn;
}
+ (CommentView *)shareCommentView{
    CommentView *cv = [[CommentView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 132*y_6_plus)];
    
    return cv;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 2;
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180*x_6_plus, self.height)];
        l.text = @"订单评价";
        l.textColor = kTextGrayColor;
        l.font = V3_38PX_FONT;
        l.centerY = self.boundsCenter.y;
        
        [self addSubview:l];
        
        NSArray *titleArr = @[@"好评",@"中评",@"差评"];
        NSArray *iconArr = @[@"pj01 hover",@"pj02 hover",@"pj03 hover"];
        NSArray *icons = @[@"pj01",@"pj02",@"pj03"];
        
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            __block __typeof(btn) weakBtn = btn;
            [btn addActionBlock:^(id weakSender) {
                _index = weakBtn.tag;
                _tempBtn.selected = NO;
                weakBtn.selected = YES;
                _tempBtn = weakBtn;
                
            } forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2-i;
            btn.frame = CGRectMake(l.right+230*x_6_plus*i, 0, 230*x_6_plus, self.height);
            btn.centerY = self.boundsCenter.y;
            [btn setTitle:titleArr[i]];
            [btn setTitleColor:kTextGrayColor];
            [btn setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateSelected];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.width, 0, btn.imageView.width)];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.width, 0, -btn.titleLabel.width)];
            if (i == 0) {
                btn.selected = YES;
                _tempBtn = btn;
            }
            btn.titleLabel.font = V3_38PX_FONT;
            
            [self addSubview:btn];
        }
    }
    
    return self;
}

@end
