//
//  QuestionNoticeView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/22.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "QuestionNoticeView.h"

@implementation QuestionNoticeView
{
    UILabel *_titleL;
    UIImageView *_imgv;
}


- (id)initWithFrame:(CGRect)frame image:(UIImage*)img andTitle:(NSString*)title{
    if (self = [super initWithFrame:frame]) {
        //[self loadViewWithT:title andimg:img];
        
        self.backgroundColor = [UIColor whiteColor];
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, 20)];
        [_titleL convertNewLabelWithFont:[UIFont systemFontOfSize:16] textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        _titleL.text = title;
        [self addSubview:_titleL];
        
        _imgv = [[UIImageView alloc] initWithFrame:CGRectMake(10, _titleL.bottom + 5, self.width - 10*2, 900*(self.width - 20*2)/1320)];
        [_imgv setImage:img];
        [self addSubview:_imgv];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [_titleL setFrame:CGRectMake(10, 10, self.width - 20, 20)];
    [_imgv setFrame:CGRectMake(10, _titleL.bottom + 5, self.width - 10*2, 900*(self.width - 20*2)/1320)];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
