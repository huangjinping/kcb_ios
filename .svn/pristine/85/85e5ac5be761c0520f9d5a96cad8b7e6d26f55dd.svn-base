//
//  OrderTypeCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderTypeCell.h"
#import "UILabel+Custom.h"

@implementation OrderTypeCell
{
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    
    UIView *_line;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*x_6_SCALE, 22)
                                              text:nil
                                              font:V3_38PX_FONT
                                         textColor:[UIColor blackColor]];
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200*x_6_SCALE, 22)
                                               text:nil
                                               font:V3_42PX_FONT
                                          textColor:kTextOrangeColor];
        
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _line = [self.contentView addLineWithFrame:CGRectMake(0, 0, APP_WIDTH, 1) lineColor:kLineGrayColor];
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_priceLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _nameLabel.origin = CGPointMake(40*x_6_plus, 0);
    _nameLabel.centerY = self.contentView.boundsCenter.y;
    _priceLabel.origin = CGPointMake(APP_WIDTH-40*x_6_plus-_priceLabel.width, 0);
    _priceLabel.centerY = self.contentView.boundsCenter.y;
}

- (void)setName:(NSString *)name{
    _name = name;
    _nameLabel.text = name;
}

-(void)setPrice:(NSString *)price{
    _price = price;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
}

@end
