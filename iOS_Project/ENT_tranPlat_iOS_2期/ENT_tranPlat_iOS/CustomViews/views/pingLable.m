//
//  pingLable.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-9.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "pingLable.h"

@implementation pingLable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentLeft;
        self.numberOfLines = 0;
        self.lineBreakMode = NSLineBreakByCharWrapping;
                
    }
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(pingLableClicked:)]) {
        [self.delegate pingLableClicked:self];
    }
}

@end
