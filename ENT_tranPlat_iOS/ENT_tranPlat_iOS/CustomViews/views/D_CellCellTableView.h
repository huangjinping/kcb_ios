//
//  D_CellCellTableView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-11.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D_CellCell.h"

@class D_CellCellTableView;
@protocol D_CellCellTableViewDelegate <NSObject>

@optional
- (void)D_CellCellTableView:(D_CellCellTableView*)cellcellTableView didTapedCell:(D_CellCell*)cell;

- (void)D_CellCellTableView:(D_CellCellTableView*)cellcellTableView removeFriend:(NSString*)friendName onCell:(D_CellCell*)cell;
@end

@protocol D_CellCellTableViewDataSource <NSObject>

@required
- (NSInteger)D_CellCellTableView:(D_CellCellTableView*)cellcellTableView numberOfCellsInRow:(NSInteger)rowIndex;

- (NSInteger)numberOfRows;

- (CGFloat)D_CellCellTableView:(D_CellCellTableView*)cellcellTableView heightForRow:(NSInteger)rowIndex;

- (D_CellCell*)D_CellCellTableView:(D_CellCellTableView*)cellcellTableView cellForRow:(NSInteger)rowIndex indexForCell:(NSInteger)cellIndex;

@end

@interface D_CellCellTableView : UIScrollView<
D_CellCellDelegate,
UIScrollViewDelegate
>
{
    CGFloat                         _lastOffsetY;
    NSMutableDictionary             *_reuseCellsDict;
    
}



@property (nonatomic, assign)   id<D_CellCellTableViewDataSource>  dataSource_;
@property (nonatomic, assign)   id<D_CellCellTableViewDelegate>    delegate_;


- (void)reloadData_;
- (D_CellCell*)dequeueReusableD_CellWithIdentifier:(NSString*)identifier;
@end
