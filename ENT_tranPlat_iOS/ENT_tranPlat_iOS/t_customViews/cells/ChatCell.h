//
//  ChatCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell


@property (nonatomic, retain)  IBOutlet  UILabel *nameL;
@property (nonatomic, retain)  IBOutlet  UILabel *timeL;
@property (nonatomic, retain)  IBOutlet  UILabel *phoneTypeL;
@property (nonatomic, retain)  IBOutlet  UILabel *contentL;
@property (nonatomic, retain)  IBOutlet  UILabel *liulanL;
@property (nonatomic, retain)  IBOutlet  UILabel *zanCountL;
@property (nonatomic, retain)  IBOutlet  UIImageView *portraitImgView;
@property (nonatomic, retain)  IBOutlet  UIImageView *zanImgView;
@property (nonatomic, retain)  IBOutlet  UIImageView *pinglunImgView;
@property (nonatomic, retain)  IBOutlet  UIButton *zanB;
@property (nonatomic, retain)  IBOutlet  UIButton *pinglunB;


@end
