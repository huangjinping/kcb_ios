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
}

@property(nonatomic,assign)id<SegmentButtonViewDelegate> delegate;

@property(nonatomic,assign)NSInteger selectedIndex;

@property(nonatomic,retain)NSArray *titles;

- (void)setTitles:(NSArray *)titles withTitleColor:(UIColor*)color;

//- (void)setNum:(NSInteger)num;

@end
