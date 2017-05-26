//
//  OrderStateCell.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/3.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderStateCell.h"
#import "UILabel+Custom.h"

@implementation OrderStateCell
{
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UILabel *_dateLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 830*x_6_plus, 60*y_6_plus)
                                               text:@"已评价"
                                               font:V3_38PX_FONT
                                          textColor:[UIColor blackColor]];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 830*x_6_plus, 60*y_6_plus)
                                                 text:@"感谢您的评价，期望下一次为您服务"
                                                 font:V3_30PX_FONT
                                            textColor:[UIColor blackColor]];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 470*x_6_plus, 60*y_6_plus)
                                               text:@"2016-01-10 12:34"
                                               font:V3_30PX_FONT
                                          textColor:kTextGrayColor];
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _icon.frame = CGRectMake(0, 0, 49*x_6_plus, 49*x_6_plus);
        [_icon setBackgroundImage:[UIImage imageNamed:@"sel02"] forState:UIControlStateNormal];
        [_icon setBackgroundImage:[UIImage imageNamed:@"sel01"] forState:UIControlStateSelected];
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_icon];
        _line = [self.contentView addLineWithFrame:CGRectMake(0, 0, 3*x_6_plus, 0) lineColor:kLineGrayColor];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _icon.origin = CGPointMake(120*x_6_plus, 0);
    _nameLabel.origin = CGPointMake(_icon.right+40*x_6_plus, 0);
    _contentLabel.origin = CGPointMake(_nameLabel.x, _nameLabel.bottom+10*y_6_plus);
    _dateLabel.origin = CGPointMake(_nameLabel.x, _contentLabel.bottom+28*y_6_plus);
    _line.origin = CGPointMake(0, _icon.bottom);
    _line.height = self.contentView.height-_icon.height;
    _line.centerX = _icon.centerX;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithDic:(NSDictionary *)dic{
//    if ([dic[@"status"] isLegal]) {
//        switch ([dic[@"status"] integerValue]) {
//            case 0:
//                _nameLabel.text = @"订单提交成功";
//                
//                break;
//            case 1:
//                _nameLabel.text = @"等待商家接单";
//                
//                break;
//            case 2:
//                _nameLabel.text = @"已确认";
//                
//                break;
//            case 3:
//                _nameLabel.text = @"等待评价";
//                
//                break;
//            case 4:
//                _nameLabel.text = @"已评价";
//                
//                break;
//            case 5:
//                _nameLabel.text = @"退款中";
//                
//                break;
//            case 6:
//                _nameLabel.text = @"已退款";
//                
//                break;
//                
//            default:
//                break;
//        }
//    }
    _nameLabel.text = dic[@"type"];
    _contentLabel.text = dic[@"remarks"];
    _dateLabel.text = dic[@"dealTime"];
}

@end
