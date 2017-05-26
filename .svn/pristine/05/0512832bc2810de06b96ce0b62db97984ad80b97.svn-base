//
//  ActivityLayout.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/25.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "ActivityLayout.h"

#define lineWidth .5f

@implementation ActivityLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *layoutArr = [@[] mutableCopy];
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            UICollectionViewLayoutAttributes *newArributes = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
            [layoutArr addObject:newArributes];
        }else{
            [layoutArr addObject:attributes];
        }
    }
    
    return layoutArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGSize size = self.itemSize;
    CGPoint point = {0,0};
    
    if (indexPath.item == 0) {
        point = CGPointMake(self.itemSize.width/2, self.itemSize.height/2);
    }else{
        point = CGPointMake(self.itemSize.width*3/2+lineWidth, self.itemSize.height/2);
    }
    attributes.size = size;
    attributes.center = point;
    
    return attributes;
}

@end
