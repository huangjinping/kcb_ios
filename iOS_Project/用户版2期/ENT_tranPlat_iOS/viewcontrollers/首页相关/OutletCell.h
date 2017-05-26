//
//  OutletCell.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface OutletCell : UITableViewCell

@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)UIImageView *rV;

- (void)configCellWithDic:(NSDictionary *)dic;

@end
