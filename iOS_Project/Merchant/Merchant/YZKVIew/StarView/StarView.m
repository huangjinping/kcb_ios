//
//  StarView.m
//  RongChuang
//
//  Created by cooperLink on 15/4/10.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import "StarView.h"
#import "UIView+Extend.h"



#define kMaxStarNumber (5)
#define kDefaultStarSpace (3.0)
#define kImageScale (1)

@interface StarView ()

@property (nonatomic, assign) CGFloat starSpace;

@property (nonatomic, assign) CGFloat starHeight;
@property (nonatomic, strong) UIView *highlightStarBackgroundimageView;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, assign) NSInteger starNum;

@end

@implementation StarView

-(instancetype)initWithImageName:(NSString*)imageName
{
    self = [super init];
    if (self) {
        _imgName = imageName;
        [self creatSubViewWith:imageName];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName starSpace:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self) {
        _starSpace = space;
        _starLevelSize = STARSMALL;
        _imgName = imageName;
        [self creatSubViewWith:imageName];
    }
    
    return self;
}



-(void)awakeFromNib
{
    [self creatSubViewWith:@"icon_choiceLife_unlight_star"];
}


-(void)highPraiseTapEvent:(UITapGestureRecognizer *)tgr
{
    UIView *tapView = tgr.view;
    if ([tapView isKindOfClass:[UIImageView class]]) {
        [self setHighPraise:tapView.tag];
        if (_SelectStarFinished) {
            _SelectStarFinished(tapView.tag);
        }
    }
}

-(void)creatSubViewWith:(NSString*)imageName
{
    if (_starSpace == 0) {
        _starSpace = kDefaultStarSpace;
    }
    
    // 星 为 大星 时为写评论的，此时开启点击 添加星数评论
    _enabled = [imageName isEqualToString:@"star02"];
    
    _highlightStarBackgroundimageView = [[UIView alloc] initWithFrame:self.bounds];
    _highlightStarBackgroundimageView.backgroundColor = [UIColor clearColor];
    _highlightStarBackgroundimageView.clipsToBounds = YES;
    

    
    // 灰色 星
    [self creatStarviewWith:[UIImage imageNamed:imageName] superview:self];
    
    // 高亮 星
    [self creatStarviewWith:[UIImage imageNamed:@"star01"] superview:_highlightStarBackgroundimageView];
    [self addSubview:_highlightStarBackgroundimageView];
}


#pragma mark - 设置好评 星数
// 根据好评的比例设置好评星的长度
-(void)setHighPraiseWith:(CGFloat)highPraiseRatio
{
    CGFloat ratio = MAX(0, MIN(highPraiseRatio, 1));
    
    CGFloat width = CGRectGetWidth(_highlightStarBackgroundimageView.frame)*ratio;
    [_highlightStarBackgroundimageView setWidth:width];
}
// 根据好评星数设置好评星长度
-(void)setHighPraise:(NSInteger)starNumber
{
    _starNum = starNumber;
    NSInteger starNO =  MAX(0, MIN(starNumber, kMaxStarNumber));
    
    [_highlightStarBackgroundimageView setWidth:(_starHeight + _starSpace)*starNO];
}




#pragma mark - creat star view

-(void)creatStarviewWith:(UIImage*)image superview:(UIView*)superView
{
    
    // 获取 frame 值
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    CGFloat imageHeight = image.size.height;
    
    if (_starHeight == 0) {
        _starHeight = (selfHeight > imageHeight) ? imageHeight : selfHeight;
    }
    CGFloat orginY = (selfHeight - _starHeight)/2;
    
    for (int i = 0; i < kMaxStarNumber; ++i) {
        CGFloat orginX = (_starHeight + _starSpace)*i;
        CGRect frame = CGRectMake(orginX, orginY, _starHeight, _starHeight);
        [superView addSubview:[self creatStarviewWith:frame imageName:image tag:i+1]];
    }
    // 重新设置superview的frame
    CGFloat maxWidth = (_starHeight + _starSpace)*kMaxStarNumber - _starSpace;
    [superView setWidth:maxWidth];
    [self setWidth:maxWidth];
    
}

-(void)setStarLevelSize:(StarLevel)starLevelSize{
    _starLevelSize = starLevelSize;
    _starHeight = (_starLevelSize == STARMIDDLE || _starLevelSize == STARMIDDLE_) ? 1.5*_starHeight : _starHeight;
    _starSpace = _starLevelSize == STARMIDDLE ? 3.5*_starSpace : _starSpace;
    for (UIView *subV in self.subviews) {
        if ([subV isKindOfClass:[UIImageView class]]) {
            [subV removeFromSuperview];
        }
    }
    [_highlightStarBackgroundimageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self creatStarviewWith:[UIImage imageNamed:_imgName] superview:self];
    [self creatStarviewWith:[UIImage imageNamed:@"icon_choiceLife_light_star"] superview:_highlightStarBackgroundimageView];
    [self bringSubviewToFront:_highlightStarBackgroundimageView];
    [self setHighPraise:_starNum];
}


-(UIImageView*)creatStarviewWith:(CGRect)frame imageName:(UIImage*)image tag:(NSInteger)tag
{
    UIImageView *starImageView = [self creatviewWith:frame];
    starImageView.tag = tag;
    if (image) {
        starImageView.image = image;
    }
//    [starImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highPraiseTapEvent:)]];
    starImageView.userInteractionEnabled = _enabled;
    return starImageView;
}

-(UIImageView*)creatviewWith:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
