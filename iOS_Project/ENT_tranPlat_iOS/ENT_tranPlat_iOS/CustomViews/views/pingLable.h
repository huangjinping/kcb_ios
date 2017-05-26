//
//  pingLable.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-9.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pingLable;

@protocol pingLableDelegate <NSObject>

- (void)pingLableClicked:(pingLable *)myLable;

@end




@interface pingLable : UILabel



//回复博文ID
@property (nonatomic, copy) NSString *blogID;
//被回复人ID
@property (nonatomic, copy) NSString *Peplyuid;
//评论id
@property (nonatomic, copy) NSString *pingID;

@property (nonatomic, assign) id <pingLableDelegate>delegate;

@end
