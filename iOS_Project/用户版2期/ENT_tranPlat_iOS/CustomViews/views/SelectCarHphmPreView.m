//
//  SelectCarHphmPreView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/22.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SelectCarHphmPreView.h"

@interface SelectCarHphmPreView ()

{
    NSString    *_jiancheng;
    NSString    *_quancheng;
}

@end

@implementation SelectCarHphmPreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
            jiancheng:(NSString*)jiancheng
            quancheng:(NSString*)quancheng{
    if (self = [super initWithFrame:frame]) {
        _jiancheng = [[NSString alloc] initWithString:jiancheng];
        _quancheng = [[NSString alloc] initWithString:quancheng];
        
        [self loadViewWithFrame:frame];
    }
    return self;
}

- (void)loadViewWithFrame:(CGRect)frame{

    UILabel *hline = [UILabel lineLabelWithPXPoint:CGPointMake(0, frame.size.height/PX_Y_SCALE - 1)];
    [hline setSize:CGSizeMake(frame.size.width, 1*PX_X_SCALE)];
    [self addSubview:hline];
    UILabel *vline = [UILabel lineLabelWithPXPoint:CGPointMake(frame.size.width/PX_X_SCALE - 1, 0)];
    [vline setSize:CGSizeMake(1*PX_X_SCALE, frame.size.height)];
    [self addSubview:vline];
    
    UILabel *jianchengL = [[UILabel alloc] initWithFrame:LGRectMake(0, (self.h - 30)/2, self.w/2, 30)];
    [jianchengL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    jianchengL.text = _jiancheng;
    [self addSubview:jianchengL];
    
    UILabel *quanchengL = [[UILabel alloc] initWithFrame:LGRectMake(jianchengL.r, (self.h - 30)/2, self.w/2, 30)];
    [quanchengL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    quanchengL.text = _quancheng;
    [self addSubview:quanchengL];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
    [self addGestureRecognizer:tap];
}

- (void)taped{
    self.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    if ([self.delegate_ respondsToSelector:@selector(selectCarHphmPreView:tapJiancheng:)]) {
        [self.delegate_ selectCarHphmPreView:self tapJiancheng:_jiancheng];
    }
}

@end
