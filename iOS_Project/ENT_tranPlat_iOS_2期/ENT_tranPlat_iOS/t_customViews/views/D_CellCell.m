//
//  D_CellCell.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-11.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "D_CellCell.h"

@implementation D_CellCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (id)initWithIdentifier:(NSString*)identifier{
    if (self = [super init]) {
        
        _identifier = identifier;
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        CGFloat cellWidth = APP_WIDTH/3;
        CGFloat imgWidth = 60;
        CGFloat spaceX = (cellWidth - imgWidth)/2;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceX, 10, imgWidth, imgWidth)];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [_imgView addGestureRecognizer:longPressGR];
        
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeButton setImage:[UIImage imageNamed:@"chat_remove_friend.png"] forState:UIControlStateNormal];
        _removeButton.backgroundColor = [UIColor clearColor];
        [_removeButton addTarget:self action:@selector(removeFriend:) forControlEvents:UIControlEventTouchUpInside];
        [_removeButton setFrame:CGRectMake(_imgView.left - 10, _imgView.top - 10, 25, 25)];
        _removeButton.hidden = YES;
        [self addSubview:_removeButton];
        
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize size = [@"测试好友姓名" sizeWithFont:font constrainedToSize:CGSizeMake(APP_WIDTH/3 - spaceX, 100) lineBreakMode:NSLineBreakByCharWrapping];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, APP_WIDTH/3 - spaceX, size.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = font;
        //_titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
//        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _titleLabel.bottom, APP_WIDTH/3 - spaceX - 10, 0)];
//        _subTitleLabel.backgroundColor = [UIColor clearColor];
//        _subTitleLabel.font = [UIFont systemFontOfSize:10];
//        _subTitleLabel.numberOfLines = 0;
//        [self addSubview:_subTitleLabel];

        
        
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        //解决ios5系统bug-手势与button并存的问题
        [self removeFriend:nil];
        return NO;
    }
    
    return YES;
}

- (void)taped:(UITapGestureRecognizer*)tap{

    if(!_removeButton.hidden){
        _removeButton.hidden = YES;
        //终止动画
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             self.transform=CGAffineTransformIdentity;
             
         } completion:^(BOOL finished) {}];
        
        return;
    }
    

    if ([self.delegate_ respondsToSelector:@selector(D_CellCell:beTaped:)]) {
        [self.delegate_ D_CellCell:self beTaped:tap];
    }
}

- (void)longPressed:(UILongPressGestureRecognizer*)longPress{
    
    if (_imgView.image == nil){
        return;
    }

    _removeButton.hidden = NO;
    [UIView animateWithDuration:0.12 delay:0.01 options:0 animations:^{
        
        self.transform = CGAffineTransformMakeRotation(-0.05);
    
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.12 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
         {
             self.transform = CGAffineTransformMakeRotation(0.05);
             
         } completion:^(BOOL finished) {
             
         }];
        
    }];
    
}

- (void)removeFriend:(UIButton*)button{
    if ([self.delegate_ respondsToSelector:@selector(D_CellCell:removeFriend:)]) {
        [self.delegate_ D_CellCell:self removeFriend:_titleLabel.text];
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
