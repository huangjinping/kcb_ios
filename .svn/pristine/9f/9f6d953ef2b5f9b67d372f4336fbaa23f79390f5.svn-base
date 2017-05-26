//
//  MovieDetailTableViewCell.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MovieDetailTableViewCell.h"
#import "CopyLineLable.h"

@implementation MovieDetailTableViewCell

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
    
    _photo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    _photo.layer.masksToBounds = YES;
    _photo.layer.cornerRadius = 3;
    [self.contentView addSubview:_photo];
    
    _userNameLable = [[UILabel alloc]init];
    _userNameLable.text = @"用户名";
    _userNameLable.backgroundColor = [UIColor clearColor];
    _userNameLable.textColor = [UIColor grayColor];
    _userNameLable.font = [UIFont systemFontOfSize:14];
    _userNameLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_userNameLable];
    _addTimeLable = [[UILabel alloc]init];
    _addTimeLable.text = @"评论时间";
    _addTimeLable.backgroundColor = [UIColor clearColor];
    _addTimeLable.textColor = [UIColor grayColor];
    _addTimeLable.font = [UIFont systemFontOfSize:14];
    _addTimeLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_addTimeLable];

    _moviePingLable = [[CopyLineLable alloc]init];
    _moviePingLable.textColor = COLOR_FONT_NOMAL;
    _moviePingLable.backgroundColor = [UIColor clearColor];
    _moviePingLable.font = [UIFont systemFontOfSize:14];
    _moviePingLable.textAlignment = NSTextAlignmentLeft;
    _moviePingLable.numberOfLines = 0;
    [self.contentView addSubview:_moviePingLable];

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
