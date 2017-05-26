//
//  ChatDetailViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatImageView.h"
#import "ChatBlogsCell.h"
#import "YFInputBar.h"
#import "pingLable.h"
#import "CYHDSendTopicViewController.h"
#import "CopyLineLable.h"

#import "LinkMessage.h"

#import "CommonWebViewController.h"


@class YFInputBar;
@class pingLable;

@interface ChatDetailViewController : BasicViewController<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
UITextFieldDelegate,
YFInputBarDelegate,
pingLableDelegate,
MWPhotoBrowserDelegate,
ChatBlogCellDelegate,
UIAlertViewDelegate,
YFCopyableLableDelegate,
YFLineLableDelegate,
UIWebViewDelegate
>

{
    
    UITableView                     *_blogTableView;
    
    

    YFInputBar              *_pingTextView;
    //  cell的总高度
    CGFloat                   _cellHeight;
    //  cell高度数组
    NSMutableArray          *_cellHeightArray;
    //  cell的跟踪高度
    //  CGFloat                 _cellTestHeight;
    //  评论的laBle高度
    CGFloat                 _pingLableHeight;
    //  赞的Lable高度
    CGFloat                 _zanLableHeight;
    //  评论按钮
    UIButton                *_pingBtn;
    
    pingLable               *_pLable;
    //  某个博文所有评论回复数组
    NSMutableArray          *_myCommentArray;
    
    BOOL                     _backFromAddBlog;
    BOOL                     _isloadingBlogs;
    
    UIAlertView             *_deleteAlertView;
    UIAlertView             *_deletePingAlertView;
    
    UIButton                *_zanBtn;
    //  上一次comments的数组
    NSMutableArray          *_beforeCommentsArray;
    //  当前comments的数组
    NSMutableArray          *_currentCommentsArray;
    
    

    
}

//我的好友数组
@property (nonatomic, retain)   NSMutableArray  *myFriends;

@property (nonatomic, retain)   NSString    *friendName;

@property (nonatomic, retain)   NSString    *bsort;

@property (nonatomic, copy)     NSString    *titleName;

//查看列表图片详情
@property (nonatomic, retain)   NSArray     *photos;
//当前cell的博文id
@property (nonatomic, retain)   NSString    *currentBlogId_;



@property (nonatomic, retain) NSArray          *blogs;
@property (nonatomic, retain) NSMutableArray          *comments;
@end

