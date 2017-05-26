//
//  PayRecordCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXPayRecordCell : UITableViewCell


@property (nonatomic, retain)   IBOutlet    UILabel *cellNumL;
@property (nonatomic, retain)   IBOutlet    UILabel *bxCompanyL;
@property (nonatomic, retain)   IBOutlet    UILabel *hphmL;
@property (nonatomic, retain)   IBOutlet    UILabel *jkstatusL;
@property (nonatomic, retain)   IBOutlet    UILabel *hbstatusL;
@property (nonatomic, retain)   IBOutlet    UILabel *timeL;

@property (nonatomic, retain)   IBOutlet    UILabel *line0L;
@property (nonatomic, retain)   IBOutlet    UILabel *line1L;

@property(nonatomic, retain) IBOutlet UIView *bgView;


@end
