//
//  ChatImageView.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-9-26.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatImageView.h"

@implementation ChatImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}
- (void)addTitle
{
    
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CLASSIFY_BLOG_IMAGE_HEIGHT - 25, self.frame.size.width, 25)];
    [titleBgView setBackgroundColor:[UIColor lightGrayColor]];
    titleBgView.alpha = 0.5;
    [self addSubview:titleBgView];
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CLASSIFY_BLOG_IMAGE_HEIGHT - 20, self.frame.size.width, 20)];
    titleLable.text = self.dname;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont boldSystemFontOfSize:16];
    titleLable.textColor = [UIColor whiteColor];
    [self addSubview:titleLable];

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(chatImageClicked:)]) {
        [self.delegate chatImageClicked:self];
    }
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
