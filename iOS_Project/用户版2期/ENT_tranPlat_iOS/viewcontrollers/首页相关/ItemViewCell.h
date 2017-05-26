//
//  ItemViewCell.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/23.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewCell : UICollectionViewCell

@property (nonatomic, strong)UIButton *icon;
@property (nonatomic, strong)UILabel *l;

@property (nonatomic, copy)void(^commplete)(NSInteger);

@end
