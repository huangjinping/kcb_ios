//
//  MovieTableViewCell.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface MovieTableViewCell : UITableViewCell<UITextViewDelegate>


//视频标题
@property (nonatomic, retain) UILabel       *movieTitleLable;
//视频描述
@property (nonatomic, retain) UITextView       *movieDTextView;
//视频界面
@property (nonatomic, retain) MPMoviePlayerController   *MPpc;
//视频浏览量
@property (nonatomic, retain) UILabel       *movieCountLable;
//视频图片
@property (nonatomic, retain) UIImageView   *movieImageView;
//背景
@property (nonatomic, retain) UIImageView   *movieBackImageView;

@end
