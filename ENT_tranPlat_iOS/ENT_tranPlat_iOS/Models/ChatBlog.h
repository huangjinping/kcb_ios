//
//  ChatBlog.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-11.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatUser.h"
#import "ChatBlogContent.h"
#import "LinkMessage.h"

@interface ChatBlog : NSObject


/*
 blogs	contents	String(jsonArray字符串)	博文列表
 
 addtime	blogs	string	博文发布时间
 btype	blogs	int	博文类型（0：原创，1：转载）
 id	blogs	int	博文ID
 praiseusername	blogs	string	点赞用户名列表（以英文“,”号分割）
 title	blogs	string	博文转载说明
 
 user	blogs	string(JSON)	用户信息JSON对象
 id	user	int	用户ID
 photo	user	string	用户头像
 username	user	string	用户名称
 utype	user	int	用户类型
 regtime	user	string	注册时间
 
 
 blogcontent	blogs	string(JSON)	博文内容JSON对象
 id	blogcontent	int	博文内容ID
 content	blogcontent	string	博文内容
 imgurl	blogcontent	string	博文图像URL
 videourl	blogcontent	string	博文视频URL
 checkcount	blogcontent	int	博文查看数量
 reservedcount	blogcontent	int	博文转载数量
 

*/

@property (nonatomic, retain)   NSString            *addtime;
@property (nonatomic, retain)   ChatBlogContent     *blogcontent;
@property (nonatomic, retain)   NSString            *bsort;
@property (nonatomic, retain)   NSString            *btype;
@property (nonatomic, retain)   NSString            *id_;
@property (nonatomic, retain)   NSString            *praiseusername;
@property (nonatomic, retain)   NSString            *title;
@property (nonatomic, retain)   ChatUser            *user;
@property (nonatomic, assign)   float               lableHeight;




@end
