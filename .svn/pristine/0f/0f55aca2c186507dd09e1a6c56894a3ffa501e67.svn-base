//
//  MovieTableViewCell.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        [self creatContent];
    }
    return self;
    
}
- (void)creatContent{
        _movieImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, APP_WIDTH- 20, 120)];
    _movieImageView.image = [UIImage imageNamed:@"movieImage.jpg"];
    
    [self.contentView addSubview:_movieImageView];
    _movieTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, (APP_WIDTH-20)/2, 20)];
    _movieTitleLable.font = [UIFont boldSystemFontOfSize:17];
    _movieTitleLable.textAlignment = NSTextAlignmentLeft;
    _movieTitleLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_movieTitleLable];
    _movieCountLable = [[UILabel alloc]initWithFrame:CGRectMake((APP_WIDTH-20)/2+10, 130, (APP_WIDTH-20)/2, 20)];
    _movieCountLable.font = [UIFont boldSystemFontOfSize:17];
    _movieCountLable.textAlignment = NSTextAlignmentRight;
    _movieCountLable.textColor = [UIColor blackColor];
    _movieCountLable.text = @"2000";
    [self.contentView addSubview:_movieCountLable];

//    _MPpc = [[MPMoviePlayerController alloc] init];
//    _MPpc.controlStyle = MPMovieControlStyleDefault;
//    _MPpc.scalingMode = MPMovieScalingModeAspectFit;
//    _MPpc.shouldAutoplay = NO;
//    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
////    [_MPpc play];
//    [_MPpc prepareToPlay];
//    [_MPpc.view setFrame:CGRectMake(20, 25, 280, 150)];
//    [self.contentView addSubview:_MPpc.view];

//    _movieDTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 175, APP_WIDTH- 20*2, 120)];
//    _movieDTextView.delegate = self;
//    _movieDTextView.showsVerticalScrollIndicator = NO;
//    _movieDTextView.userInteractionEnabled = NO;
//    [self.contentView addSubview:_movieDTextView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
