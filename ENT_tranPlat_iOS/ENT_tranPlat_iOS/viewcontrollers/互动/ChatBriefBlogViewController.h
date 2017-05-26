//
//  ChatBriefBlogViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-3.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "ChatImageView.h"
#import "YFInputBar.h"
#import "pingLable.h"
#import "ChatBlogsCell.h"
#import "CYHDSendTopicViewController.h"
#import "CopyLineLable.h"

#import "LinkMessage.h"

#import "CommonWebViewController.h"
#import "ChatDetailViewController.h"

@class YFInputBar;
@class pingLable;
@interface ChatBriefBlogViewController : BasicViewController<
EGORefreshTableFooterDelegate,
EGORefreshTableHeaderDelegate,
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
    
    EGORefreshTableHeaderView       *_refreshHeader;
    EGORefreshTableFooterView       *_loadMoreFooter;
    UITableView                     *_blogTableView;
    
    
    NSMutableArray          *_blogs;
    NSMutableArray          *_comments;
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

@property (nonatomic, retain)   NSString    *blosort;

@property (nonatomic, copy)     NSString    *titleName;

//@property (nonatomic, strong)    NSArray     *matches;

//查看列表图片详情
@property (nonatomic, retain)   NSArray     *photos;
//当前cell的博文id
@property (nonatomic, retain)   NSString    *currentBlogId_;

@property (nonatomic, assign)   BOOL        backFromAddBlog;


@end
