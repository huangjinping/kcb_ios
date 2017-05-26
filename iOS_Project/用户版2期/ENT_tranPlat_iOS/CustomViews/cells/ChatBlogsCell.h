//
//  ChatBlogsCell.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-9-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatImageView;
@class ChatBlogsCell;
@class CopyLineLable;

@protocol ChatBlogCellDelegate <NSObject>

- (void)chatBlogCell:(ChatBlogsCell*)cell clickedChatImage:(ChatImageView*)imgView;

@end


@interface ChatBlogsCell : UITableViewCell<
ChatImageDelegate
>

@property (nonatomic, assign) id<ChatBlogCellDelegate>  delegate_;

//头像覆盖Btn
@property (nonatomic, retain) UIButton      *photoBtn;
//头像
@property (nonatomic, retain) UIImageView   *photo;
//用户名
@property (nonatomic, retain) UILabel       *userNameLable;
//关注按钮
@property (nonatomic, retain) UIButton      *attention;
//发布博文时间
@property (nonatomic, retain) UILabel       *addTimeLable;
//博文内容
@property (nonatomic, retain) CopyLineLable *blogsContentsLable;
//博文图片
@property (nonatomic, retain) ChatImageView *blogsImage1;
@property (nonatomic, retain) ChatImageView *blogsImage2;
@property (nonatomic, retain) ChatImageView *blogsImage3;
//设备型号
@property (nonatomic, retain) UILabel       *modelLable;
//举报
@property (nonatomic, retain) UIButton      *reportB;
//点赞
@property (nonatomic, retain) UIButton      *zanB;
//评论
@property (nonatomic, retain) UIButton      *pinglunB;

//赞的图片
@property (nonatomic, retain) UIImageView   *zanImgView;
//评论按钮图片
@property (nonatomic, retain) UIImageView   *pingImgView;
//举报按钮图片
@property (nonatomic, retain) UIImageView   *reportImgView;
//赞的次数
@property (nonatomic, retain) UILabel       *zanCountLable;
//手机型号图片
@property (nonatomic, retain) UIImageView   *modleImage;
//赞数量的图片
@property (nonatomic, retain) UIImageView   *zanCountImage;
//博文查看数量图片
@property (nonatomic, retain) UIImageView   *blogsChaImage;
//按钮下的view
@property (nonatomic, retain) UIView        *bgView;
//cell背景图片
@property (nonatomic, retain) UIImageView   *cellBgImageView;
//line
@property (nonatomic, retain) UIImageView   *lineView;
//lineZan
@property (nonatomic, retain) UIImageView   *lineZanView;
//删除按钮
@property (nonatomic, retain) UIButton      *deleteBtn;
//用户城市
@property (nonatomic, retain) UILabel       *cityLable;
//查看全文
@property (nonatomic, retain) UIButton      *xianBtn;
//收起
@property (nonatomic, retain) UIButton      *yinBtn;


@end
