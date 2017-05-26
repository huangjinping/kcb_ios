

//
//  ActivityLayout.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/25.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "ActivityLayout.h"

#define lineWidth 1

@implementation ActivityLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
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
    CGSize size = {0,0};
    CGPoint point = {0,0};
    if (indexPath.item == 0) {
        size = CGSizeMake(APP_WIDTH/2, 136*y_6_SCALE-lineWidth);
        point = CGPointMake(size.width/2, size.height/2+lineWidth);
    }else if (indexPath.item == 1){
        size = CGSizeMake(APP_WIDTH/2, 136*y_6_SCALE-lineWidth);
        point = CGPointMake(APP_WIDTH*3/4, size.height/2+lineWidth);
    }else{
        size = CGSizeMake(APP_WIDTH, 125*y_6_SCALE-lineWidth);
        point = CGPointMake(APP_WIDTH/2, 136*y_6_SCALE+125*y_6_SCALE/2+lineWidth);
    }
    attributes.size = size;
    attributes.center = point;
    
    return attributes;
}

@end
