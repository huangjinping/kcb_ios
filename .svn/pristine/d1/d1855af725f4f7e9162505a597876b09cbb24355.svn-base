//
//  MoviePlayerViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "MoviePlayerViewController.h" 
#import "KxMovieViewController.h"

@interface MovieListViewController : BasicViewController<UITableViewDelegate,
UITableViewDataSource,
EGORefreshTableFooterDelegate,
EGORefreshTableHeaderDelegate
>

{
    NSMutableArray                          *_movieLists;
    UITableView                             *_movieTable;
    EGORefreshTableHeaderView               *_refreshHeader;
    EGORefreshTableFooterView               *_loadMoreFooter;
    BOOL                                    _isloadingBlogs;
}

////视频地址
//@property (nonatomic, copy)  NSString       *movieURL;
////视频图片
//@property (nonatomic, copy)  NSString       *movieImage;
////视频标题
//@property (nonatomic, copy)  NSString       *movieTitle;
@end
