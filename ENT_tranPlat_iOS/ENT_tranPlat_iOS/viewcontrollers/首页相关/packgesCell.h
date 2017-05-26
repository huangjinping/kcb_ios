//
//  packgesCell.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/8/26.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaoYangServiewModel.h"



@class BaoYangModel;
//@class BaoYangServiewModel;
@interface packgesCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UILabel       *nameLabel;
@property (strong, nonatomic) UISwitch      *switchChoes;
@property (strong, nonatomic) UITableView   *downTabView;
@property (nonatomic, strong) UIView        *view;
@property (nonatomic, strong) UILabel       *lineL;

@property (nonatomic, strong) NSMutableArray <BaoYangServiewModel>*datas;
@property (nonatomic, strong) BaoYangModel  *model;

@property (nonatomic, strong) UIButton      *btn;//选择按钮
@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, assign) NSInteger     H;//小表高度

@property (nonatomic,strong) NSIndexPath    *indexPath;


@end
