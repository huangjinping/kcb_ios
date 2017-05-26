//
//  FilterView.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FilterType) {
    FilterOnDistance = 0,
    FilterOnService,
    FilterOnPopularity
};

@class FilterView;
@protocol FilterViewDelegate <NSObject>

- (void)didSelectedFilterView:(FilterView *)filterView index:(NSInteger)path;

@end
@interface FilterView : UIView

@property (nonatomic, weak)id<FilterViewDelegate> delegate;
@property (nonatomic, assign)FilterType filterType;

+(FilterView *)shareFilterView;
- (void)showWithView:(UIView *)view;

@end
