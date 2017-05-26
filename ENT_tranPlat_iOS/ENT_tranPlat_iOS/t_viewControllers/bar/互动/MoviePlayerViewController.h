//
//  MainViewController.h
//  kxmovie
//
//  Created by Kolyvan on 18.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import <UIKit/UIKit.h>
#import "YFInputBar.h"
#import "SegmentButtonView.h"



@interface MoviePlayerViewController : BasicViewController<UITableViewDelegate,
UITableViewDataSource,
YFInputBarDelegate,
SegmentButtonViewDelegate,
UIScrollViewDelegate,
EGORefreshTableFooterDelegate,
EGORefreshTableHeaderDelegate
>


//视频地址
@property (nonatomic, copy)     NSString            *movieURL;
//视频点击量
@property (nonatomic, copy)     NSString            *movieTap;
//视频id
@property (nonatomic, copy)     NSString            *movieID;
//博文ID
@property (nonatomic, copy)     NSString            *blogID;
//评论数组
@property (nonatomic, retain)   NSMutableArray      *commentsArray;
//视频标题
@property (nonatomic, copy)     NSString            *movieTitle;
//视频描述
@property (nonatomic, copy)     NSString            *movieContent;

@end
