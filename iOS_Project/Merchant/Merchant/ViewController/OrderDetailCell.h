//
//  OrderDetailCell.h
//  Merchant
//
//  Created by Wendy on 16/1/12.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *mainLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UILabel *rightLable;

- (void)setRightLabelPrice:(CGFloat)price amount:(NSString *)amount;
@end
