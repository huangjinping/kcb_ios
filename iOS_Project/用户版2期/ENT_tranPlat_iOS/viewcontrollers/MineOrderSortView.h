//
//  MineOrderSortView.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/14.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MineOrderSortView;
@protocol MineOrderSortViewDelegate <NSObject>

- (void)didSelectItem:(MineOrderSortView *)sortView atIndex:(NSInteger)path;

@end

@interface MineOrderSortView : UIView

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) id<MineOrderSortViewDelegate>delegate;

+ (MineOrderSortView *)shareOrderSortView;

@end
