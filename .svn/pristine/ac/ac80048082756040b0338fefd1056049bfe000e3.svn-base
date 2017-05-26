//
//  ChatBlogsCell.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-9-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatBlogsCell.h"
#import "UIHelper.h"
#import "CopyLineLable.h"
#define BtnX (self.frame.size.width-40)/3


@implementation ChatBlogsCell

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
    self.contentView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;//[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:0.8];
//    UIColor *myColor = [UIHelper getColor:@"06538d"];
    UIColor *myColor = [UIColor colorWithRed:13/255.0 green:75/255.0 blue:135/255.0 alpha:1];
    _cellBgImageView = [[UIImageView alloc]init];
    _cellBgImageView.image = [UIImage imageNamed:@"bg_white.png"];
    _cellBgImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_cellBgImageView];
    _photo= [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _photo.clipsToBounds = YES;
    _photo.layer.cornerRadius = 5;
    _photo.tag = 900;
    [_cellBgImageView addSubview:_photo];
    _userNameLable= [[UILabel alloc]init];
    _userNameLable.textColor = myColor;
    _userNameLable.font = [UIFont boldSystemFontOfSize:14];
    _attention = [UIButton buttonWithType:UIButtonTypeCustom];
    _attention.frame = CGRectMake(APP_WIDTH-20-60, 35, 50, 20);
    _attention.titleLabel.textAlignment = NSTextAlignmentCenter;
    _attention.titleLabel.font = [UIFont systemFontOfSize:12];
    [_attention setTitle:@"关注" forState:UIControlStateNormal];
    [_attention setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateNormal];
    [_attention setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateSelected];
    [_attention setTitle:@"已关注" forState:UIControlStateSelected];
    [_cellBgImageView addSubview:_attention];

    
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"laji.jpg"] forState:UIControlStateNormal];
    _deleteBtn.frame = CGRectMake(APP_WIDTH-20-60, 15, 20, 20);
//    _deleteBtn.backgroundColor = [UIColor redColor];
//    self.deleteBtn.frame = CGRectMake(260, 15, 30, 30);
    [_cellBgImageView addSubview:_deleteBtn];
    [_cellBgImageView addSubview:_userNameLable];
    _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoBtn.frame = CGRectMake(10, 10, 120, 40);
    [_cellBgImageView addSubview:_photoBtn];
    
    _cityLable = [[UILabel alloc]init];
    _cityLable.textColor = [UIColor orangeColor];
    _cityLable.textAlignment = NSTextAlignmentLeft;
    _cityLable.font = [UIFont systemFontOfSize:9];
    //后期添加定位，上传位置信息在model字段中带出，故暂时取消单独的城市显示框
    _cityLable.hidden = YES;
    [_cellBgImageView addSubview:_cityLable];

    _addTimeLable= [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 95, 20)];
    _addTimeLable.font = [UIFont systemFontOfSize:9];
    _addTimeLable.alpha = 0.8;
    [_cellBgImageView addSubview:_addTimeLable];
    
    //    自适应高度需要
    _blogsContentsLable= [[CopyLineLable alloc]init];
    _blogsContentsLable.textAlignment = NSTextAlignmentLeft;
    _blogsContentsLable.numberOfLines = 0;
    [_cellBgImageView addSubview:_blogsContentsLable];
 
    _blogsImage1 = [[ChatImageView alloc]init];
    _blogsImage1.userInteractionEnabled = YES;
    _blogsImage1.delegate = self;
    [_cellBgImageView addSubview:_blogsImage1];
    
    _blogsImage2 = [[ChatImageView alloc]init];
    _blogsImage2.userInteractionEnabled = YES;
    _blogsImage2.delegate = self;
    [_cellBgImageView addSubview:_blogsImage2];
    
    _blogsImage3 = [[ChatImageView alloc]init];
    _blogsImage3.userInteractionEnabled = YES;
    _blogsImage3.delegate = self;
    [_cellBgImageView addSubview:_blogsImage3];
    
    _modelLable= [[UILabel alloc]init];
    _modelLable.textColor = [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1];
    _modelLable.font = [UIFont systemFontOfSize:12];
    [_cellBgImageView addSubview:_modelLable];
    
    _xianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_xianBtn setTitle:@"显示全文" forState:UIControlStateNormal];
    [_xianBtn setTitle:@"收起" forState:UIControlStateSelected];
    
    [_xianBtn setTitleColor:myColor forState:UIControlStateSelected];
    [_xianBtn setTitleColor:myColor forState:UIControlStateNormal];
    _xianBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _xianBtn.hidden = YES;
    [_cellBgImageView addSubview:_xianBtn];
    _lineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line02.png"]];
    _lineView.userInteractionEnabled = YES;
    [_cellBgImageView addSubview:_lineView];
    
    _lineZanView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line02.png"]];
    _lineZanView.userInteractionEnabled = YES;
    [_cellBgImageView addSubview:_lineZanView];

    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:0.5];
    [_cellBgImageView addSubview:_bgView];
    
    _reportB = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reportB setTitle:@"举报" forState:UIControlStateNormal];
    [_reportB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateNormal];
    [_reportB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateSelected];
    [_reportB setTitle:@"举报" forState:UIControlStateSelected];
    
    _reportB.titleLabel.textAlignment = NSTextAlignmentCenter;
    _reportB.titleLabel.font = [UIFont systemFontOfSize:12];
    _reportImgView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 6, 18, 18)];
    [_reportB addSubview:_reportImgView];
    [_bgView addSubview:_reportB];
    
    _zanB = [UIButton buttonWithType:UIButtonTypeCustom];
    _zanB.titleLabel.textAlignment = NSTextAlignmentCenter;
    _zanB.titleLabel.font = [UIFont systemFontOfSize:12];
//    [_zanB setTitle:@"赞" forState:UIControlStateNormal];
    [_zanB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateNormal];
    [_zanB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateSelected];
//    [_zanB setTitle:@"已赞" forState:UIControlStateSelected];
    _zanB.selected = NO;
    _zanImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.5, 8, 14, 14)];
    [_zanB addSubview:self.zanImgView];
    [_bgView addSubview:self.zanB];
    
    _pinglunB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_pinglunB setTitle:@"评论" forState:UIControlStateNormal];
    [_pinglunB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateNormal];
    [_pinglunB setTitleColor: [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1]forState:UIControlStateSelected];
//    [_pinglunB setTitle:@"评论" forState:UIControlStateSelected];

    _pinglunB.titleLabel.textAlignment = NSTextAlignmentCenter;
    _pinglunB.titleLabel.font = [UIFont systemFontOfSize:12];
    _pingImgView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 6, 18, 18)];
    [_pinglunB addSubview:_pingImgView];
    [_bgView addSubview:_pinglunB];
    _zanCountLable= [[UILabel alloc]init];
    _zanCountLable.numberOfLines = 0;
    _zanCountLable.textColor = [UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1];
    _zanCountLable.font = [UIFont systemFontOfSize:12];
    [_cellBgImageView addSubview:_zanCountLable];
    _modleImage = [[UIImageView alloc]init];
    [_modleImage setImage:[UIImage imageNamed:@"chat_logo_phone.png"]];
    [_cellBgImageView addSubview:_modleImage];
    _zanCountImage = [[UIImageView alloc]init];
    [_zanCountImage setImage:[UIImage imageNamed:@"chat_zan_selected.png"]];
    [_cellBgImageView addSubview:_zanCountImage];
}


- (void)chatImageClicked:(ChatImageView *)communityImageView{
    if ([self.delegate_ respondsToSelector:@selector(chatBlogCell:clickedChatImage:)]) {
        [self.delegate_ chatBlogCell:self clickedChatImage:communityImageView];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
