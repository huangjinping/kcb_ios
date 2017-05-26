//
//  SegmentView.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SegmentButtonView;
@protocol SegmentButtonViewDelegate <NSObject>

- (void)segmentButtonView:(SegmentButtonView*)segmentButtonView showView:(NSInteger)index;

@end

@interface SegmentButtonView : UIImageView
{

     UIImageView *_lineView;

    UIColor             *_titleNorColor;

    UIColor             *_lineColor;

}

@property(nonatomic,assign)id<SegmentButtonViewDelegate> delegate;

@property(nonatomic,assign)NSInteger selectedIndex;

@property(nonatomic,assign)UIColor *titleSelColor;

@property(nonatomic,retain)NSArray *titles;

- (void)setTitles:(NSArray *)titles withTitleNorColor:(UIColor*)norColor andTitleSelColor:(UIColor*)selColor;

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor andLineColor:(UIColor*)lineColor;

@end
