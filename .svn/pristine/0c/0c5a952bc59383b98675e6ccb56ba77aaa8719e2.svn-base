
//
//  RegisterInfoCell.m
//  Merchant
//
//  Created by xinpenghe on 15/12/22.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "RegisterInfoCell.h"

@implementation RegisterInfoCell
{
    UITextField *_nameFiled;
    UIImageView *_icon;
    UITapGestureRecognizer *_tap;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameFiled = [[UITextField alloc]init];
        [self.contentView addSubview:_nameFiled];
        
        _icon = [[UIImageView alloc]init];
        _icon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_icon];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction)];
        [self.contentView addGestureRecognizer:_tap];
    }
    return self;
}

- (void)selectAction{
    if (_commplete) {
        NSString *str = [_nameFiled.placeholder isEqualToString:@"支付账号类型"]?@"请选择支付账号类型":
                        [_nameFiled.placeholder isEqualToString:@"所属城市"]?@"请选择城市":@"";
        _commplete(str);
    }
}

- (void)configInfoWithDic:(NSDictionary *)dic{
    _nameFiled.placeholder = dic[@"name"];
    _tap.enabled = !![dic[@"select"] integerValue];
    _icon.hidden = _nameFiled.enabled = !_tap.enabled;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _nameFiled.frame = LGRectMake(10, 0, 200, 20);
    _nameFiled.centerY = self.contentView.boundsCenter.y;
    
    _icon.frame = LGRectMake(APP_WIDTH/PX_X_SCALE-25, 0, 20, 20);
    _icon.centerY = self.contentView.boundsCenter.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
