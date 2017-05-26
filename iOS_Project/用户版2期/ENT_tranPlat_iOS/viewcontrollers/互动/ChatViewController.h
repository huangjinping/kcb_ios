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
#import "UIImageView+WebCache.h"
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


@interface ChatViewController : BasicViewController

@property (nonatomic, assign) int bsort;
@property (nonatomic, strong)UIView *line;

@end
