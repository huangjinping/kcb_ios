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
        
        
        //userContentOffsetX = 0;
        self.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
        
        _segButtonView = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, SEGMENT_BUTTON_VIEW_HEIGHT)];
        _segButtonView.delegate = self;
        [self addSubview:_segButtonView];
        
        _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segButtonView.bottom + 5, frame.size.width, frame.size.height - 5 - SEGMENT_BUTTON_VIEW_HEIGHT)];
        [_rootScrollView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
        _rootScrollView.contentSize = CGSizeMake(_rootScrollView.width * 2, _rootScrollView.height);
        _rootScrollView.delegate = self;
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.bounces = NO;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        _rootScrollView.userInteractionEnabled = YES;
        [self addSubview:_rootScrollView];
    }
    return self;
}


#define TITLE_ADD_CAR       @"添加绑定车辆"
- (void)reloadData:(NSArray *)carInfos
{
    //移除
    for (UIView *v in _rootScrollView.subviews) {
        [v removeFromSuperview];
    }
    
//    //创建
//    NSInteger index = carInfos.count;
//    //判断当前用户绑定车辆个数，根据个数来设置样式
//    if (index == 0) {
//        self.viewNameArray = [NSArray arrayWithObjects:@1, nil];
//    } else if (index == 1) {
//        self.viewNameArray = [NSArray arrayWithObjects:@0, @1, nil];
//    } else{// if (index == 2)
//        self.viewNameArray = [NSArray arrayWithObjects:@0, @0, nil];
//    }
    NSMutableArray *titleArr = [[NSMutableArray alloc] initWithObjects:TITLE_ADD_CAR, TITLE_ADD_CAR, nil];
//    for (CarInfo *carInfo in carInfos) {
//        [titleArr addObject:carInfo.hphm];
//    }
//    
//    [_segButtonView setTitles:titleArr];
    
    for (int i = 0; i < [carInfos count]; i++) {
        CarInfo *carInfo = [carInfos objectAtIndex:i];
        [titleArr replaceObjectAtIndex:i withObject:[carInfo.hphm uppercaseString]];
    }
    [_segButtonView setTitles:titleArr withTitleColor:nil];
    NSInteger index = _rootScrollView.contentOffset.x/_rootScrollView.width;
    [_segButtonView setSelectedIndex:index];
    
    for (int i = 0; i < [titleArr count]; i++) {
        NSString *title = [titleArr objectAtIndex:i];
        if ([title isEqualToString:TITLE_ADD_CAR]) {
            
            UIView *carBlankView = [[UIView alloc] initWithFrame:CGRectMake(10 + i*_rootScrollView.width, 0, _rootScrollView.width - 20, _rootScrollView.height)];
            [carBlankView setBackgroundColor:[UIColor whiteColor]];
            carBlankView.userInteractionEnabled = YES;
            [_rootScrollView addSubview:carBlankView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [carBlankView addGestureRecognizer:tap];
            
            UIImageView *carBindImgView = [[UIImageView alloc] initWithFrame:CGRectMake(80, _rootScrollView.height/2-50, 120, 30)];
            carBindImgView.image = [UIImage imageNamed:@"jdcbd.png"];
            [carBlankView addSubview:carBindImgView];
            
            UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(carBindImgView.left-50, carBindImgView.bottom, 243, 80)];
            titleLabel1.text = @"成功绑定车辆后，可获得车辆违法信息、车辆年审提醒、保险到期提醒等提示。";
            titleLabel1.font = [UIFont systemFontOfSize:18];
            titleLabel1.textColor = [UIHelper getColor:@"#a0a0a0"];
            titleLabel1.textAlignment = NSTextAlignmentLeft;
            titleLabel1.numberOfLines = 0;
            [carBlankView addSubview:titleLabel1];
            
        } else {
            //高度最少160
            CarView *carView = [[CarView alloc] initWithFrame:CGRectMake(10 + _rootScrollView.width*i, 0, 300, _rootScrollView.height)];
            [carView setViewWithCar:carInfos[i]];
            carView._delegate = self;
            [_rootScrollView addSubview:carView];
            
            //[_carViews addObject:carView];
        }

    }
}

#pragma mark - CarView DELEGATE

- (void)carView:(CarView *)carView respondAction:(Action)action{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:car:didRespondAction:)]) {
        [self.scroll_delegate carInfoScrollView:self car:carView.car didRespondAction:action];
    }
}

- (void)carView:(CarView *)carView tapCar:(CarInfo *)car{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollView:didTapCar:)]) {
        [self.scroll_delegate carInfoScrollView:self didTapCar:car];
    }
}

- (void)carViewDidTapBlank{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollViewDidTapBlank)]) {
        [self.scroll_delegate carInfoScrollViewDidTapBlank];
    }
}


#pragma mark - tap to add car
- (void)tap:(UITapGestureRecognizer *)tap{
    if ([self.scroll_delegate respondsToSelector:@selector(carInfoScrollViewDidTapForAdd)]) {
        [self.scroll_delegate carInfoScrollViewDidTapForAdd];
    }
}

#pragma mark - segmentButtonView delegate
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    [_rootScrollView scrollRectToVisible:CGRectMake(index*_rootScrollView.width, _rootScrollView.origin.y, _rootScrollView.width, _rootScrollView.height) animated:NO];
}



#pragma mark- scrollview DELEGATE

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/_rootScrollView.width;
    [_segButtonView setSelectedIndex:index];
}


@end
