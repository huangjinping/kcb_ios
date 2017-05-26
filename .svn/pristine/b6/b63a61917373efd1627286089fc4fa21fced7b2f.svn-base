//
//  SelectMaintenanceCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/8.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "SelectMaintenanceCell.h"

@implementation SelectMaintenanceCell
{
    UILabel *_nameLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _icon.frame = CGRectMake(0, 0, 49*x_6_plus, 49*x_6_plus);
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50*y_6_SCALE)];
        _nameLabel.font = V3_42PX_FONT;
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _rightV = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightV addActionBlock:^(id weakSender) {
            if (_commplete) {
                _commplete();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_rightV setImage:[UIImage imageNamed:@"car_default hover"] forState:UIControlStateNormal];
        [_rightV setImage:[UIImage imageNamed:@"car_default"] forState:UIControlStateSelected];

        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_rightV];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _icon.origin = CGPointMake(45*x_6_plus, 0);
    _icon.centerY = self.contentView.boundsCenter.y;
    _nameLabel.origin = CGPointMake(_icon.right+20*x_6_plus, 0);
    _nameLabel.centerY = self.contentView.boundsCenter.y;
    _rightV.frame = CGRectMake(self.contentView.width-15*x_6_SCALE-20*x_6_SCALE, 0, 20*x_6_SCALE, 20*x_6_SCALE);
    _rightV.centerY = self.contentView.boundsCenter.y;
}

- (void)configCellWith:(NSDictionary *)dic{
    _typeId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    switch ([_typeId integerValue]) {
        case 8:                                                             //小保养
            [_icon setImage:[UIImage imageNamed:@"sel_a hover"] forState:UIControlStateSelected];
            [_icon setImage:[UIImage imageNamed:@"sel_a"] forState:UIControlStateNormal];
            break;
        case 7:                                                             //更换空滤
            [_icon setImage:[UIImage imageNamed:@"sel_c hover"] forState:UIControlStateSelected];
            [_icon setImage:[UIImage imageNamed:@"sel_c"] forState:UIControlStateNormal];
            break;
        case 6:                                                             //更换机滤
            [_icon setImage:[UIImage imageNamed:@"sel_b hover"] forState:UIControlStateSelected];
            [_icon setImage:[UIImage imageNamed:@"sel_b"] forState:UIControlStateNormal];
        default:
            break;
    }
    
    _nameLabel.text = dic[@"name"];
    
    if([dic.allKeys containsObject:@"phone"]) {
        _nameLabel.text = dic[@"phone"];
       // [_rightV setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
    }else if([dic.allKeys containsObject:@"address"]){
        _nameLabel.text = dic[@"address"];
       // [_rightV setBackgroundImage:[UIImage imageNamed:@"zb"] forState:UIControlStateNormal];
    }
}

@end
