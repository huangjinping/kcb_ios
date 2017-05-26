//
//  OrderAppraiseCell.m
//  Merchant
//
//  Created by Wendy on 16/1/15.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "OrderAppraiseCell.h"

@implementation OrderAppraiseCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat margin = 25;
        CGFloat width = (APP_WIDTH - margin*5)/4;
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, width, width)];
        [self.contentView addSubview:_image1];

        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(_image1.right+margin, margin, width, width)];
        [self.contentView addSubview:_image2];

        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(_image2.right+margin, margin, width, width)];
        [self.contentView addSubview:_image3];

        _image4 = [[UIImageView alloc] initWithFrame:CGRectMake(_image3.right+margin, margin, width, width)];
        [self.contentView addSubview:_image4];

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
