//
//  MaintenanceHeaderCell.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/20.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaintenanceHeaderCell : UITableViewCell

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *subNameLabel;
@property (nonatomic, strong)UILabel *distanceLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, copy)void(^block)(void);

@end
