//
//  MaintenanceCalendarCell.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaintenanceCalendarCell : UITableViewCell

@property(nonatomic, copy)void(^commplete)(NSDate *);

@end
