//
//  EdittingCell.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/15.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "EdittingCell.h"

@implementation EdittingCell
{
    UIImageView *_icon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(27*x_6_plus, 0, 800*x_6_plus, 117*y_6_plus)];
        _nameLabel.font = V3_38PX_FONT;
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _subNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH-40*x_6_plus-300*x_6_plus, 0, 350*x_6_plus, 117*y_6_plus)];
        _subNameLabel.textAlignment = NSTextAlignmentRight;
        _subNameLabel.font = V3_38PX_FONT;
        _subNameLabel.textColor = [UIColor colorWithHex:0x666666];
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24*x_6_plus, 38*y_6_plus)];
        _icon.image = [UIImage imageNamed:@"list_righticon"];
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_subNameLabel];
        [self.contentView addSubview:_icon];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _nameLabel.origin = CGPointMake(27*x_6_plus, 0);
    _nameLabel.centerY = self.contentView.boundsCenter.y;
    _icon.origin = CGPointMake(APP_WIDTH-40*x_6_plus-45*x_6_plus, 0);
    _icon.centerY = self.contentView.boundsCenter.y;
    _subNameLabel.origin = CGPointMake(_icon.x-30*x_6_plus-_subNameLabel.width, 0);
    _subNameLabel.centerY = self.contentView.boundsCenter.y;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRes:(BOOL)res{
    if (res) {
        _icon.hidden = YES;
    }else{
        _icon.hidden = NO;
    }
}

@end
