//
//  OrderSortLayout.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/25.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderSortLayout.h"

@implementation OrderSortLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *visibleIndexPaths = [super layoutAttributesForElementsInRect:rect];
    for (int i = 1; i<visibleIndexPaths.count; i++) {
        UICollectionViewLayoutAttributes *currentAtt = visibleIndexPaths[i];
        UICollectionViewLayoutAttributes *preAtt = visibleIndexPaths[i-1];
        CGRect frame = currentAtt.frame;
        frame.origin.x = CGRectGetMaxX(preAtt.frame)+_maxItemSpacing;
        currentAtt.frame = frame;
    }
    
    return visibleIndexPaths;
}

@end
