//
//  OrderPersonMessCell.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/3/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderPersonMessCell.h"

@implementation OrderPersonMessCell
{
    UILabel *_personLabel;
    UILabel *_phoneLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _personLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 38*y_6_plus)];
        _personLabel.font = V3_42PX_FONT;
        _personLabel.textColor = [UIColor colorWithHex:0x666666];
        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 38*y_6_plus)];
        _phoneLabel.font = V3_42PX_FONT;
        _phoneLabel.textColor = [UIColor colorWithHex:0x666666];
        
        [self.contentView addSubview:_personLabel];
        [self.contentView addSubview:_phoneLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _personLabel.origin = CGPointMake(60*x_6_plus, (self.contentView.height-(40+76)*y_6_plus)/2);
    _phoneLabel.origin = CGPointMake(_personLabel.x, _personLabel.bottom+40*y_6_plus);
}

- (void)setPerson:(NSString *)person{
    _personLabel.text = person;
}

- (void)setPhone:(NSString *)phone{
    _phoneLabel.text = phone;
}
@end
