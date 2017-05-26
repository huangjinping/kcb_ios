//
//  ServiceSettingCell.h
//  Merchant
//
//  Created by Wendy on 15/12/30.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESettingList.h"

@interface ServiceSettingCell : UITableViewCell
@property (nonatomic,retain)UIImageView *iconImage;
@property (nonatomic,retain)UILabel *titleLab;
@property (nonatomic,retain)UITextField *manHourTF;
@property (nonatomic,retain)UISwitch *switchCtrl;

- (void)setCellBottom:(BOOL)status;
- (void)setIconImageWithSid:(NSInteger)sid;

- (void)setManHourLabel:(NSString *)amout;
@end
