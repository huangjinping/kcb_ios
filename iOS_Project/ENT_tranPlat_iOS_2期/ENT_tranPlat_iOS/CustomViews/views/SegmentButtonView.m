//
//  SegmentView.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "SegmentButtonView.h"
@interface SegmentButtonView ()

@end
@implementation SegmentButtonView

- (void)setTitles:(NSArray *)titles withTitleNorColor:(UIColor*)norColor andTitleSelColor:(UIColor*)selColor
{
    _titles = [NSArray arrayWithArray:titles];
    _titleNorColor = norColor;
    _titleSelColor = selColor;
    
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
    
    float width = self.bounds.size.width/titles.count;
    float height = self.bounds.size.height;
    //标题下方的横线视图
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 1 ,width, 1)];
    _lineView.backgroundColor = _lineColor;
    [self addSubview:_lineView];
    
   
    
    for (int i=0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, height - 5);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:selColor forState:UIControlStateNormal];
        }else {
            [button setTitleColor:norColor forState:UIControlStateNormal];
        }
        
        button.tag = i;
        button.titleLabel.font = FONT_NOMAL;
        
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.selectedIndex = button.tag;
    }
 
    
    
}


- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor andLineColor:(UIColor*)lineColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        _lineColor = lineColor;
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_white_top.png"]];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)action:(UIButton *)button
{
    self.selectedIndex = button.tag;

    if ([self.delegate respondsToSelector:@selector(segmentButtonView:showView:)]) {
        [self.delegate segmentButtonView:self showView:self.selectedIndex];
    }

   
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (selectedIndex != _selectedIndex) {
        _selectedIndex = selectedIndex;
        
        
        
        [self changeButtonLine];
    }
    
    
    
}

- (void)changeButtonLine{
    float width = self.bounds.size.width/self.titles.count;
    if (self.selectedIndex > self.titles.count - 1) {
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        _lineView.frame = CGRectMake(width * self.selectedIndex, self.bounds.size.height-1, width, 1);
        
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton*)subView;
                if (button.tag == self.selectedIndex) {
                    [button setTitleColor:_titleSelColor forState:UIControlStateNormal];
                }else{
                    [button setTitleColor:_titleNorColor forState:UIControlStateNormal];
                }
            }
        }
    }];
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
