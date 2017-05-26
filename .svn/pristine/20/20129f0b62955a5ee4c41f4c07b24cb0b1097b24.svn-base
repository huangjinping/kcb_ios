//
//  RootScrollView.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarView.h"
#import "SegmentButtonView.h"


@class CarInfoScrollView;
@protocol CarInfoScrollViewDelegate <NSObject>

@optional
- (void)carInfoScrollView:(CarInfoScrollView*)scrollView car:(CarInfo*)car didRespondAction:(Action)action;

- (void)carInfoScrollView:(CarInfoScrollView*)scrollView didTapCar:(CarInfo*)car;

- (void)carInfoScrollViewDidTapForAdd;

- (void)carInfoScrollViewDidTapBlank;

@end

@interface CarInfoScrollView : UIView <
UIScrollViewDelegate,
CarViewDelegate,
SegmentButtonViewDelegate
>
{
    
    SegmentButtonView                   *_segButtonView;
    //UIView                              *_carBlankView;
    //NSMutableArray                             *_carViews;
    
    UIScrollView                        *_rootScrollView;
    
    //NSArray                             *viewNameArray;
    ///CGFloat                             userContentOffsetX;
    //BOOL                                isLeftScroll;
    
    
}

//@property (nonatomic, retain) NSArray *viewNameArray;

@property (nonatomic, assign) id<CarInfoScrollViewDelegate>   scroll_delegate;

//数据加载
- (void)reloadData:(NSArray *)carInfos;

@end
