//
//  MinePersonCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/14.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MinePersonCell.h"

@implementation MinePersonCell
{
    UIImageView *_phoneV;
    UIImageView *_rV;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _icon = [[UIImageView alloc]init];
        _icon.layer.masksToBounds = YES;
        
        _rV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24*x_6_plus, 38*y_6_plus)];
        _rV.image = [UIImage imageNamed:@"list_righticon"];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = V3_46PX_FONT;
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = V3_32PX_FONT;
        _phoneLabel.textColor = [UIColor colorWithHex:0x666666];
        _phoneV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20*x_6_plus, 38*y_6_plus)];
        _phoneV.image = [UIImage imageNamed:@"grzx_tel"];
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 380*x_6_plus, 45*y_6_plus)];
        _addressLabel.text = @"账户/收货地址管理";
        _addressLabel.textAlignment = NSTextAlignmentRight;
        _addressLabel.font = V3_32PX_FONT;
        _addressLabel.textColor = [UIColor colorWithHex:0x666666];
        
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_rV];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_phoneLabel];
        [self.contentView addSubview:_addressLabel];
        [self.contentView addSubview:_phoneV];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _icon.frame = CGRectMake(40*x_6_plus, 0, 155*x_6_plus, 155*x_6_plus);
    _icon.centerY = self.contentView.boundsCenter.y;
    _icon.layer.cornerRadius = _icon.width/2;
    _rV.origin = CGPointMake(APP_WIDTH-_rV.width-48*x_6_plus, 0);
    _rV.centerY = self.contentView.boundsCenter.y;
    [_icon addBorderWithWidth:3*x_6_plus color:kWhiteColor corner:_icon.width/2];
    
    _nameLabel.frame = CGRectMake(_icon.right+40*x_6_plus, _icon.y+32*y_6_plus, 400*x_6_plus, 50*y_6_plus);
    _phoneV.origin = CGPointMake(_nameLabel.x, _nameLabel.bottom+28*y_6_plus);
    _phoneLabel.frame = CGRectMake(_phoneV.right+20*x_6_plus, _phoneV.y, 200, 22);
    _phoneLabel.bottom = _phoneV.bottom;
    _addressLabel.frame = CGRectMake(_rV.x-30*x_6_plus-380*x_6_plus, _phoneV.y, 380*x_6_plus, 45*y_6_plus);
    _addressLabel.centerY = self.contentView.boundsCenter.y;
}

@end
