//
//  RescueCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/3/2.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "RescueCell.h"

@implementation RescueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _telicon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*x_6_plus, 60*x_6_plus)];
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 830*x_6_plus, 50*y_6_plus)];
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30*x_6_plus, 30*x_6_plus)];
        _telLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 830*x_6_plus, 50*y_6_plus)];
        _telLabel.font=V3_42PX_FONT;
        _contentLabel.font = V3_42PX_FONT;
        _contentLabel.textColor = [UIColor colorWithHex:0x666666];
        _telLabel.textColor = [UIColor colorWithHex:0x666666];
        [self.contentView addSubview:_telicon];
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_telLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _telicon.origin = CGPointMake(40*x_6_plus, 0);
    _telicon.centerY = self.contentView.boundsCenter.y;
    _contentLabel.origin = CGPointMake(_telicon.right+40*x_6_plus, 0);
    _contentLabel.centerY = self.contentView.boundsCenter.y;
    _icon.origin = CGPointMake(800*x_6_plus, 0);
    _icon.centerY = self.contentView.boundsCenter.y;
    _telLabel.origin = CGPointMake(_icon.right+20*x_6_plus, 0);
    _telLabel.centerY = self.contentView.boundsCenter.y;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
