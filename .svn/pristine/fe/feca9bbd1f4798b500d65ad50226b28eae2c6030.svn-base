//
//  CycleScrollView.h
//  UIScrollViewCyclePage
//
//  Created by 叶落风逝 on 14-8-31.
//  Copyright (c) 2014年 pinksun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleScrollPictureModel.h"

@class CycleScrollView;

typedef void (^DidScrollBlock)(NSInteger index);

typedef NS_ENUM(NSInteger, CycleScrollDirection) {
    CycleScrollDirectionVertical,//垂直滚动
    CycleScrollDirectionHorizontal//水平滚动
};

typedef NS_ENUM(NSInteger, ScrollDir) {
    ScrollDirAdd = 1,
    ScrollDirReduce = -1
};


//协议
@protocol CycleScrollViewDelegate <NSObject>

@optional
-(void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index;

@end

@interface CycleScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic,assign) id<CycleScrollViewDelegate> delegate;
@property (nonatomic,copy  ) DidScrollBlock scrollBlock;
@property (nonatomic,retain) NSArray        *imageArray;

-(id)initWithFrame:(CGRect)frame
    cycleDirection:(CycleScrollDirection)direction
          pictures:(NSArray *)pictures
    didScrollBlock:(DidScrollBlock)scrollBlock;

- (void)setTimerInvalidate;
@end
