//
//  PeccancyRecordCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-18.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeccancyRecordCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *sNumL;


@property(nonatomic, retain) IBOutlet UILabel       *cjjgL;//采集机关
@property(nonatomic, retain) IBOutlet UILabel       *wfsjL;//时间
@property(nonatomic, retain) IBOutlet UILabel       *wfddL;//地点
@property(nonatomic, retain) IBOutlet UILabel       *wfxwL;//行为
@property(nonatomic, retain) IBOutlet UILabel       *cfbzL;//处罚标准


@property(nonatomic, retain) IBOutlet UIButton *payButton;
@property(nonatomic, retain) IBOutlet UIButton *checkPingzhengButton;

@property(nonatomic, retain) IBOutlet UIButton *checkPhotoButton;
@property(nonatomic, retain) IBOutlet UIButton *dealPeccancyButton;

@property(nonatomic, retain) IBOutlet UIView        *bgView;
@property(nonatomic, retain) IBOutlet UILabel       *line1;
@property(nonatomic, retain) IBOutlet UILabel       *line2;
@property(nonatomic, retain) IBOutlet UILabel       *line3;
@property(nonatomic, retain) IBOutlet UILabel       *lineVertical;

@property(nonatomic, retain) IBOutlet UILabel       *cjjgLabelLabel;//采集机关
@property(nonatomic, retain) IBOutlet UILabel       *wfsjLabelLabel;//时间
@property(nonatomic, retain) IBOutlet UILabel       *wfddLabelLabel;//地点
@property(nonatomic, retain) IBOutlet UILabel       *wfxwLabelLabel;//行为
@property(nonatomic, retain) IBOutlet UILabel       *cfbzLabelLabel;//处罚标准


@end
