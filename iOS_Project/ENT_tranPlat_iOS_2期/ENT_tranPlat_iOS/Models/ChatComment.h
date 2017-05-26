//
//  ChatComment.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatComment : NSObject
/*
 
 comments	contents	String(jsonArray)	评论/回复列表
 
 addtime	comments	string              评论/回复时间
 bid        comments	int                 被评论博文ID
 content	comments	string              回复/评论内容
 id         comments	int                 评论/回复ID
 peplyuser	comments	String(JSON)        被回复人用户对象
 id         peplyuser	int                 ID
 username	peplyuser	string              用户名
 ……
 commentuser	comments	String(JSON)	发表评论/回复用户对象
 id         commentuser	int                 ID
 username	commentuser	string              用户名
 */

@property (nonatomic, retain)   NSString            *addtime;
@property (nonatomic, retain)   NSString            *bid;
@property (nonatomic, retain)   NSString            *content;
@property (nonatomic, retain)   NSString            *id_;
@property (nonatomic, retain)   NSString            *peplyuser;
@property (nonatomic, retain)   NSString            *peplyuser_id;
@property (nonatomic, retain)   NSString            *peplyuser_username;
@property (nonatomic, retain)   NSString            *commentuser_id;
@property (nonatomic, retain)   NSString            *commentuser_username;


@end
