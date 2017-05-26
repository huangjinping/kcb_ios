//
//  CustomSectionView.m
//  CLEnterpriseIM
//
//  Created by Wendy on 14-8-7.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "CustomSectionView.h"

@implementation CustomSectionView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id<CustomSectionViewDelegate>)delegate showArrow:(BOOL)show
{
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        _section = sectionNumber;
        _delegate = delegate;
        _opened = isOpened;

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, frame.size.height)];
        _titleLabel.text = [NSString stringWithFormat:@"%@", title];
        _titleLabel.font = V3_42PX_FONT;
        _titleLabel.textColor = RGB(76, 76, 76);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];

        _foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _foldBtn.frame = CGRectMake(APP_WIDTH-30, (frame.size.height - 20) / 2, 20.0, 20);
        if (show) {//有子项的话  显示箭头以及点击事件
            [_foldBtn setImage:[UIImage imageNamed:@"contact_pullRight_image"] forState:UIControlStateNormal];
            [_foldBtn setImage:[UIImage imageNamed:@"contact_pullDown_image"] forState:UIControlStateSelected];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(toggleAction:)];
            [self addGestureRecognizer:tapGesture];

        }

        _foldBtn.backgroundColor = [UIColor clearColor];
        _foldBtn.userInteractionEnabled = NO;
        _foldBtn.selected = isOpened;
        [self addSubview:_foldBtn];

        [self addLineWithFrame:CGRectMake(0, 43, APP_WIDTH, 1) lineColor:[UIColor lightGrayColor]];
    }

    return self;
}

- (void)toggleAction:(id)sender
{
    _foldBtn.selected = !_foldBtn.selected;

    if (1) {
        if ([_delegate respondsToSelector:@selector(CustomSectionView:sectionOpened:)]) {
            [_delegate CustomSectionView:self sectionOpened:_section];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(CustomSectionView:sectionClosed:)]) {
            [_delegate CustomSectionView:self sectionClosed:_section];
        }
    }
}

@end
