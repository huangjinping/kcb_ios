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
    float bi = APP_WIDTH/320;
    _movieBackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, APP_WIDTH-20, 145)];
    _movieBackImageView.userInteractionEnabled = YES;
    _movieBackImageView.image = [UIImage imageNamed:@"bg_white.png"];
    [self.contentView addSubview:_movieBackImageView];
    
    
    
    _movieImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, APP_WIDTH- 40, 115)];
    [_movieBackImageView addSubview:_movieImageView];
    
    _movieTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10,123, 220, 20)];
    _movieTitleLable.font = [UIFont systemFontOfSize:15];
    _movieTitleLable.textAlignment = NSTextAlignmentLeft;
    _movieTitleLable.textColor = [UIColor grayColor];
    [_movieBackImageView addSubview:_movieTitleLable];
    
    
    UIImageView *countImage = [[UIImageView alloc]initWithFrame:CGRectMake(245*bi, 126, 16, 16)];
    countImage.image = [UIImage imageNamed:@"movie_click_num_logo.png"];
    [_movieBackImageView addSubview:countImage];

    _movieCountLable = [[UILabel alloc]initWithFrame:CGRectMake(260*bi,123, 28, 20)];
    _movieCountLable.font = [UIFont systemFontOfSize:15];
    _movieCountLable.textAlignment = NSTextAlignmentRight;
    _movieCountLable.textColor = [UIColor grayColor];
//    _movieCountLable.text = @"2000";
    [_movieBackImageView addSubview:_movieCountLable];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
