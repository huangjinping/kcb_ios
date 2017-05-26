//
//  SegmentView.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "SegmentButtonView.h"

@implementation SegmentButtonView

- (void)setTitles:(NSArray *)titles withTitleColor:(UIColor*)color
{
    _titles = [NSArray arrayWithArray:titles];
    
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
    
    float width = self.bounds.size.width/titles.count;
    float height = self.bounds.size.height;
    //标题下方的横线视图
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 4 ,width, 2)];
    _lineView.backgroundColor = [UIHelper getColor:@"#1877c3"];
    [self addSubview:_lineView];
    
    
    for (int i=0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, height - 5);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        if (color) {
            [button setTitleColor:color forState:UIControlStateNormal];
            [button setTitleColor:color forState:UIControlStateSelected];
        }else {
            [button setTitleColor:[UIHelper getColor:@"#8d8d8d"] forState:UIControlStateNormal];
            [button setTitleColor:[UIHelper getColor:@"#1877c3"] forState:UIControlStateSelected];
        }
        
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    self.selectedIndex = 0;
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_white_top.png"]];
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
        _lineView.frame = CGRectMake(width * self.selectedIndex, self.bounds.size.height-4, width, 2);
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
