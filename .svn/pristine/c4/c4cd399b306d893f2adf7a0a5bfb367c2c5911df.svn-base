//
//  ServiceSettingCell.m
//  Merchant
//
//  Created by Wendy on 15/12/30.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "ServiceSettingCell.h"
@interface ServiceSettingCell()
{
    UILabel *label;
    UILabel *yuan;
}
@end
@implementation ServiceSettingCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat margin = 10;
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 13, 18, 18)];
        _iconImage.image = [UIImage imageNamed:@"sel_b hover"];
        [self.contentView addSubview:_iconImage];

        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_iconImage.right +5, 0, 150, 44)];
        _titleLab.text = @"更换机油";
        _titleLab.textColor = kColor666;
        _titleLab.font = V3_38PX_FONT;
        [self.contentView addSubview:_titleLab];

        _switchCtrl = [[UISwitch alloc] init];
        _switchCtrl.centerY = _titleLab.centerY;
        _switchCtrl.left = APP_WIDTH - 69;

        [self.contentView addSubview:_switchCtrl];
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(_titleLab.right, _titleLab.top, 60, 44)];
        label.textAlignment = NSTextAlignmentRight;
        label.right = _switchCtrl.left - 10;
        label.textColor = kColor666;
        label.font = V3_32PX_FONT;
        [self.contentView addSubview:label];
        
//        yuan = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH-margin-20, _titleLab.bottom, 20, 40)];
//        yuan.text = @"元";
//        yuan.font = V3_32PX_FONT;
//        yuan.textColor = kColor666;
//        [self.contentView addSubview:yuan];
//        
//        _manHourTF = [[UITextField alloc] initWithFrame:CGRectMake(label.right+5, _titleLab.bottom + 5, 100, 30)];
//        _manHourTF.keyboardType = UIKeyboardTypeDecimalPad;
//        _manHourTF.borderStyle = UITextBorderStyleRoundedRect;
//        [self.contentView addSubview:_manHourTF];
//        _manHourTF.right = yuan.left -5;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    
    return CGSizeMake(size.width, 80);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellBottom:(BOOL)status{
    label.hidden =status;
    yuan.hidden = status;
    _manHourTF.hidden = status;
}

- (void)setIconImageWithSid:(NSInteger)sid{
    if (sid == 6) {
        _iconImage.image = [UIImage imageNamed:@"sel_c hover"];
    }else if(sid == 7){
        _iconImage.image = [UIImage imageNamed:@"sel_b hover"];
    }else{
        _iconImage.image = [UIImage imageNamed:@"sel_a hover"];
    }
}
- (void)setManHourLabel:(NSString *)amout{
    if (amout.length == 0) {
        label.text = nil;
    }else{
        label.text = [NSString stringWithFormat:@"工时费:%@元",amout];
    }
}
@end
