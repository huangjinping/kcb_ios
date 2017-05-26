//
//  MovieInfo.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-8.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContent.h"
#import "ChatUser.h"

@interface MovieInfo : NSObject

//添加时间
@property (nonatomic, retain)   NSString            *addtime;
//视频内容
@property (nonatomic, retain)   MovieContent        *movieContent;
//视频种类 默认 10
@property (nonatomic, retain)   NSString            *bsort;
//视频类型(1:原创 0:转载)
@property (nonatomic, retain)   NSString            *btype;
//博文ID
@property (nonatomic, retain)   NSString            *id_;
//点赞用户名列表
@property (nonatomic, retain)   NSString            *praiseusername;
//博文转载说明
@property (nonatomic, retain)   NSString            *title;
//用户信息JSON对象
@property (nonatomic, retain)   ChatUser            *user;
//?????
@property (nonatomic, retain)   NSString            *isreport;


@end
