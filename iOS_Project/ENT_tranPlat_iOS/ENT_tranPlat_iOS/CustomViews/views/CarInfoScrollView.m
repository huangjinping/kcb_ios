//
//  RootScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "CarInfoScrollView.h"


#define POSITIONID (int)scrollView.contentOffset.x/300

@implementation CarInfoScrollView

//@synthesize viewNameArray;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
        
        _rootScrollView = [[UIScrollView alloc] initWithFrame:LGRectMake(0, 0, frame.size.width/PX_X_SCALE, frame.size.height/PX_X_SCALE - CAR_INFO_SCROLL_VIEW_PAGE_HEIGHT)];
        [_rootScrollView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];

        _rootScrollView.delegate = self;
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.bounces = NO;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        _rootScrollView.userInteractionEnabled = YES;
        [self addSubview:_rootScrollView];
        
        //_pageCon = nil;
        _pageCon = [[UIPageControl alloc] initWithFrame:LGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, CAR_INFO_SCROLL_VIEW_PAGE_HEIGHT)];
        _pageCon.backgroundColor = [UIColor clearColor];
        if (iOS6) {
            _pageCon.pageIndicatorTintColor = COLOR_FONT_NOTICE;
            _pageCon.currentPageIndicatorTintColor = COLOR_NAV;
        }
        [self addSubview:_pageCon];

    }
    return self;
}


#define TITLE_ADD_CAR       @"添加绑定车辆"
- (void)reloadCars:(NSArray *)carInfos
{
    //移除
    for (UIView *v in _rootScrollView.subviews) {
        [v removeFromSuperview];
    }
    NSInteger cpage = 0;
    if (_pageCon) {
        cpage = _pageCon.currentPage;
    }
    NSInteger pages = [carInfos count] >1 ? 2:([carInfos count] + 1);
    _rootScrollView.contentSize = CGSizeMake(_rootScrollView.width * pages, _rootScrollView.height);
    _pageCon.numberOfPages = pages;
    _pageCon.currentPage = cpage;
    
    NSMutableArray *titleArr = [[NSMutableArray alloc] initWithCapacity:0];
    while (pages) {
        [titleArr addObject:TITLE_ADD_CAR];
        pages -- ;
    }
    for (int i = 0; i < [carInfos count]; i++) {
        CarInfo *carInfo = [carInfos objectAtIndex:i];
        [titleArr replaceObjectAtIndex:i withObject:[carInfo.hphm uppercaseString]];
    }
    for (int i = 0; i < [titleArr count]; i++) {
        NSString *title = [titleArr objectAtIndex:i];
        if ([title isEqualToString:TITLE_ADD_CAR]) {
            //30 + 30 + 20 + 30 + 25 + 30 + 30
            
            UIView *addCarView = [[UIView alloc] initWithFrame:LGRectMake(i*_rootScrollView.w, 0, APP_PX_WIDTH,  CAR_VIEW_INFO_HEIGHT + CAR_VIEW_PECCANCY_HEIGHT)];
            addCarView.backgroundColor = [UIColor whiteColor];
            [_rootScrollView addSubview:addCarView];
            
            UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:LGRectMake((addCarView.w - 339)/2, (addCarView.h - 45)/2, 339, 45)];
            [bgImgView setImage:[UIImage imageNamed:@"add_car"]];
            [bgImgView setUserInteractionEnabled:YES];
            [addCarView addSubview:bgImgView];
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [addCarView addGestureRecognizer:tap];
            
            UILabel *line = [[UILabel alloc] initWithFrame:LGRectMake(addCarView.l, addCarView.h - 1, addCarView.w, 1)];
            [line setBackgroundColor:COLOR_FRAME_LINE];
            [addCarView addSubview:line];
            
            UILabel *msgl = [[UILabel alloc] initWithFrame:LGRectMake(30, addCarView.b + 20, 600, 24)];
            msgl.text = @"添加车辆后可查看违法、年检、保险等信息";
            [msgl convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
            [addCarView addSubview:msgl];
            
        } else {
            CarInfo *car = carInfos[i];
            HomeCarView *homeCarV = [[HomeCarView alloc] initWithCar:car.hphm];
            [homeCarV setFrame:LGRectMake(_rootScrollView.w*i, 0, APP_PX_WIDTH, _rootScrollView.h)];
            homeCarV.delegate_ = self;
            [_rootScrollView addSubview:homeCarV];
        }
    }
}

- (void)reloadPeccancy:(NSString *)hphm{
    for (UIView *v in _rootScrollView.subviews) {
        if ([v isKindOfClass:[HomeCarView class]]) {
            HomeCarView *homeCarV = (HomeCarView*)v;
            if ([homeCarV.carHphm isEqualToString:hphm]) {
                [homeCarV viewReloadCarPeccancyInfo];
                break;
            }
        }
    }
}
- (void)reloadOther:(NSString *)hphm{
    
    for (UIView *v in _rootScrollView.subviews) {
        if ([v isKindOfClass:[HomeCarView class]]) {
            HomeCarView *homeCarV = (HomeCarView*)v;
            if (hphm == nil) {
                [homeCarV viewReloadOtherInfo];
            }else if([homeCarV.carHphm isEqualToString:hphm]) {
                [homeCarV viewReloadOtherInfo];
                break;
            }
        }
    }
}

#pragma mark - HomeCarView DELEGATE
- (void)homeCarView:(HomeCarView *)homeCarView tapCarInfoWithHphm:(NSString *)hphm{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:car:didRespondAction:)]) {
        [self.scroll_delegate carInfoScrollView:self car:hphm didRespondAction:actionEnterCarInfo];
    }
}
- (void)homeCarView:(HomeCarView *)homeCarView tapCarLogoWithHphm:(NSString *)hphm{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:car:didRespondAction:)]) {
        [self.scroll_delegate carInfoScrollView:self car:hphm didRespondAction:actionLogoChange];
    }
}
- (void)homeCarView:(HomeCarView *)homeCarView tapPeccancyInfoWithHphm:(NSString *)hphm{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:car:didRespondAction:)]) {
        [self.scroll_delegate carInfoScrollView:self car:hphm didRespondAction:actionEnterPeccancyRecord];
    }
    
}

- (void)homeCarView:(HomeCarView *)homeCarView tapZhaohuiWithHphm:(NSString *)hphm{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:car:didRespondAction:)]) {
        [self.scroll_delegate carInfoScrollView:self car:hphm didRespondAction:actionEnterZhaohui];
    }
}

#pragma mark - tap to add car
- (void)tap:(UITapGestureRecognizer *)tap{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollViewDidTapForAdd)]) {
        [self.scroll_delegate carInfoScrollViewDidTapForAdd];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageCon.currentPage = scrollView.contentOffset.x/scrollView.width;
}


@end
