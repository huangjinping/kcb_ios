//
//  MaintenanceHeaderCell.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/20.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MaintenanceHeaderCell.h"
#import "UILabel+Custom.h"

@implementation MaintenanceHeaderCell
{
    UIView *_line;
    UIButton *_icon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 930*x_6_plus, 45*y_6_plus)
                                               text:nil
                                               font:V3_46PX_FONT
                                          textColor:kTextGreenColor];
        _subNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 930*x_6_plus, 40*y_6_plus)
                                               text:nil
                                               font:V3_38PX_FONT
                                          textColor:kTextGreenColor];
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120*x_6_SCALE, 48*y_6_plus)
                                                   text:nil
                                                   font:V3_36PX_FONT
                                              textColor:[UIColor colorWithHex:0x949694]];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 450*x_6_plus, 48*y_6_plus)
                                               text:nil
                                               font:V3_36PX_FONT
                                          textColor:[UIColor colorWithHex:0x949694]];
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _icon.frame = CGRectMake(0, 0, 47*x_6_plus, 44*y_6_plus);
        [_icon setImage:[UIImage imageNamed:@"bangyang_edit"] forState:UIControlStateNormal];
        [_icon addActionBlock:^(id weakSender) {
            if (_block) {
                _block();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        _line = [self.contentView addLineWithFrame:CGRectMake(0, 0, 1, 30*y_6_plus) lineColor:kLineGrayColor];
    
    
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_subNameLabel];
        [self.contentView addSubview:_distanceLabel];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_line];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _nameLabel.origin = CGPointMake(51*x_6_plus, 30*y_6_plus);
    if ([_subNameLabel.text isLegal]) {
        _subNameLabel.origin = CGPointMake(_nameLabel.x, _nameLabel.bottom+15*y_6_plus);
        _distanceLabel.origin = CGPointMake(_nameLabel.x, _subNameLabel.bottom+25*y_6_plus);
    }else{
        _distanceLabel.origin = CGPointMake(_nameLabel.x, _nameLabel.bottom+55*y_6_plus);
    }

    _line.origin = CGPointMake(_distanceLabel.right+10*x_6_plus, _distanceLabel.y+10*y_6_plus);
    _timeLabel.origin = CGPointMake(_line.right+30*x_6_plus, _distanceLabel.y);
    _icon.origin = CGPointMake(_timeLabel.right, 0);
    _icon.centerY = _timeLabel.centerY;
}

@end
