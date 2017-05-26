//
//  D_CellCellTableView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-11.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "D_CellCellTableView.h"

@implementation D_CellCellTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _reuseCellsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        _lastOffsetY = 0;
        self.delegate = self;
    }
    return self;
}

- (id)init{
    if (self = [super init]) {

        _reuseCellsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        _lastOffsetY = 0;
        self.delegate = self;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self reloadData_];
}


- (void)setDataSource_:(id<D_CellCellTableViewDataSource>)dataSource_{
    _dataSource_ = dataSource_;
    
    [self reloadData_];
}


- (void)reloadData_{
    
    [_reuseCellsDict removeAllObjects];
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    NSInteger rows = [self.dataSource_ numberOfRows];
    CGFloat sumRowHeight = 0;
    for (int i = 0; i < rows; i ++) {
        
        
        
        CGFloat rowHeight = [self.dataSource_ D_CellCellTableView:self heightForRow:i];
        
        
        if(sumRowHeight < self.frame.size.height + self.contentOffset.y){
        
            //table 添加cell
            NSInteger cells = [self.dataSource_ D_CellCellTableView:self numberOfCellsInRow:i];
            for (int j = 0; j < cells; j ++) {
                //从datasource获取cell填充table
                D_CellCell *cell = [self.dataSource_ D_CellCellTableView:self cellForRow:i indexForCell:j];
                
                //此处暂时固定 cells
                //cell.frame = CGRectMake(j*(self.width/cells), i*rowHeight, self.width/cells, rowHeight);
                cell.frame = CGRectMake(j*(self.width/3), i*rowHeight, self.width/3, rowHeight);
                cell.contentView.frame = cell.bounds;
                //ENTLog(@"cell.frame.origin.x = %f, cell.frame.origin.y = %f", cell.frame.origin.x, cell.frame.origin.y);
                cell.delegate_ = self;
                [self addSubview:cell];
                
                //加入复用cells数组
                if (![_reuseCellsDict objectForKey:cell.identifier]) {
                    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
                    [_reuseCellsDict setObject:arr forKey:cell.identifier];
                }
                [[_reuseCellsDict objectForKey:cell.identifier] addObject:cell];
                
            }
        }
            
        
        sumRowHeight += rowHeight;
        
        
        
    }
    
    [self setContentSize:CGSizeMake(self.width, sumRowHeight)];
}

- (D_CellCell*)dequeueReusableD_CellWithIdentifier:(NSString *)identifier{

    NSMutableArray *cells = [_reuseCellsDict objectForKey:identifier];
    //ENTLog(@"cells array .count ==%d", cells.count);
    
    if (cells) {
        
        for (D_CellCell *cell in cells) {
            CGFloat yStart = self.contentOffset.y;
            CGFloat yEnd = self.height + self.contentOffset.y;
            if (cell.frame.origin.y + cell.height <= yStart || cell.frame.origin.y >= yEnd) {
                for (UIView *v in cell.contentView.subviews) {
                    [v removeFromSuperview];
                }
                return cell;
            }
        }
        
//        D_CellCell *cell = nil;
//        if (self.contentOffset.y >= _lastOffsetY || self.contentOffset.y == 0) {//向上滑
//            
//            cell = [cells objectAtIndex:0];
//           
//            
//        }else{
//             cell = [cells lastObject];
//        }
//        _lastOffsetY = self.contentOffset.y;
//
//        if (cell.frame.origin.y + cell.height < self.contentOffset.y){//当前cell不在屏幕内
//            for (UIView *v in cell.contentView.subviews) {
//                [v removeFromSuperview];
//            }
//            NSArray *arr = [NSArray arrayWithObjects:cell, nil];
//            [cells removeObject:cell];
//            
//            return [arr lastObject];
//            //return [[D_CellCell alloc] initWithIdentifier:identifier];
//        }
    }
    
    return nil;
}





- (void)D_CellCell:(D_CellCell *)cell beTaped:(UITapGestureRecognizer *)tap{
    if ([self.delegate_ respondsToSelector:@selector(D_CellCellTableView:didTapedCell:)]) {
        [self.delegate_ D_CellCellTableView:self didTapedCell:cell];
    }
}

- (void)D_CellCell:(D_CellCell *)cell removeFriend:(NSString *)friendName{
    if ([self.delegate_ respondsToSelector:@selector(D_CellCellTableView:removeFriend:onCell:)]) {
        [self.delegate_ D_CellCellTableView:self removeFriend:friendName onCell:cell];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
