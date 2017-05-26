//
//  RootScrollView.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeCarView.h"


@class CarInfoScrollView;
@protocol CarInfoScrollViewDelegate <NSObject>

@optional
- (void)carInfoScrollView:(CarInfoScrollView*)scrollView car:(NSString*)hphm didRespondAction:(Action)action;

- (void)carInfoScrollViewDidTapForAdd;

@end

@interface CarInfoScrollView : UIView <
UIScrollViewDelegate,
HomeCarViewDelegate
>
{
    
    UIScrollView                        *_rootScrollView;
    UIPageControl                       *_pageCon;
    
    
}

@property (nonatomic, assign) id<CarInfoScrollViewDelegate>   scroll_delegate;

- (void)reloadCars:(NSArray *)carInfos;
- (void)reloadPeccancy:(NSString *)hphm;
- (void)reloadOther:(NSString *)hphm;

@end
