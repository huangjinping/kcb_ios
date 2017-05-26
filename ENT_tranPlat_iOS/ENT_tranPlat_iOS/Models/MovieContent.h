//
//  MovieContent.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-24.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieContent : NSObject


//视频ID
@property (nonatomic, retain)   NSString            *id_;
//视频标题
@property (nonatomic, retain)   NSString            *videoTitle;

//视频描述
@property (nonatomic, retain)   NSString            *content;
//视频图片地址
@property (nonatomic, retain)   NSString            *imgurl;
//视频地址
@property (nonatomic, retain)   NSString            *videourl;
//视频点击量
@property (nonatomic, retain)   NSString            *checkcount;
//视频转载数量
@property (nonatomic, retain)   NSString            *reservedcount;
//手机型号
@property (nonatomic, retain)   NSString            *model;



@end
