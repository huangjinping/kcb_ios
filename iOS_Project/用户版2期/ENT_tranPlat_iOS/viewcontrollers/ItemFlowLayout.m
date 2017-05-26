



//
//  ItemFlowLayout.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/7.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "ItemFlowLayout.h"

@implementation ItemFlowLayout
{
    UICollectionViewLayoutAttributes *_tempAttrbutes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *visibleIndexPaths = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *marr = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attributes in visibleIndexPaths) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            UICollectionViewLayoutAttributes *newAttributes = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
            [marr addObject:newAttributes];
        } else {
            [marr addObject:attributes];
        }
    }
    
    return marr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    attributes.size = self.itemSize;
    
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(attributes.center.x, attributes.center.y);
    return attributes;
}


- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(attributes.center.x,attributes.center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

@end
