//
//  StarView.h
//  RongChuang
//
//  Created by cooperLink on 15/4/10.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import <UIKit/UIKit.h>

//星级尺寸,默认就是small
typedef NS_ENUM(NSInteger, StarLevel) {
    STARSMALL,
    STARMIDDLE,
    STARMIDDLE_,
    STARBIG
};
@interface StarView : UIView

@property (nonatomic, copy) void (^SelectStarFinished)(NSInteger starNumber);
@property (nonatomic, assign) StarLevel starLevelSize;

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName starSpace:(CGFloat)space;


// 根据好评的比例设置好评 星的长度
-(void)setHighPraiseWith:(CGFloat)highPraiseRatio;
// 根据好评星数设置好评 星长度
-(void)setHighPraise:(NSInteger)starNumber;

@end
