//
//  UcarpenccanCell.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/1/18.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UcarpenccanCell : UITableViewCell
@property(nonatomic, retain) IBOutlet UILabel       *wfsjL;//时间
@property(nonatomic, retain) IBOutlet UILabel       *wfddL;//地点
@property(nonatomic, retain) IBOutlet UILabel       *wfxwL;//行为
@property(nonatomic, retain) IBOutlet UILabel       *cfbzL;//处罚标准



@property(nonatomic, retain) IBOutlet UIView        *bgView;
@property(nonatomic, retain) IBOutlet UILabel       *line1;




@property(nonatomic, retain) IBOutlet UILabel       *wfsjLabelLabel;//时间
@property(nonatomic, retain) IBOutlet UILabel       *wfddLabelLabel;//地点
@property(nonatomic, retain) IBOutlet UILabel       *wfxwLabelLabel;//行为
@property(nonatomic, retain) IBOutlet UILabel       *cfbzLabelLabel;//处罚标准
@end
