//
//  listCell.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/8/26.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class listModel;
@interface listCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) listModel *model;
@end
