//
//  SelectCarHphmPreView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/22.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCarHphmPreView;
@protocol SelectCarHphmPreViewDelegate <NSObject>

@optional
- (void)selectCarHphmPreView:(SelectCarHphmPreView*)v tapJiancheng:(NSString*)jiancheng;

@end

@interface SelectCarHphmPreView : UIView

@property (nonatomic, assign)   id<SelectCarHphmPreViewDelegate> delegate_;

- (id)initWithFrame:(CGRect)frame
            jiancheng:(NSString*)jiancheng
            quancheng:(NSString*)quancheng;
@end
