//
//  ScrollItemView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "ScrollItemView.h"
#import "ScrollItemCell.h"

@interface ScrollItemView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

static NSString *cellId = @"cellId";

@implementation ScrollItemView
{
    UICollectionView *_collectionView;
}

- (ScrollItemView *)initWithItems:(NSArray *)items{
    _items = [items copy];
    ScrollItemView *sv = [[ScrollItemView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 44*y_6_SCALE)];
    
    sv.items = items;

    [_collectionView reloadData];
    
    return sv;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [NSArray array];
        self.backgroundColor = kWhiteColor;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.width/3, self.width/2);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[ScrollItemCell class] forCellWithReuseIdentifier:cellId];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_collectionView];
    }
    
    return self;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[ScrollItemCell alloc]init];
    }
    
    return cell;
}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.items.count == 1) {
//        return CGSizeMake(collectionView.width/2, collectionView.height);
//    }
//    
//    return CGSizeMake(collectionView.width/3, collectionView.height);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollItemCell *cell = (ScrollItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.res = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollItemCell *cell = (ScrollItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.res = NO;
}

@end
