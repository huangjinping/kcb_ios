//
//  listCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/8/26.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "listCell.h"
#import "listModel.h"
@implementation listCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(listModel *)model
{
    _nameLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"%@元",model.actualPrice];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
