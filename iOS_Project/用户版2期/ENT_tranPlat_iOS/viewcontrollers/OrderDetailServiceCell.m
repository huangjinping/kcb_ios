//
//  OrderDetailServiceCell.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/28.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderDetailServiceCell.h"

@implementation OrderDetailServiceCell
{
    UILabel *_serviceLabel;
    UIImageView *_icon;
    UILabel *_contentLabel;
    UILabel *_priceLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*x_6_plus, 46*y_6_plus)];
        _serviceLabel.text = @"服务项目:";
        _serviceLabel.textColor = kTextGrayColor;
        _serviceLabel.font = V3_38PX_FONT;
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 49*x_6_plus, 49*x_6_plus)];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 700*x_6_plus, 48*y_6_plus)];
        _contentLabel.font = V3_38PX_FONT;
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300*x_6_plus, 49*y_6_plus)];
        _priceLabel.font = V3_38PX_FONT;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        
        
        [self.contentView addSubview:_serviceLabel];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_priceLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _serviceLabel.origin = CGPointMake(40*x_6_plus, 0);
    _serviceLabel.centerY = self.contentView.boundsCenter.y;
    _icon.origin = CGPointMake(_serviceLabel.right, 0);
    _icon.centerY = self.contentView.boundsCenter.y;
    _contentLabel.origin = CGPointMake(_icon.right+15*x_6_plus, 0);
    _contentLabel.centerY = self.contentView.boundsCenter.y;
    _priceLabel.origin = CGPointMake(APP_WIDTH-40*x_6_plus-300*x_6_plus, 0);
    _priceLabel.centerY = self.contentView.boundsCenter.y;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPrice:(NSString *)price{
    NSString *str = [NSString stringWithFormat:@"工时费:￥%@",price];
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttributes:@{NSFontAttributeName:V3_38PX_FONT,NSForegroundColorAttributeName:kTextGrayColor} range:NSMakeRange(0, 4)];
    [mStr addAttributes:@{NSFontAttributeName:V3_38PX_FONT,NSForegroundColorAttributeName:kTextOrangeColor} range:NSMakeRange(4,str.length-4)];
    _priceLabel.attributedText = mStr;
}

- (void)setServiceName:(NSString *)serviceName{
    _contentLabel.text = serviceName;
}

- (void)setServiceId:(NSNumber *)serviceId{
    switch ([serviceId integerValue]) {
        case 8:                                                             //小保养
            _icon.image = [UIImage imageNamed:@"sel_a hover"];
            break;
        case 7:                                                             //更换空滤
            _icon.image = [UIImage imageNamed:@"sel_b hover"];

            break;
        case 6:                                                             //更换机滤
            _icon.image = [UIImage imageNamed:@"sel_c hover"];

        default:
            break;
    }
}

- (void)setHidden:(BOOL)hidden{
    _serviceLabel.hidden = hidden;
}

@end
