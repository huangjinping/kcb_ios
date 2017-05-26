//
//  MovieDetailTableViewCell.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CopyLineLable;

@interface MovieDetailTableViewCell : UITableViewCell



//头像
@property (nonatomic, retain) UIImageView   *photo;
//视频评论用户名
@property (nonatomic, retain) UILabel       *userNameLable;
//发布评论时间
@property (nonatomic, retain) UILabel       *addTimeLable;
//评论内容
@property (nonatomic, retain) CopyLineLable *moviePingLable;


@end
