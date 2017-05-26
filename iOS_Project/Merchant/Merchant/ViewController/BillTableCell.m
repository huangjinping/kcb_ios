//
//  BillTableCell.m
//  Merchant
//
//  Created by Wendy on 16/1/7.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "BillTableCell.h"

@implementation BillTableCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.contentView.layer.borderWidth = 0.5;
        
        CGFloat margin = 8;
        CGFloat itemWidth = (APP_WIDTH-16)/3;
        CGFloat itemHeight = 44;
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, itemWidth, itemHeight)];
        _typeLabel.layer.borderWidth = 0.5;
        _typeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = kColor0X666666;
        [self.contentView addSubview:_typeLabel];
        
        _orderCountLable = [[UILabel alloc] initWithFrame:CGRectMake(_typeLabel.right, 0, itemWidth, itemHeight)];
        _orderCountLable.layer.borderWidth = 0.5;
        _orderCountLable.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _orderCountLable.textAlignment = NSTextAlignmentCenter;
        _orderCountLable.textColor = kColor0X666666;
        [self.contentView addSubview:_orderCountLable];

        _imcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_orderCountLable.right, 0, itemWidth, itemHeight)];
        _imcomeLabel.layer.borderWidth = 0.5;
        _imcomeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imcomeLabel.textAlignment = NSTextAlignmentCenter;
        _imcomeLabel.textColor = kColor0X666666;
        [self.contentView addSubview:_imcomeLabel];

        
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
