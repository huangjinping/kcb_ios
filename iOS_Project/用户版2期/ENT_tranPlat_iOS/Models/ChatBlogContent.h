//
//  ChatBlogContent.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatBlogContent : NSObject

/*
 
 blogcontent        blogs           string(JSON)	博文内容JSON对象
 
 id                 blogcontent     int             博文内容ID
 content            blogcontent     string          博文内容
 currentShowContent blogcontent     string          当前显示的博文内容
 imgurl             blogcontent     string          博文图像URL
 videourl           blogcontent     string          博文视频URL
 checkcount         blogcontent     int             博文查看数量
 reservedcount      blogcontent     int             博文转载数量
 
 */

@property (nonatomic, retain)   NSString            *id_;
@property (nonatomic, retain)   NSString            *content;
@property (nonatomic, retain)   NSString            *imgurl;
@property (nonatomic, retain)   NSString            *videourl;
@property (nonatomic, retain)   NSString            *checkcount;
@property (nonatomic, retain)   NSString            *reservedcount;
@property (nonatomic, retain)   NSString            *model;
@property (nonatomic, retain)   NSString            *currentShowContent;
@property (nonatomic, retain)   NSMutableArray            *linkMessArr;

@end
