//
//  CycleScrollView.m
//  UIScrollViewCyclePage
//
//  Created by 叶落风逝 on 14-8-31.
//  Copyright (c) 2014年 pinksun. All rights reserved.
//

#import "CycleScrollView.h"
#import "UIImageView+WebCache.h"


#define TimeInterval 5

@interface CycleScrollView ()
{
    UIScrollView *_scrollView;
    NSInteger _totalPage;
    NSInteger _curPage;
    CGRect _scrollFrame;

    ScrollDir _dir;
    CycleScrollDirection _scrollDirection;

    NSTimer *_scrollTimer;
    BOOL _scrolling;
}

@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) UIButton *pageLeftBtn;
@property (nonatomic, strong) UIButton *pageRightBtn;

@end

@implementation CycleScrollView

- (id)initWithFrame:(CGRect)frame
     cycleDirection:(CycleScrollDirection)direction
           pictures:(NSArray *)pictures
     didScrollBlock:(DidScrollBlock)scrollBlock
{
    if (self = [super initWithFrame:frame]) {
        _scrollFrame     = self.bounds;
        _scrollDirection = direction;
        _scrollBlock     = scrollBlock;

        _curPage    = 1;
        _totalPage  = pictures.count;
        _imageArray = [[NSArray alloc] initWithArray:pictures];

        //创建并设置ScrollView的属性
        _scrollView = [[UIScrollView alloc] initWithFrame:_scrollFrame];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.pagingEnabled                  = YES;
        _scrollView.delegate                       = self;
        [self addSubview:_scrollView];

        //根据滑动方向设置ScrollViewde内容大小(ContentSize)
        if (_scrollDirection == CycleScrollDirectionHorizontal) {
            _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
            [_scrollView setContentOffset:CGPointMake(_scrollFrame.size.width, 0)];
        }

        //垂直滑动
        if (_scrollDirection == CycleScrollDirectionVertical) {
            _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height * 3);
            [_scrollView setContentOffset:CGPointMake(0, _scrollFrame.size.height)];
        }

        //正向移动(向右滑动)
        _dir = ScrollDirAdd;

        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollFrame];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i + 1;
            [_scrollView addSubview:imageView];

            UITapGestureRecognizer *singelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
            [imageView addGestureRecognizer:singelTap];

            //水平滚动
            if (_scrollDirection == CycleScrollDirectionHorizontal) {
                imageView.origin = CGPointMake(_scrollFrame.size.width * i, 0);
            }

            //垂直滚动
            if (_scrollDirection == CycleScrollDirectionVertical) {
                imageView.origin = CGPointMake(0, _scrollFrame.size.height * i);
            }
        }

        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval
                                                        target:self
                                                      selector:@selector(timerEvent)
                                                      userInfo:nil
                                                       repeats:YES];

        [self refreshScrollView];
    }

    return self;
}

#pragma mark - handle event

- (void)tapEvent
{
    if ([_delegate respondsToSelector:@selector(cycleScrollView:didSelectImageView:)]) {
        [_delegate cycleScrollView:self didSelectImageView:_curPage - 1];
    }
}

- (void)goFront:(UIButton *)btn
{
    [self goWithDirection:_scrollDirection scrollDir:-_dir];
}

- (void)goNext:(UIButton *)btn
{
    [self goWithDirection:_scrollDirection scrollDir:_dir];
}

- (void)timerEvent
{
    [self goWithDirection:_scrollDirection scrollDir:_dir];
}

#pragma mark - private method

- (void)goWithDirection:(CycleScrollDirection)direction scrollDir:(ScrollDir)newdir
{
    if (_scrolling) {
        return;
    }

    _scrolling = YES;

    CGPoint tagetPoint = CGPointZero;

    if (direction == CycleScrollDirectionHorizontal) {
        tagetPoint = CGPointMake(_scrollFrame.size.width * (1 + newdir), 0);
    } else if (direction == CycleScrollDirectionVertical) {
        tagetPoint = CGPointMake(0, _scrollFrame.size.height * (1 + newdir));
    }

    [_scrollView setContentOffset:tagetPoint animated:YES];
}

- (void)setImageArray:(NSArray *)imageArray
{
    _curPage    = 1;
    _totalPage  = imageArray.count;
    _imageArray = [[NSArray alloc] initWithArray:imageArray];
    [self refreshScrollView];
}

- (void)refreshScrollView
{
    NSArray *currentImageArray = [self getDisplayImagesWithCurPage:_curPage];

    for (int i = 0; i < 3; i++) {
        UIImageView *imaView = (UIImageView *)[_scrollView viewWithTag:i + 1];
        NSString *urll = [(CircleScrollPictureModel *)currentImageArray[i] imageUrl];

        [imaView setImageWithURL:[NSURL URLWithString:[(CircleScrollPictureModel *)currentImageArray[i] imageUrl]] placeholderImage:nil];
    }

    
    
    if (_scrollDirection == CycleScrollDirectionHorizontal) {
        //设置当前的scrollView的当前偏移量设置为中间一页
        [_scrollView setContentOffset:CGPointMake(_scrollFrame.size.width, 0)];
    }

    if (_scrollDirection == CycleScrollDirectionVertical) {
        [_scrollView setContentOffset:CGPointMake(0, _scrollFrame.size.height)];
    }
}

- (NSArray *)getDisplayImagesWithCurPage:(NSInteger)page
{
    if (_imageArray.count < 1) {
        _scrollView.scrollEnabled = NO;
        [_scrollTimer invalidate];
        _scrollTimer = nil;
        return nil;
    } else if (_imageArray.count == 1) {
        _scrollView.scrollEnabled = NO;
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    } else {
        if (!_scrollTimer) {
            _scrollView.scrollEnabled = YES;
            _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval
                                                            target:self
                                                          selector:@selector(timerEvent)
                                                          userInfo:nil
                                                           repeats:YES];
        }
    }

    NSMutableArray *marr = [NSMutableArray array];

    NSInteger pre = [self validPageValue:_curPage - 1];
    NSInteger last = [self validPageValue:_curPage + 1];

    [marr addObject:_imageArray[pre - 1]];
    [marr addObject:_imageArray[_curPage - 1]];
    [marr addObject:_imageArray[last - 1]];
    return marr;
}

- (NSInteger)validPageValue:(NSInteger)value
{
    if (value == 0) { //如果是第一张就切到最后一张
        value = _totalPage;
    } else if (value == _totalPage + 1) { //如果是最后一张就切到第一张
        value = 1;
    }

    return value;
}

- (NSInteger)resetPageWithContentOffset:(CGPoint)contentOffset
{
    CGFloat x = contentOffset.x;
    CGFloat y = contentOffset.y;

    NSInteger currentPage = _curPage;

    //水平滚动
    if (_scrollDirection == CycleScrollDirectionHorizontal) {
        if (x >= (2 * _scrollFrame.size.width)) { //往下翻一张
            currentPage = [self validPageValue:_curPage + 1];
        }

        if (x <= 0) { //往上翻一张
            currentPage = [self validPageValue:_curPage - 1];
        }
    }

    //垂直滚动
    if (_scrollDirection == CycleScrollDirectionVertical) {
        if (y >= (2 * _scrollFrame.size.height)) { //往下翻一张
            currentPage = [self validPageValue:_curPage + 1];
        }

        if (y <= 0) { //往上翻一张
            currentPage = [self validPageValue:_curPage - 1];
        }
    }

    return currentPage;
}

#pragma mark - timer method

- (void)startTimer
{
    [_scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:TimeInterval]];
}

- (void)pauseTimer
{
    [_scrollTimer setFireDate:[NSDate distantFuture]];
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollBlock(_curPage - 1);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];

    _curPage = [self resetPageWithContentOffset:scrollView.contentOffset];
    [self refreshScrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _scrolling = NO;
    _curPage = [self resetPageWithContentOffset:scrollView.contentOffset];
    [self refreshScrollView];
}

- (void)setTimerInvalidate{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}
@end
