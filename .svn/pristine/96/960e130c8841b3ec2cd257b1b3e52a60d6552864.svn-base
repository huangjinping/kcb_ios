//
//  BillSearchCell.m
//  Merchant
//
//  Created by Wendy on 16/1/27.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "BillSearchCell.h"

@implementation BillSearchCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(10, 12, 60, 20);
        
        _button.titleLabel.font=  V3_30PX_FONT;
        [_button setBackgroundColor:kColor0X39B44A];
        [_button setImage:[UIImage imageNamed:@"list_mingxi"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor]];
        [_button setTitle:@"保养"];
        [self.contentView addSubview:_button];
        _button.enabled = NO;
//        _button.titleEdgeInsets = UIEdgeInsetsMake(0, _button.imageView.width, 0, -_button.imageView.width);

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_button.right +10, _button.top, 0, _button.height)];
        _titleLabel.font = V3_36PX_FONT;
        _titleLabel.text = @"奥迪A4 2014款 1.4T";
        _titleLabel.textColor = kColor0X949694;
        [self.contentView addSubview:_titleLabel];
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH-80, _titleLabel.top, 70, _titleLabel.height)];
        _amountLabel.text = @"+62600.00";
        _amountLabel.font = V3_34PX_FONT;
        _amountLabel.textColor = kColor0X666666;
        _amountLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.right = _amountLabel.left;
        [self.contentView addSubview:_amountLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
