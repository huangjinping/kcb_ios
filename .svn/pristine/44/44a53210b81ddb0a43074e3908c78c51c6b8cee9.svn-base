
//
//  MyViewLayout.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/23.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "MyViewLayout.h"

@implementation MyViewLayout
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
    if (indexPath.item == 0) {
        attributes.center = CGPointMake(self.sectionInset.left+self.minimumInteritemSpacing/2+self.itemSize.width/2,self.sectionInset.top+self.minimumLineSpacing/2+self.itemSize.height/2);
        
        return attributes;
    }
    NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *preAttributes = [self layoutAttributesForItemAtIndexPath:preIndexPath];

    if (attributes.center.y < preAttributes.size.height+preAttributes.center.y) {
        attributes.center = CGPointMake(preAttributes.center.x+self.itemSize.width+self.minimumInteritemSpacing, preAttributes.center.y);
    }else{
        attributes.center = CGPointMake(self.sectionInset.left+self.minimumInteritemSpacing/2+self.itemSize.width/2, preAttributes.center.y+self.itemSize.height+self.minimumLineSpacing);
    }
    
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
