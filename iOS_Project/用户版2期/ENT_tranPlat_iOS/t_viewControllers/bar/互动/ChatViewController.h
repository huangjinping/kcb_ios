//
//  CYQViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ChatNetwork.h"
#import "ChatBlog.h"
#import "ChatUser.h"
#import "ChatComment.h"
#import "ChatImageView.h"
#import "MenuView.h"
#import <UIImageView+WebCache.h>
#import "D_CellCellTableView.h"
#import "SegmentButtonView.h"

#import "ChatAddFriendViewController.h"
#import "ChatBlogsViewController.h"

#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"

#import "MovieListViewController.h"
#import "ChatBriefBlogViewController.h"

#define CELL_HEIGHT_CHAT        160
#define CELL_ID_CHAT            @"chatCell"

#define TAG_TEXT_VIEW_PINGLUN   1010


#define CLASSIFY_BLOG_IMAGE_HEIGHT  110 //((APP_HEIGHT- SEGMENT_BUTTON_VIEW_HEIGHT - APP_TAB_HEIGHT - 20)/4)

#define TAG_ALERT_REMOVE_FRIEND     100000


@interface ChatViewController : BasicViewController<
UIScrollViewDelegate,
SegmentButtonViewDelegate,
D_CellCellTableViewDelegate,
D_CellCellTableViewDataSource,
UITextViewDelegate,
ChatImageDelegate,
UIAlertViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
MenuViewDelegate
>
{
    SegmentButtonView               *_segButtonView;
    UIScrollView                    *_rootScrollView;
    //UIScrollView                    *_communityScrollView;
//    UITableView                    *_communityView;
   // UITableView                     *_blogTableView;
    D_CellCellTableView                 *_friendsCellTableView;
    MenuView                            *_communityMenuView;
    //EGORefreshTableHeaderView       *_refreshHeader;
    //EGORefreshTableFooterView       *_loadMoreFooter;
    
    ChatBriefBlogViewController         *_chatBriefBlogVC;
    MovieListViewController           *_movieLVC;
    UITextView                      *_pinglunTextView;
    UIImageView                     *_pinglunBgImgView;
    NSMutableArray                  *_titleMenuArray;
    NSMutableArray                  *_bsortMenuArray;
    UIImageView                     *_userPortraitImgView;

   //FaceToolBar             *_bar;
    
    NSMutableArray          *_friends;
    NSMutableArray          *_blogs;
    NSMutableArray          *_comments;
    NSMutableArray          *_communitys;
    NSMutableArray          *_movieLists;
    
    //BOOL                    _backFromAddFriend;
    BOOL                     _backFromAddBlog;
    BOOL                    _netGetClassifyViewSucc;
    //BOOL                    _netGetFriendsSucc;

    NSInteger               _segButtonIndex;
    UIActivityIndicatorView         *_testActivityIndicator;
}

@property (nonatomic, assign) int bsort;


@end
