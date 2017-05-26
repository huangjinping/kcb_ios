//
//  PayRecordCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayRecordCell : UITableViewCell


@property (nonatomic, retain)   IBOutlet    UILabel *cellNumL;
@property (nonatomic, retain)   IBOutlet    UILabel *payNumL;
@property (nonatomic, retain)   IBOutlet    UILabel *payTimeL;
@property (nonatomic, retain)   IBOutlet    UILabel *costL;
@property (nonatomic, retain)   IBOutlet    UILabel *payStatusL;

@property (nonatomic, retain)   IBOutlet    UILabel *line0L;
@property (nonatomic, retain)   IBOutlet    UILabel *line1L;

@property(nonatomic, retain) IBOutlet UIView *bgView;


@end
