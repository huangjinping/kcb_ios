//
//  OrderStateCell.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/3.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStateCell : UITableViewCell

@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIButton *icon;

- (void)configWithDic:(NSDictionary *)dic;

@end
