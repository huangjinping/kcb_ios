//
//  FittingsCell.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface FittingsCell : MGSwipeTableCell

@property (nonatomic, strong)NSString *serviceName;
@property (nonatomic, strong)UIButton *rV;

@property (nonatomic, strong)NSString *volume;              //容量
@property (nonatomic, strong)NSString *merid;               //渠道商ID
@property (nonatomic, strong)NSString *typeId;              //服务ID
@property (nonatomic, strong)NSString *groupid;             //配件类型
@property (nonatomic, strong)NSNumber *price;               //价格
@property (nonatomic, strong)NSNumber *num;                 //数量
@property (nonatomic, strong)NSString *groupname;

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *stateLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *numLabel;
- (void)configCellWithDic:(NSDictionary *)dic;
- (void)UconfigCellWithDic:(NSDictionary *)dic;
@end
